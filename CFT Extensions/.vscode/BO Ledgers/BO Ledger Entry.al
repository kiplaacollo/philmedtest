table 50123 "BO Ledger Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "BO No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "BO Accounts"."Member Number";
            Caption = 'Member Number';
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Deposit Contribution","Share Capital","Benevolent Fund",Loan,"Principal Repayment","Interest Due","Interest Paid";
        }
        field(6; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ObjBOLedgerEntry.Reset();
                ObjBOLedgerEntry.SetRange(ObjBOLedgerEntry."Document No.", "Document No.");
                ObjBOLedgerEntry.SetRange(ObjBOLedgerEntry."Posting Date", "Posting Date");
                ObjBOLedgerEntry.SetFilter(ObjBOLedgerEntry."Entry No.", '<>%1', "Entry No.");
                ObjBOLedgerEntry.SetRange(ObjBOLedgerEntry.Reversed, true);
                if ObjBOLedgerEntry.Find('-') then begin
                    Reversed := true;
                    Rec.Modify();
                end;


            end;
        }
        field(7; Description; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed BO Ledger Entry".Amount where("BO Ledger Entry No." = field("Entry No.")));
            Editable = false;
            AutoFormatExpression = "Currency Code";
            trigger OnValidate()
            begin
                CalcFields(Amount);
                IF (("Transaction Type" = "Transaction Type"::"Principal Repayment") OR ("Transaction Type" = "Transaction Type"::"Interest Paid")
  OR ("Transaction Type" = "Transaction Type"::"Interest Suspense Paid") OR ("Transaction Type" = "Transaction Type"::"Penalty Paid")
  OR ("Transaction Type" = "Transaction Type"::"Penalty Suspense Paid")) AND (Amount > 0) AND (Reversed = FALSE) THEN BEGIN
                    Reversed := TRUE;
                END;
            end;
        }
        field(14; "Remaining Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Employee Ledger Entry".Amount where("Employee Ledger Entry No." = field("Entry No."), "Posting Date" = field("Date Filter")));
            AutoFormatExpression = "Currency Code";
            Editable = false;
        }
        field(15; "Original Amt. (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Employee Ledger Entry"."Amount (LCY)" where("Employee Ledger Entry No." = field("Entry No."), "Entry Type" = filter("Initial Entry"), "Posting Date" = field("Date Filter")));
            Editable = false;
        }
        field(16; "Remaining Amt. (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Employee Ledger Entry"."Amount (LCY)" where("Employee Ledger Entry No." = field("Entry No."), "Posting Date" = field("Date Filter")));
            Editable = false;
        }
        field(17; "Amount (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Employee Ledger Entry"."Amount (LCY)" where("Ledger Entry Amount" = const(true), "Employee Ledger Entry No." = field("Entry No."), "Posting Date" = field("Date Filter")));
            Editable = false;
        }
        field(22; "Member Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group";
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(27; "User ID"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin

            end;
        }
        field(28; "Source Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Source Code";
        }
        field(34; "Applies-to Doc. Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(35; "Applies-to Doc. No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(36; Open; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(43; Positive; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(44; "Closed by Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Employee Ledger Entry";
        }
        field(45; "Closed at Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(46; "Closed by Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
        }
        field(47; "Applies-to ID"; Code[50])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Open, true);
            end;
        }
        field(49; "Journal Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50; "Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(51; "Bal. Account Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(52; "Bal. Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account" ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(53; "Transaction No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(54; "Closed by Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(58; "Debit Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed BO Ledger Entry"."Debit Amount" where("BO Ledger Entry No." = field("Entry No."), "Posting Date" = field("Date Filter")));
            BlankZero = true;
            AutoFormatExpression = "Currency Code";
            Editable = false;
        }
        field(59; "Credit Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed BO Ledger Entry"."Credit Amount" where("BO Ledger Entry No." = field("Entry No."), "Posting Date" = field("Date Filter")));
            AutoFormatExpression = "Currency Code";
            Editable = false;
            BlankZero = true;
        }
        field(60; "Debit Amount (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Employee Ledger Entry"."Debit Amount (LCY)" where("Ledger Entry Amount" = const(true), "Employee Ledger Entry No." = field("Entry No."), "Posting Date" = field("Date Filter")));
            Editable = false;
            BlankZero = true;
        }
        field(61; "Credit Amount (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Employee Ledger Entry"."Credit Amount (LCY)" where("Ledger Entry Amount" = const(true), "Employee Ledger Entry No." = field("Entry No."), "Posting Date" = field("Date Filter")));
            BlankZero = true;
            Editable = false;
        }
        field(64; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(75; "Original Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Employee Ledger Entry".Amount where("Employee Ledger Entry No." = field("Entry No."), "Entry Type" = filter("Initial Entry"), "Posting Date" = field("Date Filter")));
            AutoFormatExpression = "Currency Code";
            Editable = false;
        }
        field(76; "Date Filter"; Date)
        {

            FieldClass = FlowFilter;
        }
        field(84; "Amount to Apply"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            trigger OnValidate()
            begin
                TestField(Open, true);
                CalcFields("Remaining Amount");
                // if "Amount to Apply"*"Remaining Amount"<0 then
                // FieldError("Amount to Apply",MustHaveSameSignErr);
            end;
        }
        field(86; "Applying Entry"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(170; "Creditor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Numeric = true;
        }
        field(171; "Payment Reference"; Code[50])
        {
            DataClassification = CustomerContent;
            Numeric = true;
            trigger OnValidate()
            begin
                if "Payment Reference" <> '' then
                    TestField("Creditor No.");
            end;
        }
        field(172; "Payment Method Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
            trigger OnValidate()
            begin
                TestField(Open, true);
            end;
        }
        field(289; "Message to Recipient"; Text[140])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Open, true);
            end;
        }
        field(290; "Exported to Payment File"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Set Entry";
            Editable = false;
            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(481; "Loan Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(482; "Loan Product Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(483; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Deposit Contribution","Share Capital","Benevolent Fund",Loan,"Principal Repayment","Interest Due","Interest Paid","Penalty Paid","Penalty Charged","UnAllocated Funds","Interest Suspense Due","Interest Suspense Paid","Write Off","Write Off Recoveries","Penalty Suspense Charged","Penalty Suspense Paid","Fosa Transaction";
            trigger OnValidate()
            begin
                IF ("Transaction Type" = "Transaction Type"::Loan) OR ("Transaction Type" = "Transaction Type"::"Principal Repayment") THEN
                    "Transaction Group" := "Transaction Group"::Loan_Principle;

                IF ("Transaction Type" = "Transaction Type"::"Interest Due") OR ("Transaction Type" = "Transaction Type"::"Interest Paid") THEN
                    "Transaction Group" := "Transaction Group"::"Int Due_Int Paid";

                IF ("Transaction Type" = "Transaction Type"::"Penalty Charged") OR ("Transaction Type" = "Transaction Type"::"Penalty Paid") THEN
                    "Transaction Group" := "Transaction Group"::"Pen Charged_Pen Paid";

            end;
        }
        field(484; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(485; "Reversed by Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cust. Ledger Entry";
            BlankZero = true;
        }
        field(486; "Reversed Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cust. Ledger Entry";
            BlankZero = true;
        }
        field(487; "External Document No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(488; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(489; "Transaction Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Loan_Principle","Int Due_Int Paid","Pen Charged_Pen Paid";
        }
        field(490; "UnAllocated Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Prepayments Account No';
        }
        field(491; "Paid From Prepayments"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(492; "FOSA Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Products Setup";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(key2; "BO No", "Applies-to ID", Open, Positive)
        {

        }
    }
    procedure ShowDimensions()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TABLECAPTION, "Entry No."));
    end;

    procedure CopyFromGenJnlLine(GenJnlLine: Record "Gen. Journal Line")
    begin
        "BO No" := GenJnlLine."Account No.";
        "Posting Date" := GenJnlLine."Posting Date";
        "Document Type" := GenJnlLine."Document Type";
        "Document No." := GenJnlLine."Document No.";
        Description := GenJnlLine.Description;
        "Loan Number" := GenJnlLine."Loan Number";
        "Amount (LCY)" := GenJnlLine."Amount (LCY)";
        "Member Posting Group" := GenJnlLine."Posting Group";
        "Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        "Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := GenJnlLine."Dimension Set ID";
        "Source Code" := GenJnlLine."Source Code";
        "Reason Code" := GenJnlLine."Reason Code";
        "Journal Batch Name" := GenJnlLine."Journal Batch Name";
        "User ID" := UserId;
        "Bal. Account Type" := GenJnlLine."Bal. Account Type";
        "Bal. Account No." := GenJnlLine."Bal. Account No.";
        "No. Series" := GenJnlLine."Posting No. Series";
        "UnAllocated Account No" := GenJnlLine."Unallocated Account No";
        "Paid From Prepayments" := GenJnlLine."Paid From Prepayments";
        OnAfterCopyEmployeeLedgerEntryFromGenJnlLine(Rec, GenJnlLine);

    end;

    procedure CopyFromCVLedgEntryBuffer(VAR CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
        "Entry No." := CVLedgerEntryBuffer."Entry No.";
        "BO No" := CVLedgerEntryBuffer."CV No.";
        "Posting Date" := CVLedgerEntryBuffer."Posting Date";
        "Document Type" := CVLedgerEntryBuffer."Document Type";

        "Document No." := CVLedgerEntryBuffer."Document No.";
        Description := CVLedgerEntryBuffer.Description;
        "Currency Code" := CVLedgerEntryBuffer."Currency Code";
        "Source Code" := CVLedgerEntryBuffer."Source Code";
        "Reason Code" := CVLedgerEntryBuffer."Reason Code";
        Amount := CVLedgerEntryBuffer.Amount;
        "Remaining Amount" := CVLedgerEntryBuffer."Remaining Amount";
        "Original Amount" := CVLedgerEntryBuffer."Original Amount";
        "Original Amt. (LCY)" := CVLedgerEntryBuffer."Original Amt. (LCY)";
        "Remaining Amt. (LCY)" := CVLedgerEntryBuffer."Remaining Amt. (LCY)";
        "Amount (LCY)" := CVLedgerEntryBuffer."Amount (LCY)";
        "Member Posting Group" := CVLedgerEntryBuffer."CV Posting Group";
        "Loan Number" := CVLedgerEntryBuffer."Loan Number";
        "Global Dimension 1 Code" := CVLedgerEntryBuffer."Global Dimension 1 Code";
        "Global Dimension 2 Code" := CVLedgerEntryBuffer."Global Dimension 2 Code";
        "Dimension Set ID" := CVLedgerEntryBuffer."Dimension Set ID";
        "User ID" := CVLedgerEntryBuffer."User ID";
        "Applies-to Doc. Type" := CVLedgerEntryBuffer."Applies-to Doc. Type";
        "Applies-to Doc. No" := CVLedgerEntryBuffer."Applies-to Doc. No.";
        Open := CVLedgerEntryBuffer.Open;
        Positive := CVLedgerEntryBuffer.Positive;
        "Closed by Entry No." := CVLedgerEntryBuffer."Closed by Entry No.";
        "Closed at Date" := CVLedgerEntryBuffer."Closed at Date";
        "Closed by Amount" := CVLedgerEntryBuffer."Closed by Amount";
        "Applies-to ID" := CVLedgerEntryBuffer."Applies-to ID";
        "Journal Batch Name" := CVLedgerEntryBuffer."Journal Batch Name";
        "Bal. Account Type" := CVLedgerEntryBuffer."Bal. Account Type";
        "Bal. Account No." := CVLedgerEntryBuffer."Bal. Account No.";
        "Transaction No." := CVLedgerEntryBuffer."Transaction No.";
        "Closed by Amount (LCY)" := CVLedgerEntryBuffer."Closed by Amount (LCY)";
        "Debit Amount" := CVLedgerEntryBuffer."Debit Amount";
        "Credit Amount" := CVLedgerEntryBuffer."Credit Amount";
        "Debit Amount (LCY)" := CVLedgerEntryBuffer."Debit Amount (LCY)";
        "Credit Amount (LCY)" := CVLedgerEntryBuffer."Credit Amount (LCY)";
        "No. Series" := CVLedgerEntryBuffer."No. Series";
        "Amount to Apply" := CVLedgerEntryBuffer."Amount to Apply";
        "UnAllocated Account No" := CVLedgerEntryBuffer."UnAllocated Account No";
        "Paid From Prepayments" := CVLedgerEntryBuffer."Paid From Prepayments";
        OnAfterCopyEmplLedgerEntryFromCVLedgEntryBuffer(Rec, CVLedgerEntryBuffer);

    end;

    [IntegrationEvent(true, false)]
    procedure OnAfterCopyEmployeeLedgerEntryFromGenJnlLine(VAR BOLedgerEntry: Record "BO Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterCopyEmplLedgerEntryFromCVLedgEntryBuffer(VAR BOLedgerEntry: Record "BO Ledger Entry"; CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer")
    begin
    end;

    var
        myInt: Integer;
        ObjBOLedgerEntry: Record "BO Ledger Entry";
        DimMgt: Codeunit DimensionManagement;
        GenJnlLine: Record "Gen. Journal Line";
        CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer";

    trigger OnInsert()
    begin

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