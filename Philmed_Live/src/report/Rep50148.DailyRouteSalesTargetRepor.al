report 50148 "Daily Route Sales Target Repor"
{
    ApplicationArea = All;
    Caption = 'Daily Route Sales Target Repor';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/DailyRouteTargetRepor.rdlc';
    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {

            RequestFilterFields = Code;
            column(Daily_Customers_Target; "Daily Customers Target")
            {

            }
            column(Daily_Sales_Target_Amount; "Daily Sales Target Amount")
            {

            }

            dataitem(Customer; Customer)
            {
                DataItemLink = "Salesperson Code" = field(Code);


                column(Salesperson_Code; "Salesperson Code")
                {

                }
                column(No_; "No.")
                {

                }
                column(Customer_Target; "Customer Target")
                {

                }
                column(Route_Plan; "Route Plan")
                {

                }
                dataitem("CustLedgerEntry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("No.");

                    column(Customer_No_; "Customer No.")
                    {
                    }
                    column(Amount; Amount)
                    {

                    }
                    column(Document_Type; "Document Type")
                    { }
                    column(Document_No_; "Document No.")
                    { }
                    column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {

                    }
                    dataitem("Value Entry"; "Value Entry")
                    {
                        DataItemLink = "Document No." = field("Document No.");

                        column(Cost_Amount__Actual_; "Cost Amount (Actual)")
                        { }
                        column(Sales_Amount__Actual_; "Sales Amount (Actual)")
                        { }
                    }

                }
                dataitem("Route Plan"; "Route Plan")
                {
                    DataItemLink = "code" = field("Route Plan");
                    RequestFilterFields = Code;

                    column(Daily_Sales_Target; "Daily Sales Target")
                    { }
                    column(Daily_Customer_Target; "Daily Customer Target")
                    { }
                }
            }

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {

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
