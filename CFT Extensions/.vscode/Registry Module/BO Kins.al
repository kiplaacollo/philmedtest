page 50125 "BO Kins"
{
    PageType = listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Accounts Kins Table";
    AutoSplitKey = true;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                // field(No; Rec.No)
                // {

                // }
                // field("BO Application No"; Rec."BO Application No")
                // {

                // }
                field("Full Name"; Rec."Full Name")
                {

                }
                field("Relationship Type"; Rec."Relationship Type")
                {

                }
                field("ID Number"; Rec."ID Number")
                {

                }
                field("Is Beneficiary"; Rec."Is Beneficiary")
                {

                }
                field("Is Dependant"; Rec."Is Dependant")
                {

                }
                field("Email Address"; Rec."Email Address")
                {

                }
                field("Phone Number"; Rec."Phone Number")
                {

                }
                field("Percentage Allocation"; Rec."Percentage Allocation")
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