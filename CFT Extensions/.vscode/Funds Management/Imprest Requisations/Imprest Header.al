table 50006 "Imprest Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'Stores the reference of the payment voucher in the database';
        }
        field(2; Date; Date)
        {
            DataClassification = CustomerContent;
            Description = 'Stores the date when the payment voucher was inserted into the system';
            trigger OnValidate()
            begin
                if ImpLinesExist then begin
                    Error('You first need to delete the existing imprest lines before changing the Currency Code');
                end;
                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor;
                if "Currency Code" <> xRec."Currency Code" then begin
                    UpdateCurrencyFactor;
                end else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor;
                UpdateHeaderToLine;
            end;
        }
        field(3; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            MinValue = 0;
            // DecimalPlaces = 0 : 15;
        }
        field(4; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
            trigger OnValidate()
            begin
                if ImpLinesExist then begin
                    Error('You first need to delete the existing imprest lines before changing the Currency Code');
                end;
                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor;
                if "Currency Code" <> xRec."Currency Code" then begin
                    UpdateCurrencyFactor;
                end else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor;
                UpdateHeaderToLine;
            end;
        }
        field(9; Payee; Text[100])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the name of the person who received the money';
        }
        field(10; "On Behalf Of"; Text[100])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';
        }
        field(11; Cashier; Code[50])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the identifier of the cashier in the database';
        }
        field(16; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(17; "Date Posted"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'Stores the date when the payment voucher was posted';
        }
        field(18; "Time Posted"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Stores the time when the payment voucher was posted';
        }
        field(19; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(20; "Total Payment Amount"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            Description = 'Stores the amount of the payment voucher';
            CalcFormula = sum("Imprest Lines".Amount where(No = field("No.")));
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the name of the paying bank account in the database';
            TableRelation = "Bank Account"."No." where("Currency Code" = field("Currency Code"));
            trigger OnValidate()
            var
                BankAcc: Record "Bank Account";
            begin
                BankAcc.Reset();
                "Bank Name" := '';
                if BankAcc.Get("Paying Bank Account") then begin
                    "Bank Name" := BankAcc.Name;
                end;
            end;
        }
        field(30; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            NotBlank = false;
            Description = 'Stores the reference to the first global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;
                UpdateHeaderToLine;
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");

            end;
        }
        field(35; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Cancelled;
            Description = 'Stores the status of the record in the database';
        }
        field(38; "Payment Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Imprest;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            NotBlank = false;
            Description = 'Stores the reference of the second global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;
                UpdateHeaderToLine;
            end;
        }
        field(57; "Function Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the name of the budget center in the database';
        }
        field(59; "Bank Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the description of the paying bank account in the database';
        }
        field(60; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the number series in the database';
        }
        field(61; Select; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'Enables the user to select a particular record';
        }
        field(62; "Total VAT Amount"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Imprest Lines"."Amount LCY" where(No = field("No.")));
        }
        field(63; "Total Withholding Tax Amount"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Imprest Lines"."Amount LCY" where(No = field("No.")));
        }
        field(64; "Total Net Amount"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Imprest Lines".Amount where(No = field("No.")));
        }
        field(65; "Current Status"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the current status of the payment voucher in the database';
        }
        field(66; "Cheque No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(67; "Pay Mode"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Cash,Cheque,EFT,"Letter of Credit","Custom 3","Custom 4","Custom 5";
        }
        field(68; "Payment Release Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Payment Release Date" < Date then
                    Error('The Payment Release Date cannot be lesser than the Document Date');

            end;
        }
        field(69; "No. Printed"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(70; "VAT Base Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(71; "Exchange Rate"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(72; "Currency Reciprical"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73; "Current Source A/C Bal"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(74; "Cancellation Remarks"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(75; "Register Number"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(76; "From Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(77; "To Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(78; "Invoice Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(79; "Total Net Amount lCY"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Imprest Lines"."Amount LCY" where(No = field("No.")));
        }
        field(80; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order","Payment voucher","Imprest Requisition";
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name;
                UpdateHeaderToLine;
            end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name;
                UpdateHeaderToLine;
            end;
        }
        field(83; Dim3; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(84; Dim4; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(85; "Responsibility Center"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
        field(86; "Account Type"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(87; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer where("Customer Posting Group" = const('IMPREST'));
            trigger OnValidate()
            begin
                Cust.Reset();
                Cust.SetRange(Cust."No.", "Account No.");
                if Cust.Find('-') then begin
                    Payee := Cust.Name;
                end;
            end;
        }
        field(88; "Surrender Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Full,Partial;
        }
        field(89; Purpose; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(90; "Employee Job Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Employee Statistics Group";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(50000; Requisition; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No.";
        }
        field(50001; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Reversed by"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }


    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    begin
        DImMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure UpdateHeaderToLine()
    begin
        PayLine.Reset();
        PayLine.SetRange(PayLine.No, "No.");
        if PayLine.Find('-') then begin
            repeat
                PayLine."Imprest Holder" := "Account No.";
                PayLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                PayLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                PayLine."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                PayLine."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                PayLine."Currency Code" := "Currency Code";
                PayLine."Currency Factor" := "Currency Factor";
                PayLine.Validate("Currency Factor");
                PayLine.Modify(true);
            until PayLine.Next() = 0;
        end;
    end;

    procedure ImpLinesExist(): Boolean
    begin
        ImpLines.Reset();
        ImpLines.SetRange(No, "No.");
        exit(ImpLines.FindFirst);
    end;

    procedure UpdateCurrencyFactor()
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := Date;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");

        end else
            "Currency Factor" := 0;
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" := DImMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Imprest', "No."));
        DImMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    var
        myInt: Integer;
        GenLedgerSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        DImMgt: Codeunit DimensionManagement;
        PayLine: Record "Imprest Lines";
        ImpLines: Record "Imprest Lines";
        CurrencyDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";
        DimVal: Record "Dimension Value";
        Cust: Record Customer;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            GenLedgerSetup.GET;
            IF "Payment Type" = "Payment Type"::Imprest THEN BEGIN
                GenLedgerSetup.TESTFIELD(GenLedgerSetup."Imprest Nos");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Imprest Nos", xRec."No. Series", 0D, "No.", "No. Series");
            END
        END;
        Date := Today;
        Cashier := UserId;
        Validate(Cashier);
        "Account Type" := "Account Type"::Customer;
        "Account No." := UserSetup."Staff Travel Account";
        "Document Type" := "Document Type"::"Imprest Requisition";
        "Global Dimension 1 Code" := 'BOSA';
    end;

    trigger OnModify()
    begin
        if Status = Status::Open then
            UpdateHeaderToLine;
    end;

    trigger OnDelete()
    begin
        if (Status <> Status::Open) then
            Error('You Cannot Delete this record its status is not Pending');
    end;

    trigger OnRename()
    begin

    end;

}