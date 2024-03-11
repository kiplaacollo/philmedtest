page 50057 "Payments Tax Codes Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Fund Tax Codes";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Tax Code"; Rec."Tax Code")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Account Type"; Rec."Account Type")
                {

                }
                field("Account No"; Rec."Account No")
                {

                }
                field(Percentage; Rec.Percentage)
                {

                }
                field(Type; Rec.Type)
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