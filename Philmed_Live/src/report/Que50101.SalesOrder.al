query 50101 Sales_Order
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'Sales_Header';
    EntitySetName = 'Sales_Header';
    QueryType = API;

    elements
    {
        dataitem(salesHeader; "Sales Header")
        {

            column(amountIncludingVAT; "Amount Including VAT")
            {
            }
            column(cashSaleOrder; "Cash Sale Order")
            {
            }
            column(comment; Comment)
            {
            }
            column(currencyCode; "Currency Code")
            {
            }
            column(no; "No.")
            {
            }
            column(orderDate; "Order Date")
            {
            }
            column(reasonCode; "Reason Code")
            {
            }
            column(sellToCustomerName; "Sell-to Customer Name")
            {
            }
            column(sellToCustomerNo; "Sell-to Customer No.")
            {
            }
            column(salespersonCode; "Salesperson Code")
            {
            }
            dataitem(Sales_Line; "Sales Line")
            {
                DataItemLink = "Document No." = salesHeader."No.";

                column(Type; Type)
                {

                }
                column(No_; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Location_Code; "Location Code")
                {

                }
                column(Inventory_Balance; "Inventory Balance")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {

                }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                {

                }
                column(Line_Discount__; "Line Discount %")
                {

                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {

                }

            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
