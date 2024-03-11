page 50216 "Checkoff header list"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Checkoff Header";
    CardPageId = "Checkoff Header Card";
    SourceTableView = where(Status = const(Open));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Account Type"; Rec."Account Type")
                {

                }
                field("Account No"; Rec."Account No")
                {

                }
                field("Document No"; Rec."Document No")
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
                field("Employer Name"; Rec."Employer Name")
                {

                }
                field(Remarks; Rec.Remarks)
                {

                }
                field("Captured By"; Rec."Captured By")
                {

                }
                field(Status; Rec.Status)
                {
                    Editable = false;
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