table 104094 "UPG Sales Invoice Header"
{

    fields
    {
        field(3; "No."; Code[20])
        {
        }
        field(827; "Credit Card No."; Code[20])
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

