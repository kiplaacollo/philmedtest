table 50633 "HR Job Qualifications"
{

    fields
    {
        field(1; "Qualification Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST ("Qualification Type"));
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "Qualification Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

