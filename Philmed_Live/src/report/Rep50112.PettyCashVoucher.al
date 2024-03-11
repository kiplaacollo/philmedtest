report 50112 "Petty Cash Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedPettyCashVoucher.rdlc';
    ApplicationArea = All;
    Caption = 'Petty Cash Voucher';
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
            column(Journal_Batch_Name; "Journal Batch Name")
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
            column(BranchCode; "Shortcut Dimension 1 Code")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            { }
            column(AccName; AccName)
            { }
            column(NumberText1; NumberText[1])
            { }
            column(NumberText2; NumberText[2])
            { }

            trigger OnAfterGetRecord()
            var
                Vend: Record Vendor;
                BankAcc: Record "Bank Account";
                Cust: Record Customer;
                GLAccount: Record "G/L Account";
                GenJnlLine: Record "Gen. Journal Line";
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
        AccName: Text[100];
        NumberText: array[2] of Text[80];
}
