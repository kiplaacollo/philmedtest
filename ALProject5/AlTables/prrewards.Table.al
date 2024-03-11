table 50430 pr_rewards
{

    fields
    {
        field(1; rm_band; Code[10])
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
        field(5; chargable_amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; rm_band)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

