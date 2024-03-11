table 50435 Departments
{

    fields
    {
        field(1; Department; Code[80])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Department)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

