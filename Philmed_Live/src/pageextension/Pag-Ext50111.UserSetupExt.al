pageextension 50111 UserSetupExt extends "User Setup"
{
    layout
    {
        addafter("Register Time")
        {
            field("Allow Invoice Re-Print"; Rec."Allow Invoice Re-Print")
            {
                ApplicationArea = all;
            }
            field("Allow Sales Order Price Change"; Rec."Allow Sales Order Price Change")
            {
                ApplicationArea = all;
            }
            field("Allow Sales Cred. Memo Without Application"; Rec."Sales. Cre. Memo Wthout Appl.")
            {
                ApplicationArea = all;
            }
            field("Allow Sales Order Price Change Upwards Only"; Rec."Sales Order Price Upwards Only")
            {
                ApplicationArea = all;
            }
            field("Allow Journal Posting"; Rec."Allow Posting of Journals")
            {
                ApplicationArea = all;
            }
            field("Allow Printing Transfer Order"; Rec."Allow Printing Transfer Order")
            {
                ApplicationArea = all;
            }

            field("Allow Reset Invoice Tracking"; Rec."Allow Reset Invoice Tracking")
            {
                ApplicationArea = all;
            }
            field("Allow Item Journal Posting"; Rec."Allow Item Journal Posting")
            {
                ApplicationArea = all;
            }
            field("View Posted Sales Invoice"; Rec."View Posted Sales Invoice")
            {
                ApplicationArea = all;
            }
            field("View Sales Analysis Reports"; Rec."View Sales Analysis Reports")
            {
                ApplicationArea = all;
            }
            field("Access to General Journal"; Rec."Access to General Journal")
            {
                ApplicationArea = all;
            }
            field("Modify Customers"; Rec."Modify Customers")
            {
                ApplicationArea = all;
            }
            field("Modify Items"; Rec."Modify Items")
            {
                ApplicationArea = all;
            }
            field("Post Bank Reconciliation"; Rec."Post Bank Reconciliation")
            {
                ApplicationArea = all;
            }
            field("Create Sales Memo"; "Create Sales Memo")
            {
                ApplicationArea = all;
            }
            field("Work Start Time"; "Work Start Time")
            {
                caption = 'Work Start Time';
                ApplicationArea = all;
            }
            field("Work End Time"; "Work End Time")
            {
                caption = 'Work End Time';
                ApplicationArea = all;
            }

        }

    }
}