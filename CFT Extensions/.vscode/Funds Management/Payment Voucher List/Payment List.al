page 50000 "Payment List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payments Header";
    CardPageId = 50001;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where("Payment Type" = const(Normal), Posted = const(false));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {

                }
                field(Payee; Rec.Payee)
                {

                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {

                }
                field("Document Type"; Rec."Document Type")
                {

                }
                field("Document Date"; Rec."Document Date")
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
                field(Status; Rec.Status)
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