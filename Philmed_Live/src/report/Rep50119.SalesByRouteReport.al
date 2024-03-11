report 50119 "Sales By Route Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedSalesByRoute.rdlc';
    ApplicationArea = All;
    Caption = 'Sales By Route Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Global Dimension 1 Code", "Route Plan") where("Item Ledger Entry Type" = const(Sale));
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Route Plan";

            column(Route_Plan; "Route Plan")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(Sales_Amount__Actual_; "Sales Amount (Actual)")
            { }
            column(Cost_Amount__Actual_; "Cost Amount (Actual)")
            { }
            column(Invoiced_Quantity; "Invoiced Quantity")
            { }

            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            { }
            column(Source_No_; "Source No.")
            { }
            column(CustomerName; CustomerName)
            { }
            column(Company_Name; CompanyInfo.Name)
            { }
            column(ReportFilters; ReportFilters)
            { }

            trigger OnAfterGetRecord()
            var
                lvCustomer: Record Customer;
            begin
                if lvCustomer.get("Source No.") then
                    CustomerName := lvCustomer.Name;
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
        lvUserSetup: Record "User Setup";
    begin
        CompanyInfo.Get();
        ReportFilters := "Value Entry".GetFilters;
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportFilters: Text;
        CustomerName: Text;
}
