page 50214 "cr transaction types list"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "cr transaction types table";
    CardPageId = "cr Transaction Types";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Loan Type"; Rec."Loan Type")
                {

                }
                field("Account No"; Rec."Account No")
                {

                }
                field("Minimum Contribution"; Rec."Minimum Contribution")
                {

                }
                field("Fosa Transaction"; Rec."Fosa Transaction")
                {

                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {

                }
                field("Global Transaction Type"; Rec."Global Transaction Type")
                {

                }
                field("Process Checkoff"; Rec."Process Checkoff")
                {

                }
                field("Activity Code"; Rec."Activity Code")
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