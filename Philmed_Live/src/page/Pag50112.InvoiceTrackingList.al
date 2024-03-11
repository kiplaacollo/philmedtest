page 50112 "Invoice Tracking List"
{
    ApplicationArea = All;
    Caption = 'Invoice Tracking List';
    PageType = List;
    SourceTable = "Sales Invoice Tracking";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Route Plan"; Rec."Route Plan")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Lines"; Rec."No. of Lines")
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Entry Time In"; Rec."Entry Time In")
                {
                    ApplicationArea = All;
                }
                field("Stores TAT (Mins)"; Rec."Stores TAT (Mins)")
                {
                    ApplicationArea = All;
                }
                field("First Confirm. TAT (Mins)"; Rec."First Confirm. TAT (Mins)")
                {
                    ApplicationArea = All;
                }
                field("Second Confirm. TAT (Mins)"; Rec."Second Confirm. TAT (Mins)")
                {
                    ApplicationArea = All;
                }
                field("Overall TAT(Hours)"; Rec."Overall TAT(Hours)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CheckIn)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Check In';
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Invoice Tracking Entry";

            }
            action(Stores)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Stores';
                Image = Warehouse;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Invoice Tracking Stores";

            }
            action(FirstConfirmation)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'First Confirmation';
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Invoice Tracking First Confirm";

            }
            /*action(SecondConfirmation)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Second Confirmation';
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Invoice Track Second Confirm";

            }*/
            action(Dispatch)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Dispatch';
                Image = Shipment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Invoice Tracking Dispatch";

            }
            action(Clearing)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cashier Clearing';
                Image = Shipment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Invoice Tracking Cashier";

            }
            action(UntrackedInvoices)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Untracked Invoices';
                Image = Track;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Sales Invoices Untracked";

            }
            action(ResetTracking)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reset Invoice Tracking';
                Image = Restore;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Reset Invoice Tracking";

            }

        }
    }

    trigger OnOpenPage()
    begin
        rec.SetFilter("Posting Date", '>=%1', Today);
        Rec.SetFilter("Entry Time In", '<>%1', 0DT);
        CurrPage.Update();
    end;
}
