table 1309 "O365 Getting Started"
{
    Caption = 'O365 Getting Started';

    fields
    {
        field(1; "User ID"; Text[132])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }
        field(2; "Display Target"; Code[20])
        {
            Caption = 'Display Target';
        }
        field(10; "Current Page"; Integer)
        {
            Caption = 'Current Page';
            InitValue = 1;
        }
        field(11; "Tour in Progress"; Boolean)
        {
            Caption = 'Tour in Progress';
        }
        field(12; "Tour Completed"; Boolean)
        {
            Caption = 'Tour Completed';
        }
    }

    keys
    {
        key(Key1; "User ID", "Display Target")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ClientTypeManagement: Codeunit "Client Type Management";

    procedure AlreadyShown(): Boolean
    begin
        exit(Get(UserId, ClientTypeManagement.GetCurrentClientType));
    end;

    procedure MarkAsShown()
    begin
        Init;
        "User ID" := UserId;
        "Display Target" := Format(ClientTypeManagement.GetCurrentClientType);
        Insert;
    end;

    [IntegrationEvent(false, false)]
    [Scope('Internal')]
    procedure OnO365DemoCompanyInitialize()
    begin
    end;
}

