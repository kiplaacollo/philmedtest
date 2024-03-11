page 52014 "Loan Sectors Lv2 List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loans Sectors Lv2";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Level Two Code"; Rec."Level Two Code")
                {

                }
                field("Level Two Name"; Rec."Level Two Name")
                {

                }
                field("Level One Code"; Rec."Level One Code")
                {

                }
                field("Sector Code"; Rec."Sector Code")
                {

                }
                field("Level One Name"; Rec."Level One Name")
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