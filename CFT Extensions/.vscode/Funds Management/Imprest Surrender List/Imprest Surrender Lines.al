table 50009 "Imprest Surrender Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Surrender Doc No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
        }
        field(2; "Account No"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));
        }
        field(3; "Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Imprest Holder"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(7; "Actual Spent"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "Actual Spent" > Amount THEN
                    ERROR('The Actual Spent Cannot be more than the Issued Amount');
                IF "Currency Factor" <> 0 THEN
                    "Amount LCY" := "Actual Spent" / "Currency Factor"
                ELSE
                    "Amount LCY" := "Actual Spent";
            end;
        }
        field(8; "Apply to"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Apply to ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Surrender Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; Surrendered; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Cash Receipt No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Date Issued"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Type of Surrender"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Cash,Receipt;
        }
        field(15; "Dept. Vch. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Cash Surrender Amt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Bank/Petty Cash"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(18; "DocNo."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Dimension;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Dimension;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(23; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(24; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(25; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(26; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(27; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(28; "Imprest Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Funds Transaction Types"."Transaction Code" where("Transaction Type" = const(Imprest));
        }
        field(85; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            MinValue = 0;
        }
        field(86; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(87; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Cash Surrender Amt LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(89; "Imprest Req Amt LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Cash Receipt Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            begin
                ShowDimensions
            end;
        }
    }

    keys
    {
        key(Key1; "Surrender Doc No", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Amount LCY", "Imprest Req Amt LCY", "Actual Spent";
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', 'Imprest', "Line No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    var
        myInt: Integer;
        Pay: Record "Imprest Surrender Header";
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin
        Pay.RESET;
        Pay.SETRANGE(Pay.No, "Surrender Doc No");
        IF Pay.FIND('-') THEN
            IF (Pay.Status = Pay.Status::Posted) OR (Pay.Status = Pay.Status::"Pending Approval")
            OR (Pay.Status = Pay.Status::Approved) THEN
                ERROR('This Document is already Sent for Approval/Approved or Posted');
    end;

    trigger OnDelete()
    begin
        Pay.RESET;
        Pay.SETRANGE(Pay.No, "Surrender Doc No");
        IF Pay.FIND('-') THEN
            IF (Pay.Status = Pay.Status::Posted) OR (Pay.Status = Pay.Status::"Pending Approval")
            OR (Pay.Status = Pay.Status::Approved) THEN
                ERROR('This Document is already Sent for Approval/Approved or Posted');
    end;

    trigger OnRename()
    begin

    end;

}