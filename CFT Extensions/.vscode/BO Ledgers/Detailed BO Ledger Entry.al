table 50124 "Detailed BO Ledger Entry"
{
    DataClassification = CustomerContent;
    Permissions = tabledata "Detailed Employee Ledger Entry" = m;
    LookupPageId = "Detailed BO Ledger Entries";
    DrillDownPageId = "Detailed BO Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "BO Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Employee Ledger Entry";
        }
        field(3; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Initial Entry",Application;
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
                ObjDetailedBOLedgerEntry.Reset();
                ObjDetailedBOLedgerEntry.SetRange(ObjDetailedBOLedgerEntry."Document No.", "Document No.");
                ObjDetailedBOLedgerEntry.SetRange(ObjDetailedBOLedgerEntry."Posting Date", "Posting Date");
                ObjDetailedBOLedgerEntry.SetFilter(ObjDetailedBOLedgerEntry."Entry No.", '<>%1', "Entry No.");
                ObjDetailedBOLedgerEntry.SetRange(ObjDetailedBOLedgerEntry.Reversed, true);
                if ObjDetailedBOLedgerEntry.Find('-') then begin
                    Reversed := true;
                    "Reversal Time" := Time;
                    "Reversal Date" := Today;
                    "Reversed By" := UserId;
                    Rec.Modify(true);
                end;
            end;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";

        }
        field(8; "Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Member Number"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(10; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(11; "User ID"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            TestTableRelation = false;
            trigger OnLookup()
            begin

            end;
        }
        field(12; "Source Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Source Code";
        }
        field(13; "Transaction No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Journal Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";
        }
        field(16; "Debit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            AutoFormatExpression = "Currency Code";
        }
        field(17; "Credit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            AutoFormatExpression = "Currency Code";
        }
        field(18; "Debit Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(19; "Credit Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(21; "Initial Entry Global Dim. 1"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(22; "Initial Entry Global Dim. 2"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(35; "Initial Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(36; "Applied Empl. Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(37; Unapplied; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(38; "Unapplied by Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Detailed Vendor Ledg. Entry";
        }
        field(42; "Application No"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(43; "Ledger Entry Amount"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(44; "Loan Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Loan Product Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Deposit Contribution","Share Capital","Benevolent Fund",Loan,"Principal Repayment","Interest Due","Interest Paid","Penalty Paid","Penalty Charged","UnAllocated Funds","Interest Suspense Due","Interest Suspense Paid","Write Off","Write Off Recoveries","Penalty Suspense Charged","Penalty Suspense Paid","Fosa Transaction";
            trigger OnValidate()
            begin
                IF (("Transaction Type" = "Transaction Type"::"Principal Repayment") OR ("Transaction Type" = "Transaction Type"::"Interest Paid")
                  OR ("Transaction Type" = "Transaction Type"::"Interest Suspense Paid") OR ("Transaction Type" = "Transaction Type"::"Penalty Paid")
                  OR ("Transaction Type" = "Transaction Type"::"Penalty Suspense Paid")) AND (Amount > 0) AND (Reversed = FALSE) THEN begin
                    Reversed := true;
                    "Reversal Time" := Time;
                    "Reversal Date" := Today;
                    "Reversed By" := UserId;
                end;
            end;
        }
        field(47; "Applied BO Ledger Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(48; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Reversed By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "External Document No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "UnAllocated Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Prepayment Account No';
        }
        field(55; "Paid From Prepayments"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "FOSA Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    procedure SetLedgerEntryAmount()
    begin
        "Ledger Entry Amount" := not ("Entry Type" = "Entry Type"::Application);
    end;

    procedure UpdateDebitCredit(Correction: Boolean)
    begin
        IF ((Amount > 0) OR ("Amount (LCY)" > 0)) AND NOT Correction OR
           ((Amount < 0) OR ("Amount (LCY)" < 0)) AND Correction
        THEN BEGIN
            "Debit Amount" := Amount;
            "Credit Amount" := 0;
            "Debit Amount (LCY)" := "Amount (LCY)";
            "Credit Amount (LCY)" := 0;
        END ELSE BEGIN
            "Debit Amount" := 0;
            "Credit Amount" := -Amount;
            "Debit Amount (LCY)" := 0;
            "Credit Amount (LCY)" := -"Amount (LCY)";
        END;
    end;

    procedure SetZeroTransNo(TransactionNo: Integer)
    begin
        DtldEmplLedgEntry.SETCURRENTKEY("Transaction No.");
        DtldEmplLedgEntry.SETRANGE("Transaction No.", TransactionNo);
        IF DtldEmplLedgEntry.FINDSET(TRUE) THEN BEGIN
            ApplicationNo := DtldEmplLedgEntry."Entry No.";
            REPEAT
                DtldEmplLedgEntry."Transaction No." := 0;
                DtldEmplLedgEntry."Application No." := ApplicationNo;
                DtldEmplLedgEntry.MODIFY;
            UNTIL DtldEmplLedgEntry.NEXT = 0;
        END;
    end;



    var
        myInt: Integer;
        ObjDetailedBOLedgerEntry: Record "Detailed BO Ledger Entry";
        UserMgt: Codeunit "User Management";
        DtldEmplLedgEntry: Record "Detailed Employee Ledger Entry";
        ApplicationNo: Integer;

    trigger OnInsert()
    begin
        SetLedgerEntryAmount();
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