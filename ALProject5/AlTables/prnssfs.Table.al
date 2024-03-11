table 50422 pr_nssfs
{

    fields
    {
        field(1; nssf_band; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; lower_limit; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; upper_limit; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; taxable_amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; nssf_band)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

