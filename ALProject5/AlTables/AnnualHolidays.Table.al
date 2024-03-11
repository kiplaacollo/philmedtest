table 50500 "Annual Holidays"
{

    fields
    {
        field(1; "code"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Day; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Month; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Holiday Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

