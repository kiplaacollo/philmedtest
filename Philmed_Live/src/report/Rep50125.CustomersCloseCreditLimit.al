report 50125 "Customers Close Credit Limit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedCustomersCloseToCreditLimt.rdlc';
    ApplicationArea = All;
    Caption = 'Customers Close To Credit Limit';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.") where("Credit Limit (LCY)" = filter(<> 0), Balance = filter(<> 0));
            RequestFilterFields = "No.", "Global Dimension 1 Code";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(Balance; Balance)
            {
            }
            column(BalanceDue; "Balance Due")
            {
            }
            column(CreditLimitLCY; "Credit Limit (LCY)")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            { }
            column(ReportFilters; ReportFilters)
            { }
            trigger OnAfterGetRecord()
            begin
                if (Balance / "Credit Limit (LCY)") * 100 < 80 then
                    CurrReport.Skip();
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
    begin
        CompanyInfo.Get();
        ReportFilters := Customer.GetFilters;
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportFilters: Text;
}
