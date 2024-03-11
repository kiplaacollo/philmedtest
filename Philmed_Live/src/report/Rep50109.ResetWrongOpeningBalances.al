report 50109 "Reset Wrong Opening Balances"
{
    ApplicationArea = All;
    Caption = 'Reset Wrong Opening Balances';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = TableData "Cust. Ledger Entry" = rimd, TableData "Detailed Cust. Ledg. Entry" = rimd, TableData "G/L Entry" = rimd;

    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            //DataItemTableView = WHERE("Journal Batch Name" = FILTER('CUSOPENBAL' | 'CUSTOPNREV'), "Posting Date" = filter(<= '08012022D'), Open = CONST(true));
            DataItemTableView = WHERE("Journal Batch Name" = FILTER('CUSOPENBAL' | 'CUSTOPNREV'), "Posting Date" = filter(<= '08012022D'));
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Customer No.", "Document No.";
            RequestFilterHeading = 'Reset Opening Balances';
            trigger OnAfterGetRecord()
            var
                DetailedCustLedger: Record "Detailed Cust. Ledg. Entry";
                GLEntry: Record "G/L Entry";
            begin
                DetailedCustLedger.Reset();
                DetailedCustLedger.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                //DetailedCustLedger.SetRange("Document No.", CustLedgerEntry."Document No.");
                //DetailedCustLedger.SetRange("Document Type", CustLedgerEntry."Document Type");
                //DetailedCustLedger.SetRange("Entry Type", DetailedCustLedger."Entry Type"::"Initial Entry");
                if DetailedCustLedger.FindFirst() then begin
                    repeat
                        DetailedCustLedger.Amount := 0;
                        DetailedCustLedger."Amount (LCY)" := 0;
                        DetailedCustLedger."Debit Amount" := 0;
                        DetailedCustLedger."Debit Amount (LCY)" := 0;
                        DetailedCustLedger."Credit Amount" := 0;
                        DetailedCustLedger."Credit Amount (LCY)" := 0;
                        DetailedCustLedger.Modify()
                    until DetailedCustLedger.Next() = 0;
                end;

                //G/L Entry Reset
                GLEntry.Reset();
                GLEntry.SetRange("Document No.", CustLedgerEntry."Document No.");
                GLEntry.SetRange("Posting Date", CustLedgerEntry."Posting Date");
                GLEntry.SetRange("Document Type", CustLedgerEntry."Document Type");
                If GLEntry.FindSet() then
                    repeat
                        GLEntry.Amount := 0;
                        GLEntry."Debit Amount" := 0;
                        GLEntry."Credit Amount" := 0;
                        GLEntry.Modify();
                    until GLEntry.Next() = 0;

                //Customer Ledger Entry
                CustLedgerEntry.Reversed := true;
                CustLedgerEntry."Sales (LCY)" := 0;
                CustLedgerEntry."Profit (LCY)" := 0;
                CustLedgerEntry.Open := False;
                CustLedgerEntry.Modify();

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
