page 50054 "Payment Types List"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Funds Transaction Types";
    CardPageId = "Payment Types Card";
    SourceTableView = where("Transaction Type" = const(Payment));

    layout
    {
        area(Content)
        {
            repeater(Group)
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