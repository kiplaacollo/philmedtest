page 52012 "Loan Sectors List.al"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Sectors";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Sector Code"; Rec."Sector Code")
                {

                }
                field("Sector Name"; Rec."Sector Name")
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}