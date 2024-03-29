report 50114 "Dispatch Sheet Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedDispatchSheet.rdlc';
    ApplicationArea = All;
    Caption = 'Dispatch Sheet Summary';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SalesInvoiceTracking; "Sales Invoice Tracking")
        {
            RequestFilterFields = "Posting Date", Rider, "Trip No.";
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
            column(InvoiceNo; "Invoice No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Rider; Rider)
            {
            }
            column(RoutePlan; "Route Plan")
            {
            }
            column(TripNo; "Trip No.")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            { }
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
