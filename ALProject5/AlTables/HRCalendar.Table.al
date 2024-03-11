table 50445 "HR Calendar"
{

    fields
    {
        field(2; Year; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Starts; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Ends; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Current; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Year)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

