report 50124 "Amount Due Per Customer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedAmountDuePerCustomer.rdlc';
    ApplicationArea = All;
    Caption = 'Amount Due Per Customer';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.") where("Balance Due" = filter(<> 0));
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
