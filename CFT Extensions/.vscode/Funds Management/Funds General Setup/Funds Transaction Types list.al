page 50042 "Funds Transaction Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Funds Transaction Types";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {

                }
                field("Transaction Description"; Rec."Transaction Description")
                {

                }
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Account Type"; Rec."Account Type")
                {

                }
                field("Account Name"; Rec."Account Name")
                {

                }
                field("Account No"; Rec."Account No")
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