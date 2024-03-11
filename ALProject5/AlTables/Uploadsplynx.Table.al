table 50023 "Upload splynx"
{

    fields
    {
        field(2; splynix_id; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; CustNo; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; splynix_id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

