table 50421 pr_nhifs
{

    fields
    {
        field(1; nhif_band; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; lower_limit; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; upper_limit; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; nhif_band)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

