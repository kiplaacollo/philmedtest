table 104074 "UPG Product Group"
{

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
        }
        field(2; "Code"; Code[10])
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(7300; "Warehouse Class Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Item Category Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

