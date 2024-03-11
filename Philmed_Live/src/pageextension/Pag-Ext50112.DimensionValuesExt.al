pageextension 50112 DimensionValuesExt extends "Dimension Values"
{
    layout
    {
        addafter("Dimension Value Type")
        {
            field("Sales Invoice Nos."; Rec."Sales Invoice Nos.")
            {
                ApplicationArea = all;
            }
            field("Cash Sale Nos."; Rec."Cash Sale Nos.")
            {
                ApplicationArea = all;
            }
            field("MPESA Till No."; Rec."MPESA Till No.")
            {
                ApplicationArea = all;
            }
            field("Daily Sales Target"; Rec."Daily Sales Target")
            {
                ApplicationArea = all;
            }
            field("Daily Customer Target"; Rec."Daily Customer Target")
            {
                ApplicationArea = all;
            }
        }

    }
}
