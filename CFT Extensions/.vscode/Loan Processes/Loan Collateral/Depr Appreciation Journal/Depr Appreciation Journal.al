page 50187 "Depr/Appreciation Journal"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Collateral Depr Appr Details";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {

                }
                field("Registered to"; Rec."Registered to")
                {

                }
                field("Valuation Type"; Rec."Valuation Type")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field(Value; Rec.Value)
                {

                }
                field("Valuation Year"; Rec."Valuation Year")
                {

                }
                field(Voided; Rec.Voided)
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