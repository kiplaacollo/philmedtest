table 50746 "Asset Submodule Line"
{

    fields
    {
        field(1; "Document No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No"; Code[40])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Item.Get("Item No") then begin
                    "Item Name" := Item.Description;
                end;
            end;
        }
        field(3; "Item Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Serial No"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Store; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE ("Is Store" = FILTER (true));
        }
        field(7; Transferred; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No", "Item No", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
}

