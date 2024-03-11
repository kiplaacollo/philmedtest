table 50631 "HR Job Requirements"
{

    fields
    {
        field(1; "Job Id"; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "HR Jobs"."Job ID";
        }
        field(2; "Qualification Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code WHERE (Type = FILTER ("Qualification Type"));
        }
        field(3; "Qualification Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            NotBlank = true;
            TableRelation = "HR Job Qualifications".Code WHERE ("Qualification Type" = FIELD ("Qualification Type"));

            trigger OnValidate()
            begin
                /*.SETFILTER(Requirments."Qualification Type","Qualification Type");
                Requirments.SETFILTER(Requirments.Code,"Qualification Code");
                IF Requirments.FIND('-') THEN
                 Qualification := Requirments.Description; */


                if HRQualifications.Get("Qualification Type", "Qualification Code") then
                    "Qualification Description" := HRQualifications.Description;

            end;
        }
        field(6; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",High,Medium,Low;
        }
        field(8; "Score ID"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Need code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Table0;
        }
        field(10; "Stage Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST (Scores));
        }
        field(11; Mandatory; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Desired Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Total (Stage)Desired Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Qualification Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Job Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRQualifications: Record "HR Job Qualifications";
}

