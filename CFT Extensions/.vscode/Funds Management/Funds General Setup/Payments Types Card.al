page 50055 "Payment Types Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Funds Transaction Types";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {

                }
                field("Transaction Description"; Rec."Transaction Description")
                {

                }
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Account Type"; Rec."Account Type")
                {

                }
                field("Account No"; Rec."Account No")
                {

                }
                field("Account Name"; Rec."Account Name")
                {

                }
                field("Default Grouping"; Rec."Default Grouping")
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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::Payment;
    end;

    var
        myInt: Integer;
}