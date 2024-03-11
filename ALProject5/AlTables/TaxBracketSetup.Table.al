table 50109 "Tax Bracket Setup"
{

    fields
    {
        field(1; "Tax Band"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(4; "Lower Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Upper Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Taxable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Tax Band")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

