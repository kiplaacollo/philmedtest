page 50130 "Sales Inv.Tracking Confm1 View"
{
    ApplicationArea = All;
    Caption = 'Sales Inv.Tracking Confm1 View';
    PageType = List;
    SourceTable = "Sales Inv. Tracking Confirm 1";
    UsageCategory = Lists;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
                }
                field("Cashier Clearing Time"; Rec."Cashier Clearing Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier Clearing Time field.';
                }
                field("Cashier Name"; Rec."Cashier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier Name field.';
                }
                field(Cleared; Rec.Cleared)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cleared field.';
                }
                field("Clearing Comments"; Rec."Clearing Comments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Clearing Comments field.';
                }
                field("Credit Memo Amount"; Rec."Credit Memo Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Memo Amount field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field(Dev; Rec.Dev)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dev field.';
                }
                field("Dispatch Personnel"; Rec."Dispatch Personnel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dispatch Personnel field.';
                }
                field("Dispatch Time"; Rec."Dispatch Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dispatch Time field.';
                }
                field("Entry Time In"; Rec."Entry Time In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry Time In field.';
                }
                field("First Confirm. Executive"; Rec."First Confirm. Executive")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Confirm. Executive field.';
                }
                field("First Confirm. TAT (Mins)"; Rec."First Confirm. TAT (Mins)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Confirm. TAT (Mins) field.';
                }
                field("First Confirmation Time In"; Rec."First Confirmation Time In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Confirmation Time In field.';
                }
                field("First Confirmation Time Out"; Rec."First Confirmation Time Out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Confirmation Time Out field.';
                }
                field("No. of Lines"; Rec."No. of Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Lines field.';
                }
                field("Overall TAT(Hours)"; Rec."Overall TAT(Hours)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Overall TAT(Hours) field.';
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Amount field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Reset By User ID"; Rec."Reset By User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reset By User ID field.';
                }
                field("Reset Date"; Rec."Reset Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reset Date field.';
                }
                field("Reset Host"; Rec."Reset Host")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reset Host field.';
                }
                field(Rider; Rec.Rider)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rider field.';
                }
                field("Route Plan"; Rec."Route Plan")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Route Plan field.';
                }
                field("Stores Executive"; Rec."Stores Executive")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stores Executive field.';
                }
                field("Stores TAT (Mins)"; Rec."Stores TAT (Mins)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stores TAT (Mins) field.';
                }
                field("Stores Time In"; Rec."Stores Time In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stores Time In field.';
                }
                field("Stores Time Out"; Rec."Stores Time Out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stores Time Out field.';
                }
                field("Trip No."; Rec."Trip No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trip No. field.';
                }
            }
        }
    }
}
