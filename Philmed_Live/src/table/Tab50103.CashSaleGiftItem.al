table 50103 "Cash Sale Gift Item"
{
    Caption = 'Cash Sale Gift Item';
    DrillDownPageId = "Cash Sale Gift Items";
    LookupPageId = "Cash Sale Gift Items";

    fields
    {
        field(1; "Cash Sale Limit (LCY)"; Decimal)
        {
            Caption = 'Cash Sale Limit (LCY)';
        }
        field(2; "Line No."; Code[10])
        {
            Caption = 'Line No.';
        }
        field(3; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if "Item Code" <> '' then begin
                    Item.Get("Item Code");
                    "Item Name" := Item.Description;
                end else begin
                    "Item Name" := '';
                end;
            end;
        }
        field(4; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
            Editable = false;
        }
        field(5; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = field("Item Code"));
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Cash Sale Limit (LCY)", "Line No.")
        {
            Clustered = true;
        }
    }
}
