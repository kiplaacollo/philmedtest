table 50630 "HR Jobs"
{
    DrillDownPageID = "HR Jobs List";
    LookupPageID = "HR Jobs List";

    fields
    {
        field(1; "Job ID"; Code[60])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Job Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(3; "No of Posts"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No of Posts" <> xRec."No of Posts" then
                    "Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(4; "Position Reporting to"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Jobs"."Job ID" WHERE (Status = CONST (Approved));
        }
        field(5; "Occupied Positions"; Integer)
        {
            CalcFormula = Count (pr_employees WHERE (job_title = FIELD ("Job ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Vacant Positions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                "Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(7; "Score code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(17; "Total Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Main Objective"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Key Position"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Category; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Grade; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Employee Requisitions"; Integer)
        {
            CalcFormula = Count ("HR Employee Requisitions" WHERE ("Job ID" = FIELD ("Job ID")));
            FieldClass = FlowField;
        }
        field(27; UserID; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Supervisor/Manager"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.st_no WHERE (status = CONST (active));

            trigger OnValidate()
            begin
                HREmp.Get("Supervisor/Manager");
                "Supervisor Name" := HREmp.Name;
            end;
        }
        field(29; "Supervisor Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(31; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "No. of Requirements"; Integer)
        {
            CalcFormula = Count ("HR Job Requirements" WHERE ("Job Id" = FIELD ("Job ID")));
            FieldClass = FlowField;
        }
        field(34; "No. of Responsibilities"; Integer)
        {
            CalcFormula = Count ("HR Job Responsiblities" WHERE ("Job ID" = FIELD ("Job ID")));
            FieldClass = FlowField;
        }
        field(44; "Is Supervisor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "G/L Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(46; "No series"; Code[20])
        {
            DataClassification = ToBeClassified;
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

    var
        HREmp: Record pr_employees;
}

