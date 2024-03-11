pageextension 50124 ItemLedgerEntryExt extends "Item Ledger Entries"
{
    layout
    {
        addafter(Open)
        {
            field("Expiry Date"; Rec."Expiry Date")
            {
                ApplicationArea = all;
            }
            field("Batch No."; Rec."Batch No.")
            {
                ApplicationArea = all;
            }
            field("Route Plan"; Rec."Route Plan")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addbefore("F&unctions")
        {
            action(ItemLedgerCard)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Ledger Card';
                Image = Ledger;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    RptItemLedgerCard: Report "Item Ledger Card";
                    ItemLedgerEntry: Record "Item Ledger Entry";
                begin
                    ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                    RptItemLedgerCard.SetTableView(ItemLedgerEntry);
                    RptItemLedgerCard.Run();
                end;
            }
        }
    }
}
