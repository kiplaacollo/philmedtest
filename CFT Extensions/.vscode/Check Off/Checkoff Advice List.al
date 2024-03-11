page 50203 "Checkoff Advice List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Checkoff Advice";
    CardPageId = "Checkoff Advice Page";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Entry Date"; Rec."Entry Date")
                {

                }
                field("Loan Cutoff Date"; Rec."Loan Cutoff Date")
                {

                }
                field("Total Count"; Rec."Total Count")
                {

                }
                field("Employer Code"; Rec."Employer Code")
                {

                }
                field(Remarks; Rec.Remarks)
                {

                }
                field("Captured By"; Rec."Captured By")
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