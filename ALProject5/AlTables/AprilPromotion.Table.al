table 50044 "April Promotion"
{

    fields
    {
        field(1; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Disconnection Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Reconnected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Date Reconnected"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Normal Package"; Code[50])
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

