pageextension 50005 MyExtension extends "Customer Lookup"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Full Name"; Rec."Full Name")
            {
                ApplicationArea = all;
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