table 104095 "UPG Sales Cr.Memo Header"
{

    fields
    {
        field(3; "No."; Code[20])
        {
        }
        field(827; "Credit Card No."; Code[20])
        {
        }
        field(1300; Canceled; Boolean)
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

