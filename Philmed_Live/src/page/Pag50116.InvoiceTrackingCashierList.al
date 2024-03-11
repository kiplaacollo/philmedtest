page 50116 "Invoice Tracking Cashier List"
{
    ApplicationArea = All;
    Caption = 'Invoice Tracking Cashier List';
    PageType = List;
    SourceTable = "Sales Invoice Tracking";
    UsageCategory = Tasks;
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
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Route Plan"; Rec."Route Plan")
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
                field(Rider; Rec.Rider)
                {
                    ApplicationArea = All;
                }
                field("Cashier Name"; Rec."Cashier Name")
                {
                    ApplicationArea = All;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Memo Amount"; Rec."Credit Memo Amount")
                {
                    ApplicationArea = All;
                }
                field(Dev; Rec.Dev)
                {
                    ApplicationArea = All;
                }
                field("Clearing Comments"; Rec."Clearing Comments")
                {
                    ApplicationArea = All;
                }
                field("Cashier Clearing Time"; Rec."Cashier Clearing Time")
                {
                    ApplicationArea = All;
                }
                field(Cleared; Rec.Cleared)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
