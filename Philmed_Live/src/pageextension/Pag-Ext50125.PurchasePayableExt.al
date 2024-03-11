pageextension 50125 PurchasePayableExt extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Ignore Updated Addresses")
        {
            field("Postdated Check Jnl Template"; Rec."Postdated Check Jnl Template")
            {
                ApplicationArea = all;
            }
            field("Postdated Check Jnl Batch"; Rec."Postdated Check Jnl Batch")
            {
                ApplicationArea = all;
            }
        }
    }
}
