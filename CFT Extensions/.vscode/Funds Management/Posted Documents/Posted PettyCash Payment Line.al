page 50017 "Posted PettyCash Payment Line"
{
    PageType = List;
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
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Currency Factor"; Rec."Currency Factor")
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
                field("Retention Code"; Rec."Retention Code")
                {

                }
                field("Retention Amount"; Rec."Retention Amount")
                {

                }
                field("Retention Amount(LCY)"; Rec."Retention Amount(LCY)")
                {

                }
                field("Net Amount"; Rec."Net Amount")
                {

                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
                {

                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {

                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {

                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {

                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {

                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {

                }
                field("Applies-to ID"; Rec."Applies-to ID")
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