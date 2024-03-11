table 50002 "Signed Invoice"
{

    fields
    {
        field(1; INVOICE; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; INVOICE)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

