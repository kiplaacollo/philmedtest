page 50154 "Loan Collateral Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Collateral Set-up";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {

                }
                field(Type; Rec.Type)
                {

                }
                field("Security Description"; Rec."Security Description")
                {

                }
                field(Category; Rec.Category)
                {

                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
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