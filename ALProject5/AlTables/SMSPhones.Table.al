table 50046 "SMS Phones"
{

    fields
    {
        field(1; "Phone Number"; Code[13])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Phone Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

