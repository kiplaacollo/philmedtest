table 104097 "UPG Purch. Cr. Memo Hdr."
{

    fields
    {
        field(3; "No."; Code[20])
        {
        }
        field(1300; Canceled; Boolean)
        {
            FieldClass = Normal;
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

