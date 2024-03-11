page 52007 "Checkoff Allocation Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Checkoff Allocation Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Client Code"; Rec."Client Code")
                {

                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Loan No"; Rec."Loan No")
                {

                }
                field("Fosa Account"; Rec."Fosa Account")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field("Advice No"; Rec."Advice No")
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