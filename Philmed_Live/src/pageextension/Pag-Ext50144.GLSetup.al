pageextension 50144 "GL Setup" extends "General Ledger Setup"
{

    layout
    {
        addafter("Allow Posting To")
        {
            field("Work Start Time"; "Work Start Time")
            {
                ApplicationArea = all;
            }
            field("Work End Time"; "Work End Time")
            {
                ApplicationArea = all;
            }
        }
    }
}
