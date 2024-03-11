table 104096 "UPG Purch. Inv. Header"
{

    fields
    {
        field(3; "No."; Code[20])
        {
        }
        field(1300; "Canceled By"; Code[20])
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

