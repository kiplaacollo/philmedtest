page 50026 "Receipt Line"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Receipt Line";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {

                }
                field("Document Type"; Rec."Document Type")
                {

                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Visible = false;
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {

                }
                field("Account Code"; Rec."Account Code")
                {

                }
                field("Account Name"; Rec."Account Name")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
                field("Pay Mode"; Rec."Pay Mode")
                {

                }
                field("Cheque No"; Rec."Cheque No")
                {

                }
                field(Date; Rec.Date)
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
                field("Applies-to Doc No."; Rec."Applies-to Doc No.")
                {

                }
                field("Applies-To ID"; Rec."Applies-To ID")
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::Receipt;
    end;

    var
        myInt: Integer;
}