page 50163 "Disbursement Card(New)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Disbursement";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                }
                field("Client No"; Rec."Client No")
                {

                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Loan No"; Rec."Loan No")
                {

                }
                field("ED Loan Account No"; Rec."ED Loan Account No")
                {

                }
                field("Disbursement Type"; Rec."Disbursement Type")
                {

                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Editable = false;
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    Editable = false;
                }
                field("Balance Outstanding"; Rec."Balance Outstanding")
                {

                }
                field("Requested Amount"; Rec."Requested Amount")
                {

                }
                field("Amount to Disburse"; Rec."Amount to Disburse")
                {

                }
                field("Total Upfront Deductions"; Rec."Total Upfront Deductions")
                {

                }
                field("Loan Perfection Charges"; Rec."Loan Perfection Charges")
                {

                }
                field("Loan Prepayments"; Rec."Loan Prepayments")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {

                }
                field("Approval Date"; Rec."Approval Date")
                {

                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {

                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Paying Bank"; Rec."Paying Bank")
                {

                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {

                }
                field("Cheque No/Reference No"; Rec."Cheque No/Reference No")
                {

                }
                field("Booked By"; Rec."Booked By")
                {

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    disbursementworkflow: Codeunit "Disbursement Workflow";
                begin
                    RecRef.GetTable(Rec);
                    if disbursementworkflow.CheckApprovalsWorkflowEnabled(RecRef) then
                        disbursementworkflow.OnSendWorkflowForApproval(RecRef);

                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = all;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    RecRef: RecordRef;
                    disbursementworkflow: Codeunit "Disbursement Workflow";
                begin
                    RecRef.GetTable(Rec);
                    disbursementworkflow.OnCancelWorkflowForApproval(RecRef);
                end;
            }

        }
    }

    var
        myInt: Integer;
}