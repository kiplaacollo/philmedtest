tableextension 50119 UserSetupExtenstion extends "User Setup"
{
    fields
    {
        field(50100; "Allow Invoice Re-Print"; Boolean)
        {
            Caption = 'Allow Invoice Re-Print';
            DataClassification = ToBeClassified;
        }
        field(50101; "Allow Sales Order Price Change"; Boolean)
        {
            Caption = 'Allow Sales Order Price Change';
            DataClassification = ToBeClassified;
        }
        field(50102; "Sales. Cre. Memo Wthout Appl."; Boolean)
        {
            Caption = 'Allow Sales Credit Memo Without Application';
            DataClassification = ToBeClassified;
        }
        field(50103; "Sales Order Price Upwards Only"; Boolean)
        {
            Caption = 'Allow SalesOrder Price Change Upwards Only';
            DataClassification = ToBeClassified;
        }
        field(50104; "Allow Posting of Journals"; Boolean)
        {
            Caption = 'Allow Posting of General,Cash Receipt and Payment Journals';
            DataClassification = ToBeClassified;
        }
        field(50105; "Allow Printing Transfer Order"; Boolean)
        {
            Caption = 'Allow Printing of Transfer Order Report';

        }
        field(50106; "Allow Reset Invoice Tracking"; Boolean)
        {
            Caption = 'Allow Reset Invoice Tracking';
        }
        field(50107; "Allow Item Journal Posting"; Boolean)
        {
            Caption = 'Allow Item Journal Posting';
        }
        field(50108; "View Posted Sales Invoice"; Boolean)
        {
            Caption = 'View Posted Sales Invoice';
        }
        field(50109; "View Sales Analysis Reports"; Boolean)
        {
            Caption = 'View Sales Analysis Reports';
        }
        field(50110; "Access to General Journal"; Boolean)
        {
            Caption = 'Access to General Journal';
        }
        field(50111; "Modify Customers"; Boolean)
        {
            Caption = 'Modify Customers';
        }
        field(50112; "Modify Items"; Boolean)
        {
            Caption = 'Modify Items';
        }
        field(50113; "Post Bank Reconciliation"; Boolean)
        {
            Caption = 'Post Bank Reconciliation';
        }
        field(50114; "Work Start Time"; Time)
        {
            caption = 'Work Start Time';
        }
        field(50115; "Work End Time"; Time)
        {
            caption = 'Work End Time';
        }
        field(50116; "Create Sales Memo"; Boolean)
        {
            Caption = 'Create Sales Credit Memo';
        }
    }
}
