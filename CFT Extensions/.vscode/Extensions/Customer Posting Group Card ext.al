pageextension 50004 "Customer Posting Group CardExt" extends "Customer Posting Group Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(General)
        {
            group("Sacco Module")
            {
                field("Deposit Contribution"; Rec."Deposit Contribution")
                {

                }
                field("Share Capital"; Rec."Share Capital")
                {

                }
                field("Benevolent Fund"; Rec."Benevolent Fund")
                {

                }
                field("UnAllocated Funds"; Rec."UnAllocated Funds")
                {

                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}