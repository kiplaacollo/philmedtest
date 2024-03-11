page 50170 "Loan Charges Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Charges Table";
    CardPageId = 50171;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Charges Code"; Rec."Charges Code")
                {
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    Enabled = true;
                }
                field(Percentage; Rec.Percentage)
                {
                    Enabled = true;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Enabled = true;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Enabled = true;
                }
                field("Account No"; Rec."Account No")
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