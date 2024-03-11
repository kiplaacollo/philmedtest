page 50050 "Payments General Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Funds General Setup";

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Payment Voucher Nos"; Rec."Payment Voucher Nos")
                {

                }
                field("Cash Voucher Nos"; Rec."Cash Voucher Nos")
                {

                }
                field("PettyCash Nos"; Rec."PettyCash Nos")
                {

                }
                field("Mobile Payment Nos"; Rec."Mobile Payment Nos")
                {

                }
                field("Receipt Nos"; Rec."Receipt Nos")
                {

                }
                field("Funds Transfer Nos"; Rec."Funds Transfer Nos")
                {

                }
                field("Imprest Nos"; Rec."Imprest Nos")
                {

                }
                field("Imprest Surrender Nos"; Rec."Imprest Surrender Nos")
                {

                }
                field("Claim Nos"; Rec."Claim Nos")
                {

                }
                field("Travel Advance Nos"; Rec."Travel Advance Nos")
                {

                }
                field("Travel Surrender Nos"; Rec."Travel Surrender Nos")
                {

                }
                field("SMS Request Series"; Rec."SMS Request Series")
                {

                }
                field("Checkoff Advice NOS"; Rec."Checkoff Advice NOS")
                {

                }
                field("Checkoff Header NOS"; Rec."Checkoff Header NOS")
                {

                }
                field("Interest Accrual Nos"; Rec."Interest Accrual Nos")
                {

                }
                field("Defaulter Notification Nos"; Rec."Defaulter Notification Nos")
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