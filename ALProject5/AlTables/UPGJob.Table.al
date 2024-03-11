table 104093 "UPG Job"
{
    Permissions =;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(1035; "Over Budget"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

