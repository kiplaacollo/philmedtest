pageextension 50135 "Bank Account Card Ext" extends "Bank Account Card"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field("MPESA Shortcode"; Rec."MPESA Shortcode")
            {
                ApplicationArea = all;
            }
            field("Block Balances Below Zero"; Rec."Block Balances Below Zero")
            {
                ApplicationArea = all;
            }
        }
    }
}

pageextension 50136 "Bank Account List Ext" extends "Bank Account List"
{
    layout
    {
        addafter(Name)
        {
            field("MPESA Shortcode"; Rec."MPESA Shortcode")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}
