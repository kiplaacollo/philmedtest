//************************************************************************
codeunit 50099 "PostCustomerExtension"
{
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
    procedure ModifyReceivablesAccount(var GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        TransactionTypestable: record "Transation types table";
        CustPostingGroupBuffer: record "Customer Posting Group";
    begin
        if cust.Get(GenJournalLine."Account No.") then begin
            if cust."Member Account Type" = Cust."Member Account Type"::BO then begin
                if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                    Error('Cannot post with missing transaction type.');
                if GenJournalLine."Loan Product Code" = '' then begin
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        GenJournalLine."Posting Group" := TransactionTypestable."Posting Group Code";
                        GenJournalLine.Modify();
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end else begin
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Loan Product Code", GenJournalLine."Loan Product Code");
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        GenJournalLine."Posting Group" := TransactionTypestable."Posting Group Code";
                        GenJournalLine.Modify();
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
                end;

            end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure InsertCustomTransactionFields(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        cust: Record Customer;
    begin
        CustLedgerEntry."Transaction Type" := GenJournalLine."Transaction Type";
        CustLedgerEntry."Transaction Date" := WorkDate();
        CustLedgerEntry."Created On" := CurrentDateTime;
        CustLedgerEntry."Loan Product Code" := GenJournalLine."Loan Product Code";
        CustLedgerEntry.CalcFields(Amount);

    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    procedure InsertCustomfieldstodetailedcustledgerentry2(GenJournalLine: Record "Gen. Journal Line"; var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin

        DtldCustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
        DtldCustLedgEntry."Transaction Date" := WorkDate();
        DtldCustLedgEntry."Created On" := CurrentDateTime;
        DtldCustLedgEntry."Loan Product Code" := GenJournalLine."Loan Product Code";
        DtldCustLedgEntry.Description := GenJournalLine.Description;


    end;

    [EventSubscriber(ObjectType::Table, 179, 'OnAfterReverseEntries', '', false, false)]
    procedure modifyreversedCustLedger(Number: Integer)
    var
        Custledger: Record "Cust. Ledger Entry";
        CustledgeentPage: page "Customer Ledger Entries";
        ReversalEntry: Record "Reversal Entry";
        DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    begin

        Custledger.Reset();
        Custledger.SetRange(Reversed, true);
        if Custledger.FindSet(true) then begin
            repeat
                DetailedCustLedgerEntry.Reset();
                DetailedCustLedgerEntry.SetRange(DetailedCustLedgerEntry."Cust. Ledger Entry No.", Custledger."Entry No.");
                if DetailedCustLedgerEntry.FindSet() then begin
                    DetailedCustLedgerEntry.Reversed := true;
                    DetailedCustLedgerEntry."Reversal Date" := Today;
                    DetailedCustLedgerEntry.Modify(true);
                end;
            until Custledger.Next = 0;
        end;
    end;


}



