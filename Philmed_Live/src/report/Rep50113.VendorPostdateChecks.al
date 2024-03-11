report 50113 "Vendor Postdate Checks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedVendorPDChecks.rdlc';
    ApplicationArea = All;
    Caption = 'Vendor Postdated Checks';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
        {
            column(DocumentNo; "Document No.")
            {
            }
            column(Description; Description)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(VendorName; "Vendor Name")
            {
            }
            column(VendorNo; "Vendor No.")
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            { }

            trigger OnPreDataItem()
            var
                PurchaseSetup: Record "Purchases & Payables Setup";
            begin
                PurchaseSetup.Get();
                if PurchaseSetup."Postdated Check Jnl Batch" <> '' then begin
                    SetFilter("Journal Batch Name", PurchaseSetup."Postdated Check Jnl Batch");
                    SetFilter("Posting Date", '>=%1', Today);
                end else begin
                    PurchaseSetup.TestField("Postdated Check Jnl Batch");
                end;

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
