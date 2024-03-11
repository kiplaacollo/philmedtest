page 50051 "Payments User Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Funds User Setup";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {

                }
                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {

                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {

                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {

                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {

                }
                field("Petty Cash Template"; Rec."Petty Cash Template")
                {

                }
                field("Petty Cash Batch"; Rec."Petty Cash Batch")
                {

                }
                field("Biling Template"; Rec."Biling Template")
                {

                }
                field("Biling Batch"; Rec."Biling Batch")
                {

                }
                field("FundsTransfer Template Name"; Rec."FundsTransfer Template Name")
                {

                }
                field("FundsTransfer Batch Name"; Rec."FundsTransfer Batch Name")
                {

                }
                field("Default Receipts Bank"; Rec."Default Receipts Bank")
                {

                }
                field("Default Payment Bank"; Rec."Default Payment Bank")
                {

                }
                field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
                {

                }
                field("Max. Cash Collection"; Rec."Max. Cash Collection")
                {

                }
                field("Max. Cheque Collection"; Rec."Max. Cheque Collection")
                {

                }
                field("Max. Deposit Slip Collection"; Rec."Max. Deposit Slip Collection")
                {

                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {

                }
                field("Bank Pay in Journal Teplate"; Rec."Bank Pay in Journal Template")
                {

                }
                field("Bank Pay in Journal Batch"; Rec."Bank Pay in Journal Batch")
                {

                }
                field("Imprest Template"; Rec."Imprest Template")
                {

                }
                field("Imprest Batch"; Rec."Imprest Batch")
                {

                }
                field("Claim Template"; Rec."Claim Template")
                {

                }
                field("Claim Batch"; Rec."Claim Batch")
                {

                }
                field("Advance Template"; Rec."Advance Template")
                {

                }
                field("Advance Batch"; Rec."Advance Batch")
                {

                }
                field("Advance Surr Template"; Rec."Advance Surr Template")
                {

                }
                field("Advance Surr Batch"; Rec."Advance Surr Batch")
                {


                }
                field("Dim Change Journal Template"; Rec."Dim Change Journal Template")
                {

                }
                field("Dim Change Journal Batch"; Rec."Dim Change Journal Batch")
                {

                }
                field("Journal Voucher Template"; Rec."Journal Voucher Template")
                {

                }
                field("Journal Voucher Batch"; Rec."Journal Voucher Batch")
                {

                }
                field("Payroll Template"; Rec."Payroll Template")
                {

                }
                field("Payroll Batch"; Rec."Payroll Batch")
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