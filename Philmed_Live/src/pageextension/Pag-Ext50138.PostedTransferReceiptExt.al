pageextension 50138 "Posted Transfer Receipt Ext" extends "Posted Transfer Receipts"
{
    layout
    {
        addafter("Transfer-to Code")
        {
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
