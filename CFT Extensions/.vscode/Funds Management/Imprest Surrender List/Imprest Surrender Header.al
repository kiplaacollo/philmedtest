table 50008 "Imprest Surrender Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    GenLedgerSetup.Get();
                    NoSeriesMgt.TestManual(GenLedgerSetup."Imprest Surrender Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Surrender Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Funds Transaction Types"."Transaction Code" where("Transaction Type" = filter(Payment));
            trigger OnValidate()
            begin
                "Account No." := '';
                "Account Name" := '';
                Remarks := '';
                RecPayTypes.Reset();
                RecPayTypes.SetRange(RecPayTypes."Transaction Code", Type);
                RecPayTypes.SetRange(RecPayTypes."Transaction Type", RecPayTypes."Transaction Type"::Payment);
                if RecPayTypes.Find('-') then begin
                    Grouping := RecPayTypes."Default Grouping";
                end;
                if RecPayTypes.Find('-') then begin
                    "Account Type" := RecPayTypes."Account Type";
                    "Transaction Name" := RecPayTypes."Transaction Description";
                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then begin
                        RecPayTypes.TestField(RecPayTypes."Account No");
                        "Account No." := RecPayTypes."Account No";
                        Validate("Account No.");
                    end;
                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then begin
                        "Account No." := RecPayTypes."Account No";
                        Validate("Account No.");
                    end;
                end;
            end;
        }
        field(4; "Pay Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Cash,Cheque,EFT,"Custom 1","Custom 2","Custom 3","Custom 4","Custom 5";
        }
        field(5; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Cheque Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(9; "Received From"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "On Behalf Of"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Cashier; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(13; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(14; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Account Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Transaction Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Payee; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
                DimVal.SETRANGE(DimVal.Code, "Global Dimension 2 Code");
                IF DimVal.FIND('-') THEN
                    "Budget Center Name" := DimVal.Name;

                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(33; "Bank Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Cashier Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Cancelled;
        }
        field(37; Grouping; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(38; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,"Petty Cash";
        }
        field(39; "Bank Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,"Petty Cash";
        }
        field(40; "PV Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,Other;
        }
        field(42; "Apply to ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Imprest Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(45; Surrendered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Imprest Issue Doc. No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Imprest Header"."No." WHERE("Surrender Status" = FILTER('0' | Partial));
            trigger OnValidate()
            var
                PayHeader: Record "Imprest Header";
                ImpSurrLine: Record "Imprest Surrender Lines";
                LineNo: Integer;
                PayLine: Record "Imprest Lines";

            begin
                // {Copy the details from the payments header tableto the imprest surrender table to enable the user work on the same document}
                // {Retrieve the header details using the get statement}
                PayHeader.Reset();
                PayHeader.Get(Rec."Imprest Issue Doc. No");
                // Copy the details to the user interface
                "Paying Bank Account" := PayHeader."Paying Bank Account";
                Payee := PayHeader.Payee;
                PayHeader.CalcFields(PayHeader."Total Net Amount");
                Amount := PayHeader."Total Net Amount";
                "Amount Surrendered LCY" := PayHeader."Total Net Amount lCY";
                "Currency Factor" := PayHeader."Currency Factor";
                "Currency Code" := PayHeader."Currency Code";
                "Date Posted" := PayHeader."Date Posted";
                "Shortcut Dimension 2 Code" := PayHeader."Shortcut Dimension 2 Code";
                "Shortcut Dimension 3 Code" := PayHeader."Shortcut Dimension 3 Code";
                Dim3 := PayHeader.Dim3;
                "Shortcut Dimension 4 Code" := PayHeader."Shortcut Dimension 4 Code";
                Dim4 := PayHeader.Dim4;
                "Imprest Issue Date" := PayHeader.Date;
                // Get Line No
                if ImpSurrLine.FindLast() then
                    LineNo := ImpSurrLine."Line No." + 1
                else
                    LineNo := LineNo + 1;
                // Copy the detail lines from the imprest details table in the database
                PayLine.Reset();
                PayLine.SetRange(PayLine.No, "Imprest Issue Doc. No");
                if PayLine.Find('-') then begin
                    repeat
                        ImpSurrLine.Init();
                        ImpSurrLine."Surrender Doc No" := Rec.No;
                        ImpSurrLine."Account No" := PayLine."Account No";
                        ImpSurrLine."Imprest Type" := PayLine."Advance Type";
                        ImpSurrLine.VALIDATE(ImpSurrLine."Account No");
                        ImpSurrLine."Account Name" := PayLine."Account Name";
                        ImpSurrLine.Amount := PayLine.Amount;
                        ImpSurrLine."Due Date" := PayLine."Due Date";
                        ImpSurrLine."Imprest Holder" := PayLine."Imprest Holder";
                        ImpSurrLine."Actual Spent" := PayLine."Actual Spent";
                        ImpSurrLine."Apply to" := PayLine."Apply to";
                        ImpSurrLine."Apply to ID" := PayLine."Apply to ID";
                        ImpSurrLine."Surrender Date" := PayLine."Surrender Date";
                        ImpSurrLine.Surrendered := PayLine.Surrendered;
                        ImpSurrLine."Cash Receipt No" := PayLine."M.R. No";
                        ImpSurrLine."Date Issued" := PayLine."Date Issued";
                        ImpSurrLine."Type of Surrender" := PayLine."Type of Surrender";
                        ImpSurrLine."Dept. Vch. No." := PayLine."Dept. Vch. No.";
                        ImpSurrLine."Currency Factor" := PayLine."Currency Factor";
                        ImpSurrLine."Currency Code" := PayLine."Currency Code";
                        ImpSurrLine."Imprest Req Amt LCY" := PayLine."Amount LCY";
                        ImpSurrLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                        ImpSurrLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                        ImpSurrLine."Shortcut Dimension 3 Code" := PayLine."Shortcut Dimension 3 Code";
                        ImpSurrLine."Shortcut Dimension 4 Code" := PayLine."Shortcut Dimension 4 Code";
                        LineNo += 1;
                        ImpSurrLine."Line No." := LineNo;
                        ImpSurrLine.INSERT;
                    until PayLine.Next() = 0;
                end;

            end;
        }
        field(47; "Vote Book"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(48; "Total Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Total Expenditure"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Total Commitments"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Balance Less this Entry"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Petty Cash"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
                DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 2 Code");
                IF DimVal.FIND('-') THEN
                    "Budget Center Name" := DimVal.Name;

                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(59; "Function Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Budget Center Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(62; "Issue Voucher Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Cash Voucher","Payment Voucher";
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            Description = 'Stores the reference of the Third global dimension in the database';
            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 3);
                DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 3 Code");
                IF DimVal.FIND('-') THEN
                    Dim3 := DimVal.Name
            end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            Description = 'Stores the reference of the Third global dimension in the database';
            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.", 4);
                DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 4 Code");
                IF DimVal.FIND('-') THEN
                    Dim4 := DimVal.Name
            end;
        }
        field(83; Dim3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(84; Dim4; Text[250])
        {
            DataClassification = ToBeClassified;
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
        field(87; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        // Flowfield
        field(88; "Amount Surrendered LCY"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Surrender Lines"."Imprest Req Amt LCY" where("Surrender Doc No" = field(No)));
        }
        field(89; "Actual Spent"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Imprest Surrender Lines"."Actual Spent" where("Surrender Doc No" = field(No)));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Set Entry";
            Editable = false;
            trigger OnLookup()
            begin
                ShowDimensions
            end;
        }
        field(481; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order","Payment voucher","Imprest Requisition","Imprest Surrender";
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
        field(50004; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
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
          DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', 'Imprest', No));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    var
        myInt: Integer;
        GenLedgerSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RecPayTypes: Record "Funds Transaction Types";
        DimVal: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        if No = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Imprest Surrender Nos");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Imprest Surrender Nos", xRec."No. Series", 0D, No, "No. Series");
        end;
        "Account Type" := "Account Type"::Customer;
        "Surrender Date" := Today;
        Cashier := UserId;
        "Document Type" := "Document Type"::"Imprest Surrender";
        Validate(Cashier);
    end;

    trigger OnModify()
    begin
        IF Status = Status::Posted THEN
            ERROR('Cannot Modify Document is already Posted');
    end;

    trigger OnDelete()
    begin
        IF Status = Status::Posted THEN
            ERROR('Cannot Delete Document is already Posted');
    end;

    trigger OnRename()
    begin

    end;

}