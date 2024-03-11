page 50149 "Loan Classification Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Provision Register";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Classification; Rec.Classification)
                {
                    Enabled = true;
                }
                field("No. of Accounts"; Rec."No. of Accounts")
                {

                }
                field("Outstanding Loan Portfolio"; Rec."Outstanding Loan Portfolio")
                {

                }
                field("Required Provision"; Rec."Required Provision")
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