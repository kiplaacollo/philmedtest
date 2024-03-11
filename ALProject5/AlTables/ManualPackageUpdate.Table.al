table 50048 "Manual Package Update"
{

    fields
    {
        field(1; CustNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Package; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; CustNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

