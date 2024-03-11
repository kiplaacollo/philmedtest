table 104073 "UPG Nonstock Item"
{
    DrillDownPageID = "Catalog Item List";
    LookupPageID = "Catalog Item List";

    fields
    {
        field(1; "Entry No."; Code[20])
        {
            Editable = true;
        }
        field(12; "Item Category Code"; Code[10])
        {
        }
        field(13; "Product Group Code"; Code[10])
        {
        }
        field(16; "Item No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

