report 50110 "Customer Postdated Checks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedCustomerPDChecks.rdlc';
    ApplicationArea = All;
    Caption = 'Customer Postdated Checks';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            RequestFilterFields = "Posting Date";

            column(DocumentNo; "Document No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; Amount)
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(JournalBatchName; "Journal Batch Name")
            {
            }
            column(JournalTemplateName; "Journal Template Name")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            { }

            trigger OnPreDataItem()
            var
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                SalesSetup.Get();
                if SalesSetup."Postdated Check Jnl Batch" <> '' then begin
                    SetFilter("Journal Template Name", SalesSetup."Postdated Check Jnl Template");
                    SetFilter("Journal Batch Name", SalesSetup."Postdated Check Jnl Batch");
                    SetFilter("Posting Date", '<=%1', Today);
                end else begin
                    SalesSetup.TestField("Postdated Check Jnl Batch");
                end;

            end;

            trigger OnAfterGetRecord()
            var

            begin

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
}
