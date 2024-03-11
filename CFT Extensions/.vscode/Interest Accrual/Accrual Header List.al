page 50220 "Accrual Header List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Accrual Header";
    CardPageId = "Accrual Header Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {

                }
                field("Entry Date"; Rec."Entry Date")
                {

                }
                field("Loan Cutoff Date"; Rec."Loan Cutoff Date")
                {

                }
                field("Accrual Type"; Rec."Accrual Type")
                {

                }
                field("Total Count"; Rec."Total Count")
                {

                }
                field(Remarks; Rec.Remarks)
                {

                }
                field("Employer Code"; Rec."Employer Code")
                {

                }
                field("Employer Description"; Rec."Employer Description")
                {

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