page 50171 "Loan Charges Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Charges Table";

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Charges Code"; Rec."Charges Code")
                {
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    Enabled = true;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Enabled = true;
                }
                field("Account No"; Rec."Account No")
                {
                    Enabled = true;
                }
                field("Use Percentage"; Rec."Use Percentage")
                {
                    Enabled = true;
                }
                field(Percentage; Rec.Percentage)
                {
                    Enabled = true;
                }
                field(Amount; Rec.Amount)
                {
                    Enabled = true;
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