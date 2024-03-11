page 50148 "Loan IFRS Provision Setup"
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
                field(Vintage; Rec.Vintage)
                {

                }
                field("Provision Rate"; Rec."Provision Rate")
                {

                }
                field(count; Rec.Count)
                {

                }

                field("Gross Carrying Amount"; Rec."Gross Carrying Amount")
                {

                }
                field("Balance Above 90 Days"; Rec."Balance Above 90 Days")
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