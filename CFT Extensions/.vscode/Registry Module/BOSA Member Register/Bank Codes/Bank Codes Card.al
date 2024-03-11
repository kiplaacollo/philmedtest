page 52000 "Bank Codes Card"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Bank Codes";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Bank Code"; Rec."Bank Code")
                {

                }
                field("Bank Name"; Rec."Bank Name")
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