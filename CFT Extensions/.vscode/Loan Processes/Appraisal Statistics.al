page 50153 "Appraisal Statistics"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Loans;

    layout
    {
        area(Content)
        {
            group("Appraisal Statistics")
            {
                field("Max Qualification By Deposits"; Rec."Max Qualification By Deposits")
                {

                }
                field("Max Qualification By Salary"; Rec."Max Qualification By Salary")
                {

                }
                field("New Guaranteed Amount"; Rec."New Guaranteed Amount")
                {

                }
                field("New Collateral Amount"; Rec."New Collateral Amount")
                {

                }
                field("System Recommended Amount"; Rec."System Recommended Amount")
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