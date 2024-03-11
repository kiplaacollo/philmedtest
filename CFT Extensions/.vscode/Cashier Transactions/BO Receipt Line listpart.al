page 50063 "BO Receipt Line"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "BO Receipt Line";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Saving Product"; Rec."Saving Product")
                {
                    Caption = 'savings Product';
                    trigger OnValidate()
                    begin

                    end;
                }
                field("Client Code"; Rec."Client Code")
                {

                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Loan No"; Rec."Loan No")
                {

                }
                field(Amount; Rec.Amount)
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
        foaccounts: Record Customer;
}