table 50446 "HR Calendar List"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Day; Text[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Non Working"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Reason; Text[40])
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

