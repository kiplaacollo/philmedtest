page 50113 "Invoice Tracking Entry List"
{
    ApplicationArea = All;
    Caption = 'Invoice Tracking Entry List';
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
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Entry Time In"; Rec."Entry Time In")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
