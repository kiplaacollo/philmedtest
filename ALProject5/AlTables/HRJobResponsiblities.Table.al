table 50634 "HR Job Responsiblities"
{

    fields
    {
        field(2; "Job ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs"."Job ID";
        }
        field(3; "Responsibility Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Responsibility Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // HRAppEvalArea.RESET;
                // HRAppEvalArea.SETRANGE(HRAppEvalArea."Assign To","Responsibility Code");
                // IF HRAppEvalArea.FIND('-') THEN
                // BEGIN
                //    "Responsibility Description":=HRAppEvalArea.Code;
                // END;
            end;
        }
    }

    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

