page 50117 "Tracking First Confirm List"
{
    ApplicationArea = All;
    Caption = 'Tracking First Confirm List';
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
                field("First Confirm. Executive"; Rec."First Confirm. Executive")
                {
                    ApplicationArea = All;
                }
                field("First Confirmation Time In"; Rec."First Confirmation Time In")
                {
                    ApplicationArea = All;
                }
                field("First Confirmation Time Out"; Rec."First Confirmation Time Out")
                {
                    ApplicationArea = All;
                }
                field("First Confirm. TAT (Mins)"; Rec."First Confirm. TAT (Mins)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
