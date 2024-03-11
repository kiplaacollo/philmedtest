pageextension 50134 ValueEntriesExt extends "Value Entries"
{
    layout
    {
        addafter("Source No.")
        {
            field("Route Plan"; Rec."Route Plan")
            {
                ApplicationArea = all;
            }
            field("Payroll No."; Rec."Payroll No.")
            {
                ApplicationArea = all;
            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
