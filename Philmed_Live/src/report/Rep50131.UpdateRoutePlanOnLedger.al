report 50131 "UpdateRoutePlanOnLedger"
{
    ApplicationArea = All;
    Caption = 'UpdateRoutePlanOn Ledger';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = TableData "Item Ledger Entry" = rimd, TableData "Value Entry" = rimd;

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") where("Entry Type" = const(Sale), "Route Plan" = filter(''));
            trigger OnAfterGetRecord()
            var
                SalesShipment: Record "Sales Shipment Header";
                SalesCreditMemo: Record "Sales Cr.Memo Header";
            begin
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then begin
                    SalesShipment.Get("Document No.");
                    ItemLedgerEntry."Route Plan" := SalesShipment."Route Plan";
                    ItemLedgerEntry.Modify();
                end;
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Credit Memo" then begin
                    SalesCreditMemo.Get("Document No.");
                    ItemLedgerEntry."Route Plan" := SalesCreditMemo."Route Plan";
                    ItemLedgerEntry.Modify();
                end;
                Commit();
            end;
        }

        dataitem(ValueEntry; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.") where("Item Ledger Entry Type" = const(Sale), "Route Plan" = filter(''));
            trigger OnAfterGetRecord()
            var
                SalesInvoice: Record "Sales Invoice Header";
                SalesCreditMemo: Record "Sales Cr.Memo Header";
            begin
                if ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Invoice" then begin
                    SalesInvoice.Get("Document No.");
                    ValueEntry."Route Plan" := SalesInvoice."Route Plan";
                    ValueEntry.Modify();
                end;
                if ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Credit Memo" then begin
                    SalesCreditMemo.Get("Document No.");
                    ValueEntry."Route Plan" := SalesCreditMemo."Route Plan";
                    ValueEntry.Modify();
                end;
                Commit();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
