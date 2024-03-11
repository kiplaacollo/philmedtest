report 50111 "Payment Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedPaymentVoucher.rdlc';
    ApplicationArea = All;
    Caption = 'Payment Voucher';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            RequestFilterFields = "Posting Date", "Document No.", "External Document No.";
            column(AccountNo; "Account No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AppliestoDocNo; "Applies-to Doc. No.")
            {
            }
            column(Description; Description)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            { }
            column(AccName; AccName)
            { }
            column(VendorLedgerEntriesExists; VendorLedgerEntriesExists)
            { }
            column(NumberText1; NumberText[1])
            { }
            column(NumberText2; NumberText[2])
            { }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = FIELD("Document No.");
                column(Document_Type; "Document Type")
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(External_Document_No_; "External Document No.")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Description_VendorLedger; Description)
                {
                }
                column(Amount_VendorLegder; Amount)
                {
                }
                column(Amount_to_Apply; "Amount to Apply")
                {
                }
                column(PostingDate_VendorLedger; "Posting Date")
                {
                }
            }


            trigger OnPreDataItem()
            var

            begin


            end;

            trigger OnAfterGetRecord()
            var
                Vend: Record Vendor;
                BankAcc: Record "Bank Account";
                Cust: Record Customer;
                GLAccount: Record "G/L Account";
                GenJnlLine: Record "Gen. Journal Line";
                VendorLedgerEntry: Record "Vendor Ledger Entry";
                CheckReport: Report Check;
            begin
                AccName := '';
                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    IF Vend.GET("Account No.") THEN
                        AccName := Vend.Name;
                END;
                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    IF Cust.GET("Account No.") THEN
                        AccName := Cust.Name;
                END;
                IF "Account Type" = "Account Type"::"Bank Account" THEN BEGIN
                    BankAcc.GET("Account No.");
                    AccName := BankAcc.Name;
                END;

                IF "Account Type" = "Account Type"::"G/L Account" THEN BEGIN
                    IF Comment = '' THEN BEGIN
                        GLAccount.GET("Account No.");
                        AccName := GLAccount.Name;
                    END ELSE
                        AccName := Comment;
                END;

                // Amount in Words
                PaymentAmount := 0;
                GenJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                GenJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                GenJnlLine.SETRANGE("Document No.", "Document No.");
                GenJnlLine.SETFILTER(Amount, '>%1', 0);
                IF GenJnlLine.FINDSET THEN
                    REPEAT
                        PaymentAmount += GenJnlLine.Amount;
                    UNTIL GenJnlLine.NEXT = 0;

                CheckReport.InitTextVariable;
                CheckReport.FormatNoText(NumberText, PaymentAmount, "Currency Code");

                VendorLedgerEntry.SETRANGE("Applies-to ID", "Document No.");
                IF VendorLedgerEntry.FINDFIRST THEN
                    VendorLedgerEntriesExists := TRUE
                ELSE
                    VendorLedgerEntriesExists := FALSE;

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
    trigger OnPreReport()
    var

    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        PaymentAmount: Decimal;
        VendorLedgerEntriesExists: Boolean;
        AccName: Text[100];
        NumberText: array[2] of Text[80];

}
