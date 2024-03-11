table 50026 "Update Customer Status"
{

    fields
    {
        field(2; "Customer No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

