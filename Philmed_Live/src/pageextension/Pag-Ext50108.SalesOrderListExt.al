pageextension 50108 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
            }

        }

    }
}
