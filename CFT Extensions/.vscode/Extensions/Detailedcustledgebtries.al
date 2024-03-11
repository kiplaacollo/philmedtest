pageextension 50098 DetaildCustExt extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field(Description; Rec.Description) { ApplicationArea = all; }
            field("Transaction Type"; Rec."Transaction Type") { ApplicationArea = all; }
            field("Loan Product Code"; Rec."Loan Product Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
