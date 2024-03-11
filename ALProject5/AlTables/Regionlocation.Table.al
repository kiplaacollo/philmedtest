table 50043 Region_location
{

    fields
    {
        field(1; "Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
            TableRelation = Region;
        }
        field(2; Number; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = true;
            NotBlank = false;
            TableRelation = Region_location.Number WHERE (Number = FIELD (Number));
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

