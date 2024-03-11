page 50906 "Savings Application Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Savings Products Application";

    layout
    {
        area(Content)
        {
            group(GroupName)
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