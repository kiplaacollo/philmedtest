page 50169 "Disbursement Card(Posted)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Disbursement";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where(Status = const(Posted));

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
                    Editable = false;
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