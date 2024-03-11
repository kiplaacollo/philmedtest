table 50030 "Custom Item Serials"
{

    fields
    {
        field(1; "Serial No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Serial No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

