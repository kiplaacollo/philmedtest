table 50615 "Value Postingg"
{

    fields
    {
        field(1; UserID; Code[25])
        {
            TableRelation = User;
        }
        field(2; "Value Posting"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

