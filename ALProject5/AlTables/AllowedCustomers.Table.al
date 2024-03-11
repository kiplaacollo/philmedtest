table 50005 "Allowed Customers"
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
        field(3; "Has Package"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Date Added"; DateTime)
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

