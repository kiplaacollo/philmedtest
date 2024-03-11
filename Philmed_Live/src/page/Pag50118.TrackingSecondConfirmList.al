page 50118 "Tracking Second Confirm List"
{
    ApplicationArea = All;
    Caption = 'Tracking Second Confirm List';
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
                field("Second Confirm. Executive"; Rec."Second Confirm. Executive")
                {
                    ApplicationArea = All;
                }
                field("Second Confirm. Time In"; Rec."Second Confirm. Time In")
                {
                    ApplicationArea = All;
                }
                field("Second Confirm. Time Out"; Rec."Second Confirm. Time Out")
                {
                    ApplicationArea = All;
                }
                field("Second Confirm. TAT (Mins)"; Rec."Second Confirm. TAT (Mins)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
