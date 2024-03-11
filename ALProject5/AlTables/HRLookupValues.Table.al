table 50632 "HR Lookup Values"
{
    LookupPageID = "HR Lookup Values List";

    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Religion,Language,Medical Scheme,Location,Contract Type,Qualification Type,Stages,Scores,Institution,Appraisal Type,Appraisal Period,Urgency,Succession,Security,Disciplinary Case Rating,Disciplinary Case,Disciplinary Action,Next of Kin,Country,Grade,Checklist Item,Appraisal Sub Category,Appraisal Group Item,Transport Type,Grievance Cause,Grievance Outcome,Appraiser Recommendation';
            OptionMembers = Religion,Language,"Medical Scheme",Location,"Contract Type","Qualification Type",Stages,Scores,Institution,"Appraisal Type","Appraisal Period",Urgency,Succession,Security,"Disciplinary Case Rating","Disciplinary Case","Disciplinary Action","Next of Kin",Country,Grade,"Checklist Item","Appraisal Sub Category","Appraisal Group Item","Transport Type","Grievance Cause","Grievance Outcome","Appraiser Recom";
        }
        field(2; "Code"; Code[70])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Notice Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Closed; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Last Date Modified" := Today;
            end;
        }
        field(7; "Contract Length"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Current Appraisal Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Disciplinary Case Rating"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST ("Disciplinary Case Rating"));
        }
        field(10; "Disciplinary Action"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST ("Disciplinary Action"));
        }
        field(14; From; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Basic Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "To be cleared by"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Remarks;
        }
        field(19; "Last Date Modified"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Supervisor Only"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Appraisal Stage"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Target Setting",FirstQuarter,SecondQuarter,ThirdQuarter,EndYearEvaluation;
        }
        field(22; "Previous Appraisal Code"; Code[70])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Type, "Code", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

