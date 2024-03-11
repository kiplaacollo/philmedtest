query 50102 SalesPersonDailyReport
{
    Caption = 'SalesPersonDailyReport';
    QueryType = Normal;

    elements
    {
        dataitem(Dimension_Value; "Dimension Value")
        {
            column(Code; Code)
            { }
            column(Daily_Sales_Target; "Daily Sales Target")
            { }
            column(Daily_Customer_Target; "Daily Customer Target")
            { }

            dataitem(CustLedgerEntry; "Cust. Ledger Entry")
            {
                DataItemLink = "Global Dimension 1 Code" = Dimension_Value.Code;
                column(AmountLCY; "Amount (LCY)")
                {
                }
                column(SalespersonCode; "Salesperson Code")
                {
                }
                column(DocumentType; "Document Type")
                {
                }
                column(DocumentDate; "Document Date")
                {
                }
                column(DocumentNo; "Document No.")
                {
                }
                column(Posting_Date; "Posting Date")
                {

                }
                column(GlobalDimension1Code; "Global Dimension 1 Code")
                {
                }
                dataitem(Salesperson_Purchaser; "Salesperson/Purchaser")
                {
                    DataItemLink = "Code" = CustLedgerEntry."Salesperson Code";

                    column(Daily_Sales_Target_Amount; "Daily Sales Target Amount")
                    {

                    }
                    column(Daily_Customers_Target; "Daily Customers Target")
                    {

                    }
                }

            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
