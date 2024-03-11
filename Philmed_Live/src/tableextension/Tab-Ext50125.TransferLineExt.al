tableextension 50125 TransferLineExt extends "Transfer Line"
{
    fields
    {
        field(50100; "Inventory Balance"; Decimal)
        {
            Caption = 'Inventory Balance (W)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity WHERE("Item No." = field("Item No."), "Location Code" = field("Transfer-from Code")));
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CalcFields("Inventory Balance");
                if "Quantity (Base)" > "Inventory Balance" then
                    Error('The available inventory for item %1 is lower than the entered quantity at this location', "Item No.");
            end;
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                TransferLine: Record "Transfer Line";
            begin
                If "Item No." <> '' then begin
                    //Sales Line
                    TransferLine.SetRange("Document No.", "Document No.");
                    TransferLine.SetRange("Item No.", "Item No.");
                    if TransferLine.FindFirst() then
                        Error('This Item already exists in this Order on Line No. %2', TransferLine."Line No.");
                end;

            end;
        }
    }

}
