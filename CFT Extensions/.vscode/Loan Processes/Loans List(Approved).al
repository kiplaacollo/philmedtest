page 50144 "Loans List(Approved)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Loans;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where("Approval Status" = const(Approved));
    CardPageId = "Loans Card(Approved)";

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
                    Caption = 'Loan Account No';
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
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Amount Disbursed"; Rec."Amount Disbursed")
                {

                }
                field("Created By"; Rec."Created By")
                {

                }
                field("Application Date"; Rec."Application Date")
                {

                }
                field("Net Disbursed Amount"; Rec."Net Disbursed Amount")
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