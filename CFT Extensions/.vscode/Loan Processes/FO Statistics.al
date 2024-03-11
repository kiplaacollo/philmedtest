page 50086 "FO Statistics"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    Caption = 'Customer Statistics';

    layout
    {
        area(Content)
        {
            group("Account Statistics")
            {
                field("New FO Balance"; Rec."New FO Balance")
                {
                    Caption = 'Book Balance';
                }
            }
            group("Loan Statistics")
            {
                field("Total Outstanding Loan"; Rec."Total Outstanding Loan")
                {

                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
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