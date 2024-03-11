table 50007 "Imprest Lines"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Account No"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
            NotBlank = false;
            TableRelation = "G/L Account"."No.";
            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
                Pay: Record "Imprest Header";
            begin
                if GLAcc.Get("Account No") then
                    "Account Name" := GLAcc.Name;
                GLAcc.TestField("Direct Posting", true);
                "Budgetary Control A/C" := GLAcc."Budget Controlled";
                Pay.SetRange(Pay."No.", No);
                if Pay.FindFirst() then begin
                    if Pay."Account No." <> '' then
                        "Imprest Holder" := Pay."Account No."
                    else
                        Error('Please Enter the Customer/Account Number');
                end;

            end;
        }
        field(3; "Account Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ImprestHeader.Reset();
                ImprestHeader.SetRange(ImprestHeader."No.", No);
                if ImprestHeader.FindFirst() then begin
                    "Date Taken" := ImprestHeader.Date;
                    ImprestHeader.TESTFIELD("Responsibility Center");
                    ImprestHeader.TESTFIELD("Global Dimension 1 Code");
                    ImprestHeader.TESTFIELD("Shortcut Dimension 2 Code");
                    "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                    "Currency Factor" := ImprestHeader."Currency Factor";
                    "Currency Code" := ImprestHeader."Currency Code";
                    Purpose := ImprestHeader.Purpose;
                end;
                if "Currency Factor" <> 0 then
                    "Amount LCY" := Amount / "Currency Factor"
                else
                    "Amount LCY" := Amount;
            end;
        }
        field(5; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Imprest Holder"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(7; "Actual Spent"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");

            end;
        }
        field(41; "Apply to"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(42; "Apply to ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(44; "Surrender Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(45; Surrendered; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(46; "M.R. No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(47; "Date Issued"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(48; "Type of Surrender"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Cash,Receipt;
        }
        field(49; "Dept. Vch. No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50; "Cash Surrender Amt"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(51; "Bank/Petty Cash"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(52; "Surrender Doc No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(53; "Date Taken"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(54; Purpose; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(79; "Budgetary Control A/C"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the reference of the fourth global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(83; Committed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(84; "Advance Type"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Funds Transaction Types"."Transaction Code" where("Transaction Type" = const(Payment));
            trigger OnValidate()
            begin
                ImprestHeader.Reset();
                ImprestHeader.SetRange(ImprestHeader."No.", No);
                if ImprestHeader.FindFirst() then begin
                    if (ImprestHeader.Status <> ImprestHeader.Status::Open) then
                        Error('You Cannot Insert a new record when the status of the document is not Pending');
                end;
                RecPay.Reset();
                RecPay.SetRange(RecPay."Transaction Code", "Advance Type");
                if RecPay.Find('-') then begin
                    "Account No" := RecPay."Account No";
                    Validate("Account No");
                end;
            end;
        }
        field(85; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            MinValue = 0;
            trigger OnValidate()
            begin
                IF "Currency Factor" <> 0 THEN
                    "Amount LCY" := Amount / "Currency Factor"
                ELSE
                    "Amount LCY" := Amount;
            end;
        }
        field(86; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(87; "Amount LCY"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(88; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(90; "Employee Job Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(91; "Daily Rate(Amount)"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Amount := "No of Days" * "Daily Rate(Amount)";
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Set Entry";
            Editable = false;
            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(481; "Destination Code"; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                getDestinationRateAndAmounts();
            end;
        }
        field(482; "No of Days"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                getDestinationRateAndAmounts();
            end;
        }
    }

    keys
    {
        key(Key1; "Line No.", No)
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount LCY";
        }
        key(Key2; "Currency Code")
        {

        }
    }
    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" := DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', 'Imprest', "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure getDestinationRateAndAmounts()
    begin
        "Daily Rate(Amount)" := 0;
        Amount := 0;
        Pay.Reset();
        Pay.SetRange(Pay."No.", No);
        if Pay.Find('-') then begin
            CustNo := Pay."Account No.";
        end;
    end;

    var
        myInt: Integer;
        ImprestHeader: Record "Imprest Header";
        DimMgt: Codeunit DimensionManagement;
        RecPay: Record "Funds Transaction Types";
        Pay: Record "Imprest Header";
        CustNo: Code[50];


    trigger OnInsert()
    begin
        ImprestHeader.Reset();
        ImprestHeader.SetRange(ImprestHeader."No.", No);
        if ImprestHeader.FindFirst() then begin
            "Date Taken" := ImprestHeader.Date;
            ImprestHeader.TestField("Responsibility Center");
            ImprestHeader.TestField("Shortcut Dimension 2 Code");
            "Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
            "Currency Factor" := ImprestHeader."Currency Factor";
            "Currency Code" := ImprestHeader."Currency Code";
            Purpose := ImprestHeader.Purpose;
        end;
    end;

    trigger OnModify()
    begin
        ImprestHeader.Reset();
        ImprestHeader.SetRange(ImprestHeader."No.", No);
        if ImprestHeader.FindFirst() then begin
            if (ImprestHeader.Status <> ImprestHeader.Status::Open) then
                Error('You Cannot Modify this record its status is not Pending');
            "Date Taken" := ImprestHeader.Date;
            "Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
            "Currency Factor" := ImprestHeader."Currency Factor";
            "Currency Code" := ImprestHeader."Currency Code";
            Purpose := ImprestHeader.Purpose;
        end;
        TestField(Committed, false);
    end;

    trigger OnDelete()
    begin
        ImprestHeader.Reset();
        ImprestHeader.SetRange(ImprestHeader."No.", No);
        if ImprestHeader.FindFirst() then begin
            if (ImprestHeader.Status <> ImprestHeader.Status::Open) then
                Error('You Cannot Delete this record its status is not Pending');
        end;
        TestField(Committed, false);
    end;

    trigger OnRename()
    begin

    end;

}