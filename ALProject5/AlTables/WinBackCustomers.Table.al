table 50013 "Win-Back Customers"
{

    fields
    {
        field(1; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Won Back"; Boolean)
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

