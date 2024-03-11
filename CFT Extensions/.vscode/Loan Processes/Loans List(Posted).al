page 50146 "Loans List(Posted)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Loans;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Loans Card(Posted)";
    SourceTableView = where("Approval Status" = const(Approved), Posted = const(true), Reversed = const(false));
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
                    Visible = false;
                }
                field("Member Number"; Rec."Member Number")
                {
                    Caption = 'Client Code';
                }
                field("Full Name"; Rec."Full Name")
                {

                }
                field("Loan Product"; Rec."Loan Product")
                {

                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    StyleExpr = true;
                    Style = Strong;
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
                field("New Amount Disbursed"; Rec."New Amount Disbursed")
                {
                    Caption = 'Amount Disbursed';
                }
                field("Application Date"; Rec."Application Date")
                {

                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {

                }
                field("Repayment Debut Date"; Rec."Repayment Debut Date")
                {

                }
                field("Created By"; Rec."Created By")
                {

                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {

                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {

                }
                field("Outstanding Loan"; Rec."Outstanding Loan")
                {

                }
                field("Interest Accrued Buffer"; Rec."Interest Accrued Buffer")
                {

                }
                field("Outstanding Suspense Rate"; Rec."Outstanding Suspense Rate")
                {
                    Caption = 'Outstanding Suspense Interest';
                }
                field("Outstanding Write Off"; Rec."Outstanding Write Off")
                {

                }
                field("UnAllocated Funds"; Rec."UnAllocated Funds")
                {
                    Caption = 'Prepayments';
                }
                field("Principal Paid"; Rec."Principal Paid")
                {

                }
                field("Principal Paid As At Cutoff"; Rec."Principal Paid As At Cutoff")
                {

                }
                field("Total Payable Amount"; Rec."Total Payable Amount")
                {

                }
                field("Due Date"; Rec."Due Date")
                {

                }
                field("Loan Processing Fees"; Rec."Loan Processing Fees")
                {

                }
                field("RM Code"; Rec."RM Code")
                {

                }
                field("RM Name"; Rec."RM Name")
                {

                }
                field("BO Group"; Rec."BO Group")
                {

                }
                field("Net Disbursement on Topup"; Rec."Net Disbursement on Topup")
                {
                    Caption = 'Net Disbursement';
                }
                field("End Use Status"; Rec."End Use Status")
                {
                    StyleExpr = ColorVar;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
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
    trigger OnAfterGetRecord()
    var
    // ColorVar: Text;
    begin
        if Rec."End Use Status" = Rec."End Use Status"::Open then
            ColorVar := 'Unfavorable'
        else
            if Rec."End Use Status" = Rec."End Use Status"::Pending then
                ColorVar := 'Ambiguous'
            else
                ColorVar := 'Favorable';
    end;

    trigger OnAfterGetCurrRecord()
    var
    // ColorVar: Text;
    begin
        if Rec."End Use Status" = Rec."End Use Status"::Open then
            ColorVar := 'Unfavorable'
        else
            if Rec."End Use Status" = Rec."End Use Status"::Pending then
                ColorVar := 'Ambiguous'
            else
                ColorVar := 'Favorable';
    end;

    var
        myInt: Integer;
        ColorVar: Text;
}