page 50114 "Member Monthly Deductions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Member deductions table";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Fosa Account"; Rec."Fosa Account")
                {

                }
                field("Fosa Account No."; Rec."Fosa Account No.")
                {

                }
                field(Amount; Rec.Amount)
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