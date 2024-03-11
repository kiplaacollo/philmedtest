table 50009 Disconn
{

    fields
    {
        field(1; "Cust No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Package; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Cust No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

