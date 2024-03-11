table 50041 County_location
{

    fields
    {
        field(1; "Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = false;
            TableRelation = County;
        }
        field(2; Number; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = true;
            NotBlank = false;
            TableRelation = County_location.Number WHERE (Number = FIELD (Number));
        }
        field(3; "Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Doc No.", Number)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

