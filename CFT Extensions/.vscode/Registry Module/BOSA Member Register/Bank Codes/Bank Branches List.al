page 52001 "Bank Branches"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Bank Branches Table";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Bank Code"; Rec."Bank Code")
                {

                }
                field("Branch Code"; Rec."Branch Code")
                {

                }
                field("Branch Name"; Rec."Branch Name")
                {

                }
                field("Branch Physical Location"; Rec."Branch Physical Location")
                {

                }
                field("Branch Postal Code"; Rec."Branch Postal Code")
                {

                }
                field("Branch Address"; Rec."Branch Address")
                {

                }
                field("Branch Phone No."; Rec."Branch Phone No.")
                {

                }
                field("Branch Mobile No."; Rec."Branch Mobile No.")
                {

                }
                field("Branch Email Address"; Rec."Branch Email Address")
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