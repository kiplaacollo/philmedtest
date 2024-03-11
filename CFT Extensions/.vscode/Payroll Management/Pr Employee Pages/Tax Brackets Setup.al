
page 50711 "Tax Brackets Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Tax Bracket Setup";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Tax Band"; Rec."Tax Band")
                {

                }
                field("Lower Limit"; Rec."Lower Limit")
                {

                }
                field("Upper Limit"; Rec."Upper Limit")
                {

                }
                field(Percentage; Rec.Percentage)
                {

                }
                field("Taxable Amount"; Rec."Taxable Amount")
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