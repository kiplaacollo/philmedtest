table 50012 MpesaCustomers
{

    fields
    {
        field(1; CustomerNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; CustomerNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

