table 50155 "Collateral Register"
{
    DataClassification = CustomerContent;
    LookupPageId = "Collateral Register List";
    DrillDownPageId = "Collateral Register List";

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            // NotBlank = true;

        }
        field(2; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Shares,Deposits,Collateral,"Fixed Deposit","Money Market","Tangible Asset","Children's Accounts",Land;
            OptionCaption = 'NSE Shares,My Shares,Motor Vehicle,Withdrawable or Fixed Deposit,Money Market,Tangible Asset,Childrens Accounts,Land';
            // NotBlank = true;
        }
        field(3; "Security Details"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(4; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Free Collateral"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; Value; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Guarantee Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; Code; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Loan Collateral Set-up".Code where(Type = field(Type));
            trigger OnValidate()
            var
                SecSetup: Record "Loan Collateral Set-up";
            begin
                CalcFields("New Book Value");
                if ("New Book Value" <= 0) then
                    Error('Ensure the Depreciation/Appreciation Journals have been Entered');
                SecSetup.Reset();
                SecSetup.SetRange(SecSetup.Code, Code);
                if SecSetup.Find('-') then begin
                    Type := SecSetup.Type;
                    "Security Details" := SecSetup."Security Description";
                    "Collateral Multiplier" := SecSetup."Collateral Multiplier";
                    "Guarantee Value" := "New Book Value" * "Collateral Multiplier";
                    Category := SecSetup.Category;
                end;
            end;
        }
        field(9; Category; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Cash,"Government Securities","Corporate Bonds",Equity,"Morgage Securities";
        }
        field(10; "Collateral Multiplier"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "View Document"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Assesment Done"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Account No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Title Deed No."; Code[150])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Comitted Collateral Value"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = sum("Loan-Collateral Details"."Amount To Commit" where("Collateral Document No" = field("Document No"), Posted = filter(true)));
        }
        field(17; "Collateral Register Doc"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(18; "Document No"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Vehicle Make"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Collateral Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Logbook,Title;
        }
        field(21; "Year of Manufacture"; Code[5])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Insurance Provider"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(23; "Commencing Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(24; Owner; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(25; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Simple Deposit","Jointly Registered","Legal Charge","Pending Registration";
        }
        field(26; "Missing Documents"; Text[120])
        {
            DataClassification = CustomerContent;
        }
        field(27; "Contact No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(28; "Email Address"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Title Contents"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(30; "Date Released"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(31; "Date Charged"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(33; "Registered To"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "BO Accounts"."Member Number";
        }
        field(34; "Loan Outstanding Bal"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Registration No"; Code[150])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ObjCollateralRegister: Record "Collateral Register";
            begin
                ObjCollateralRegister.Reset();
                ObjCollateralRegister.SetRange("Registration No", "Registration No");
                if ObjCollateralRegister.Find('-') then
                    Error('Duplicate Registration Number not allowed');
            end;
        }
        field(37; Details; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(40; "No. Series"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Member Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(42; "Guarantee Value 2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(43; "Appreciation/Depreciation %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Insurance Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Comprehensive,"Third Party";
        }
        field(45; "Valuation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Appreciation,Depreciation;
        }
        field(46; "Book Value"; Decimal)
        {
            Editable = false;
            // FieldClass = FlowField;
            // CalcFormula = sum("Collateral Depr Appr Details".Value where("Document No" = field("Document No"), Voided = filter(false)));
        }
        field(47; "New Comitted Collateral Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Loan Collateral Details"."Amount To Commit" where("Collateral Document No" = field("Document No"), Posted = filter(true)));
        }
        field(48; "New Book Value"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Collateral Depr Appr Details".Value where("Document No" = field("Document No"), Voided = filter(false)));
        }
    }

    keys
    {
        key(Key1; "Document No", "Registration No", Type)
        {
            Clustered = true;
        }
        key(key2; "Registration No")
        {

        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "Document No", Type, "Registered To", "Registration No", Value, "Guarantee Value", "Comitted Collateral Value")
        {

        }
    }
    procedure ClearFields()
    begin
        "Security Details" := '';
        code := '';
        "Collateral Multiplier" := 0;
        Value := 0;
        "Vehicle Make" := '';
        // "Collateral Type":="Collateral Type"::"";
        "Insurance Provider" := '';
        "Commencing Date" := 0D;
        "Expiry Date" := 0D;
        Owner := '';
        "Contact No." := '';
        "Email Address" := '';
        "Title Contents" := '';
        "Date Charged" := 0D;
        "Date Released" := 0D;
        "Registration No" := '';
        "Registered To" := '';

    end;

    var
        myInt: Integer;

    trigger OnInsert()
    var
        NoSeriesMngt: Codeunit NoSeriesManagement;
        NoSetup: Record "BO General Setup";
    begin
        if "Document No" = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Collateral Security Nos");
            NoSeriesMngt.InitSeries(NoSetup."Collateral Security Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}