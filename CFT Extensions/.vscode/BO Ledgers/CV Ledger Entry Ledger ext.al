tableextension 50002 "CV Ledger Entry Buffer ext" extends "CV Ledger Entry Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(50005; "Loan Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Loan Product Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "UnAllocated Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Paid From Prepayments"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Transaction Type"; Option)
        {

            OptionMembers = " ","Deposit Contribution","Share Capital","Benevolent Fund",Loan,"Principal Repayment","Interest Due","Interest Paid","Penalty Paid","Penalty Charged","UnAllocated Funds","Interest Suspense Due","Interest Suspense Paid","Write Off","Write Off Recoveries","Penalty Suspense Charged","Penalty Suspense Paid","Fosa Transaction";

        }

        field(50002; "Reversal Date"; Date)
        {
        }
        field(50003; "Transaction Date"; Date)
        {
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }

        field(50004; "Created On"; DateTime)
        {
        }
        field(50010; "Loan Product"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

    }
    procedure CopyFromBOLedgEntry(BOLedgEntry: Record "BO Ledger Entry")
    begin
        "Entry No." := BOLedgEntry."Entry No.";
        "CV No." := BOLedgEntry."BO No";
        "Posting Date" := BOLedgEntry."Posting Date";
        "Document Type" := BOLedgEntry."Document Type";
        "Document No." := BOLedgEntry."Document No.";
        Description := BOLedgEntry.Description;
        "Currency Code" := BOLedgEntry."Currency Code";
        Amount := BOLedgEntry.Amount;
        "Remaining Amount" := BOLedgEntry."Remaining Amount";
        "Original Amount" := BOLedgEntry."Original Amount";
        "Original Amt. (LCY)" := BOLedgEntry."Original Amt. (LCY)";
        "Remaining Amt. (LCY)" := BOLedgEntry."Remaining Amt. (LCY)";
        "Amount (LCY)" := BOLedgEntry."Amount (LCY)";
        "CV Posting Group" := BOLedgEntry."Member Posting Group";
        "Global Dimension 1 Code" := BOLedgEntry."Global Dimension 1 Code";
        "Global Dimension 2 Code" := BOLedgEntry."Global Dimension 2 Code";
        "Dimension Set ID" := BOLedgEntry."Dimension Set ID";
        "User ID" := BOLedgEntry."User ID";
        "Applies-to Doc. Type" := BOLedgEntry."Applies-to Doc. Type";
        "Applies-to Doc. No." := BOLedgEntry."Applies-to Doc. No";
        Open := BOLedgEntry.Open;
        Positive := BOLedgEntry.Positive;
        "Closed by Entry No." := BOLedgEntry."Closed by Entry No.";
        "Closed at Date" := BOLedgEntry."Closed at Date";
        "Closed by Amount" := BOLedgEntry."Closed by Amount";
        "Applies-to ID" := BOLedgEntry."Applies-to ID";
        "Journal Batch Name" := BOLedgEntry."Journal Batch Name";
        "Bal. Account Type" := BOLedgEntry."Bal. Account Type";
        "Bal. Account No." := BOLedgEntry."Bal. Account No.";
        "Transaction No." := BOLedgEntry."Transaction No.";
        "Closed by Amount (LCY)" := BOLedgEntry."Closed by Amount (LCY)";
        "Adjusted Currency Factor" := 1;
        "Original Currency Factor" := 1;
        "Debit Amount" := BOLedgEntry."Debit Amount";
        "Credit Amount" := BOLedgEntry."Credit Amount";
        "Debit Amount (LCY)" := BOLedgEntry."Debit Amount (LCY)";
        "Credit Amount (LCY)" := BOLedgEntry."Credit Amount (LCY)";
        "No. Series" := BOLedgEntry."No. Series";
        "Amount to Apply" := BOLedgEntry."Amount to Apply";
        "UnAllocated Account No" := BOLedgEntry."UnAllocated Account No";
        "Paid From Prepayments" := BOLedgEntry."Paid From Prepayments";
        OnAfterCopyFromBOLedgerEntry(Rec, BOLedgEntry);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterCopyFromBOLedgerEntry(VAR CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; BOLedgerEntry: Record "BO Ledger Entry")
    begin
    end;

    var
        myInt: Integer;
}