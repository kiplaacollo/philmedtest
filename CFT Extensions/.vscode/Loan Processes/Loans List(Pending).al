page 50142 "Loans List(Pending)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Loans;
    CardPageId = "Loans Card(Pending)";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan Number"; Rec."Loan Number")
                {

                }
                field("ED Loan Account No"; Rec."ED Loan Account No")
                {

                }
                field("Member Number"; Rec."Member Number")
                {

                }
                field("Full Name"; Rec."Full Name")
                {

                }
                field("Loan Product"; Rec."Loan Product")
                {

                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("System Recommended Amount"; Rec."System Recommended Amount")
                {
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Application Date"; Rec."Application Date")
                {

                }
                field("Created By"; Rec."Created By")
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