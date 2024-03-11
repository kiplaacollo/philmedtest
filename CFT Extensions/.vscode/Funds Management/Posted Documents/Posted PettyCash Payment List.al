page 50015 "Posted PettyCash Payment List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payments Header";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Posted PettyCash Payment Card";
    SourceTableView = where(Posted = const(true), "Payment Type" = const("Petty Cash"));

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