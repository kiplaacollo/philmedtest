page 50016 "Posted PettyCash Payment Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payments Header";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                }
                field("Document Type"; Rec."Document Type")
                {

                }
                field("Payment "; Rec."Payment ")
                {
                    Caption = 'Payment Mode';
                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Currency Factor"; Rec."Currency Factor")
                {

                }
                field("Bank Account"; Rec."Bank Account")
                {

                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {

                }
                field("New Bank Account Balance"; Rec."New Bank Account Balance")
                {
                    Caption = 'Bank Account Balance';
                }
                field("Cheque Type"; Rec."Cheque Type")
                {

                }
                field("Cheque No"; Rec."Cheque No")
                {

                }
                field(Payee; Rec.Payee)
                {

                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {

                }
                field("Payment Description"; Rec."Payment Description")
                {

                }
                field("New Amount"; Rec."New Amount")
                {
                    Caption = 'Amount';
                }
                field("New Amount(LCY)"; Rec."New Amount(LCY)")
                {
                    Caption = 'Amount(LCY)';
                }
                field("New VAT Amount"; Rec."New VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("New VAT Amount(LCY)"; Rec."New VAT Amount(LCY)")
                {
                    Caption = 'VAT Amount(LCY)';
                }
                field("New Withholding Tax Amount"; Rec."New Withholding Tax Amount")
                {
                    Caption = 'WithHolding Tax Amount';
                }
                field("W/Tax Amount(LCY)"; Rec."W/Tax Amount(LCY)")
                {
                    Caption = 'WithHolding Tax Amount(LCY)';
                }
                field("New Net Amount"; Rec."New Net Amount")
                {
                    Caption = 'Net Amount';
                }
                field("New Net Amount(LCY)"; Rec."New Net Amount(LCY)")
                {
                    Caption = 'Net Amount(LCY)';
                }
                field("Document Date"; Rec."Document Date")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(Posted; Rec.Posted)
                {

                }
                field("Posted By"; Rec."Posted By")
                {

                }
                field("Date Posted"; Rec."Date Posted")
                {

                }
                field("Time Posted"; Rec."Time Posted")
                {

                }
                field(Cashier; Rec.Cashier)
                {

                }

            }
            group("Payment Line")
            {
                part(PaymentLine; "Payment Line")
                {
                    SubPageLink = "Document No" = field("No.");
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