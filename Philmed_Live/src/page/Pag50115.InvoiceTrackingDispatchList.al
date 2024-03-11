page 50115 "Invoice Tracking Dispatch List"
{
    ApplicationArea = All;
    Caption = 'Invoice Tracking Dispatch List';
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
                field("Dispatch Personnel"; Rec."Dispatch Personnel")
                {
                    ApplicationArea = All;
                }
                field(Rider; Rec.Rider)
                {
                    ApplicationArea = All;
                }
                field("Trip No."; Rec."Trip No.")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Time"; Rec."Dispatch Time")
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

            action(DispatchSticker)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Dispatch Sticker';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    DispatSticker: Report "Dispatch Sticker";
                    InvoiceTracking: Record "Sales Invoice Tracking";
                begin
                    InvoiceTracking.SetFilter("Invoice No.", Rec."Invoice No.");
                    DispatSticker.SetTableView(InvoiceTracking);
                    DispatSticker.Run();
                end;
            }
        }
    }
}
