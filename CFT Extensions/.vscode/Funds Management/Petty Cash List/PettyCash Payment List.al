page 50012 "PettyCash Payment List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payments Header";
    CardPageId = 50013;
    SourceTableView = where("Payment Type" = const("Petty Cash"), Posted = const(false));
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Document Type"; Rec."Document Type")
                {

                }
                field("Document Date"; Rec."Document Date")
                {

                }
                field(Payee; Rec.Payee)
                {

                }
                field("New Amount"; Rec."New Amount")
                {
                    Caption = 'Amount';
                }
                field("New Amount(LCY)"; Rec."New Amount(LCY)")
                {
                    Caption = 'Amount(LCY)';
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