page 50150 "Guarantors(New)"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Guarantors Table";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan Number"; Rec."Loan Number")
                {

                }
                field("Guarantor Number"; Rec."Guarantor Number")
                {

                }
                field("Guarantor Full Name"; Rec."Guarantor Full Name")
                {

                }
                field("ID Number"; Rec."ID Number")
                {

                }
                field("Phone No"; Rec."Phone No")
                {

                }
                field("Email Address"; Rec."Email Address")
                {

                }
                field("Guaranteed Amount"; Rec."Guaranteed Amount")
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