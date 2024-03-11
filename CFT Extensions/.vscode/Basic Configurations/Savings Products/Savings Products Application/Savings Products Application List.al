page 50907 "Savings Application List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Savings Products Application";
    CardPageId = 50906;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Savings Product"; Rec."Savings Product")
                {

                }
                field("Account Name"; Rec."Account Name")
                {

                }
                field("Account Category"; Rec."Account Category")
                {

                }
                field("Monthly Savings"; Rec."Monthly Savings")
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