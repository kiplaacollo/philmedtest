
pageextension 52005 "General Journal Extension" extends "General Journal"
{

    layout
    {
        // Add changes to page layout 
        addafter(Description)
        {
            field("Loan Number"; Rec."Loan Number")
            {
                ApplicationArea = all;
            }
            field("Unallocated Account No"; Rec."Unallocated Account No")
            {
                ApplicationArea = all;
            }
        }
        addafter("Document No.")
        {
            field("Transaction Type"; Rec."Transaction Type")
            {
                Caption = 'Prepayments Account No';
                ApplicationArea = all;
            }
            field("Loan Product Code"; Rec."Loan Product Code")
            {
                ApplicationArea = all;
            }
        }
        // addafter("Direct Debit Mandate ID")
        // {
        //     field("Account Name"; Rec."Account Name")
        //     {

        //     }
        // }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}