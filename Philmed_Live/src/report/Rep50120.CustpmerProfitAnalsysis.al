report 50120 "Custpmer Profit Analsysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedCustomerProfitAnalysis.rdlc';
    ApplicationArea = All;
    Caption = 'Customer Profit Analsysis Summary';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.") where("Item Ledger Entry Type" = const(Sale));
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Source No.";

            column(Source_No_; "Source No.")
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
            column(Company_Name; CompanyInfo.Name)
            { }
            column(ReportFilters; ReportFilters)
            { }
            column(Customer_Name; Customer.Name)
            { }

            trigger OnAfterGetRecord()
            begin
                Customer.Get("Source No.");
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
        Customer: Record Customer;
}
