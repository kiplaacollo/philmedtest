table 50753 Regions
{

    fields
    {
        field(1; "Code"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

