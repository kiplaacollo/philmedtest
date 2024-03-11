table 409 "SMTP Mail Setup"
{
    Caption = 'SMTP Mail Setup';
    Permissions = TableData "Service Password" = rimd;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "SMTP Server"; Text[250])
        {
            Caption = 'SMTP Server';
        }
        field(3; Authentication; Option)
        {
            Caption = 'Authentication';
            OptionCaption = 'Anonymous,NTLM,Basic';
            OptionMembers = Anonymous,NTLM,Basic;

            trigger OnValidate()
            begin
                if Authentication <> Authentication::Basic then begin
                    "User ID" := '';
                    SetPassword('');
                end;

                if Authentication = Authentication::Anonymous then
                    "Allow Sender Substitution" := true;
            end;
        }
        field(4; "User ID"; Text[250])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;

            trigger OnValidate()
            begin
                "User ID" := DelChr("User ID", '<>', ' ');
                if "User ID" = '' then
                    exit;
                TestField(Authentication, Authentication::Basic);
            end;
        }
        field(6; "SMTP Server Port"; Integer)
        {
            Caption = 'SMTP Server Port';
            InitValue = 25;
        }
        field(7; "Secure Connection"; Boolean)
        {
            Caption = 'Secure Connection';
            InitValue = false;
        }
        field(8; "Password Key"; Guid)
        {
            Caption = 'Password Key';
        }
        field(9; "Send As"; Text[250])
        {
            Caption = 'Send As';
        }
        field(10; "Allow Sender Substitution"; Boolean)
        {
            Caption = 'Allow Sender Substitution';
        }
        field(11; "Path to Save Invoices"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Path to Save Receipts"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Path to Save Payslips"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Path to Save RFQs"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure GetSetup(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        if not Get then begin
            if not WritePermission then begin
                MailManagement.GetSMTPCredentials(Rec);
                exit("SMTP Server" <> '');
            end;
            Init;
            Insert;
        end;

        if "SMTP Server" = '' then
            MailManagement.GetSMTPCredentials(Rec);

        exit("SMTP Server" <> '');
    end;

    procedure SetPassword(NewPassword: Text)
    var
        ServicePassword: Record "Service Password";
    begin
        if IsNullGuid("Password Key") or not ServicePassword.Get("Password Key") then begin
            ServicePassword.SavePassword(NewPassword);
            ServicePassword.Insert(true);
            "Password Key" := ServicePassword.Key;
        end else begin
            ServicePassword.SavePassword(NewPassword);
            ServicePassword.Modify;
        end;
    end;

    procedure GetPassword(): Text
    var
        ServicePassword: Record "Service Password";
    begin
        if not IsNullGuid("Password Key") then
            if ServicePassword.Get("Password Key") then
                exit(ServicePassword.GetPassword);
        exit('');
    end;

    procedure HasPassword(): Boolean
    begin
        exit(GetPassword <> '');
    end;

    procedure RemovePassword()
    var
        ServicePassword: Record "Service Password";
    begin
        if not IsNullGuid("Password Key") then begin
            if ServicePassword.Get("Password Key") then
                ServicePassword.Delete(true);

            Clear("Password Key");
        end;
    end;

    procedure GetSender(): Text[250]
    begin
        if "Send As" = '' then
            "Send As" := "User ID";

        exit("Send As");
    end;

    procedure GetConnectionString(): Text[250]
    begin
        if GetSender = "User ID" then
            exit("User ID");

        exit(CopyStr(StrSubstNo('%1\%2', "User ID", "Send As"), 1, MaxStrLen("User ID")));
    end;

    procedure SplitUserIdAndSendAs(ConnectionString: Text[250])
    var
        MailManagement: Codeunit "Mail Management";
        AtLocation: Integer;
        SlashLocation: Integer;
    begin
        ConnectionString := DelChr(ConnectionString);
        if (ConnectionString = '') or MailManagement.CheckValidEmailAddress(ConnectionString) then begin
            "User ID" := ConnectionString;
            "Send As" := ConnectionString;
            exit;
        end;

        AtLocation := StrPos(ConnectionString, '@');

        if AtLocation > 0 then begin
            SlashLocation := StrPos(ConnectionString, '\');
            if SlashLocation > AtLocation then begin
                "User ID" := CopyStr(ConnectionString, 1, SlashLocation - 1);
                "Send As" := CopyStr(ConnectionString, SlashLocation + 1);
                if MailManagement.CheckValidEmailAddress("User ID") and MailManagement.CheckValidEmailAddress("Send As") then
                    exit;
            end;
        end;

        "User ID" := ConnectionString;
        "Send As" := ConnectionString;
    end;
}

