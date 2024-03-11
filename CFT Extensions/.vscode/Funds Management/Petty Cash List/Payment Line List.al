page 50002 "Payment Line"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payment Line Table";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Transaction Type Description"; Rec."Transaction Type Description")
                {
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {

                }
                field("Account No."; Rec."Account No.")
                {

                }
                field("Account Name"; Rec."Account Name")
                {

                }
                field("Payment Description"; Rec."Payment Description")
                {

                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {

                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {

                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {

                }
                field("VAT Code"; Rec."VAT Code")
                {

                }
                field("VAT Amount"; Rec."VAT Amount")
                {

                }
                field("VAT Amount(LCY)"; Rec."VAT Amount(LCY)")
                {

                }
                field("W/TAX Code"; Rec."W/TAX Code")
                {

                }
                field("W/TAX Amount"; Rec."W/TAX Amount")
                {

                }
                field("W/TAX Amount(LCY)"; Rec."W/TAX Amount(LCY)")
                {

                }
                field("Net Amount"; Rec."Net Amount")
                {

                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
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