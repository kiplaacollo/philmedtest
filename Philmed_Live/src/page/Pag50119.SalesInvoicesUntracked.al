page 50119 "Sales Invoices Untracked"
{
    ApplicationArea = All;
    Caption = 'Sales Invoices Untracked';
    PageType = List;
    SourceTable = "Sales Invoice Header";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
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
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        lvSalesInvoiceHeader: Record "Sales Invoice Header";
        lvSalesInvoiceTracking: Record "Sales Invoice Tracking";
    begin
        lvSalesInvoiceHeader.SetRange("Posting Date", Today);
        if lvSalesInvoiceHeader.FindFirst() then
            repeat
                lvSalesInvoiceTracking.SetRange("Invoice No.", lvSalesInvoiceHeader."No.");
                If not lvSalesInvoiceTracking.FindFirst() then begin
                    Rec.Init();
                    rec.TransferFields(lvSalesInvoiceHeader);
                    Rec.Insert();
                end;
            until lvSalesInvoiceHeader.Next() = 0;

    end;
}
