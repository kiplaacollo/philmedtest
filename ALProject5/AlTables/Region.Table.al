table 50042 Region
{
    DrillDownPageID = "Region List";
    LookupPageID = "Region List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Count"; Integer)
        {
            CalcFormula = Count (Region_location WHERE ("Doc No." = FIELD (Code)));
            Editable = false;
            FieldClass = FlowField;
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

