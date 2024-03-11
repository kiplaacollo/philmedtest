query 50100 Branch_Target_Report
{
    Caption = 'Branch Chart';
    QueryType = Normal;

    elements
    {

        dataitem(Sales_Invoice_Header; "Sales Invoice Header")
        {
            column(No_; "No.")
            {

            }
            column(Amount; Amount)
            {

            }
            column(branch_code; "branch code")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Salesperson_Code; "Salesperson Code")
            {

            }
            dataitem(Dimension_Value; "Dimension Value")
            {
                DataItemLink = "Code" = Sales_Invoice_Header."branch code";


                column(Dimension_Code; "Dimension Code")
                {

                }
                column(Daily_Sales_Target; "Daily Sales Target")
                {

                }

            }

        }

    }


    trigger OnBeforeOpen()
    begin

    end;
}
