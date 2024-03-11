page 52013 "Loan Sectors Lv1 List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loans Sectors Lv1";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Level 1 Code"; Rec."Level 1 Code")
                {

                }
                field("Level One Name"; Rec."Level One Name")
                {

                }
                field("Sector Code"; Rec."Sector Code")
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