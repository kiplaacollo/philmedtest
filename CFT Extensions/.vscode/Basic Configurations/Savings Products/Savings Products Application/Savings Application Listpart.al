page 50909 "Savings Application Listpart"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Savings Table4";
    // CardPageId = 50908;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                // field("Savings No"; Rec."Savings No")
                // {

                // }
                // field("BO Application No"; Rec."BO Application No")
                // {

                // }
                field("Savings Product"; Rec."Savings Product")
                {

                }
                field("First Name"; Rec."First Name")
                {

                }
                field("Last Name"; Rec."Last Name")
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