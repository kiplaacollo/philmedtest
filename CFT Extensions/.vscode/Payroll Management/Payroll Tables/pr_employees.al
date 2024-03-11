table 50425 pr_employees
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; st_no; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Code[70])
        {
            DataClassification = ToBeClassified;
        }
        field(5; joining_date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; basic_pay; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; posting_group; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; bank_code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; bank_name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "branch_code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; branch_name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; bank_account_no; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; nssf_no; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; nhif_no; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; pin_no; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; employee_email; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; department_code; Code[35])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employer Departments".Department;
        }
        field(18; job_group; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; job_title; Code[70])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Titles".Code;
        }
        field(20; id_no; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; contract_start_date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; contract_end_date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,active,"Tempory halt",exited;
        }
        field(24; pays_paye; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; pays_nssf; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; pays_nhif; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Period Filter"; Code[200])
        {
            FieldClass = FlowFilter;
            TableRelation = pr_periods.period_code;
        }
        field(28; "First Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                FnFullName;
            end;
        }
        field(29; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                FnFullName;
            end;
        }
        field(30; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                FnFullName;
            end;
        }
        field(31; "Insurance Company"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Policy No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Instalment Premium"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Financial Institution"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Mortgage No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Mortgage Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Mortgage End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Pension Scheme"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Pension Scheme No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Pension Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        // field(45; "Cummulative Savings"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(46; Retainer; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = MALE,FEMALE;
        }
        // field(48; "Annual Leave Account"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        // field(49; "Compassionate Leave Acc."; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        // field(50; "Maternity Leave Acc."; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        // field(51; "Paternity Leave Acc."; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        // field(52; "Sick Leave Acc"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        // field(53; "Study Leave Acc"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(54; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        // field(2023; "Allocated Leave Days"; Decimal)
        // {
        //     FieldClass = FlowField;

        // }
        field(53914; "Leave Type Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53915; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        // field(53916; "Total Leave Taken"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        // field(53917; "Total Leave Days"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     Editable = false;
        // }
        field(53918; "Leave Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        // field(53919; "Reimbursed Leave Days"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(53920; Supervisor; Code[28])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.st_no;
        }
        // field(53921; "Pre-adoptive Leave Acc."; Decimal)
        // {
        //     FieldClass = FlowField;

        // }
        field(53922; Picture; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(53923; Male; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53924; Female; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53925; "Supervisor Name"; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                employee: Record pr_employees;
            begin
                if employee.Get(Supervisor) then begin
                    "Supervisor Name" := employee.Name;
                end;
            end;
        }
        // field(53926; "Compensatory Leave"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
        field(53928; "Doc No for Leave Notification"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(53929; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53930; Contractor; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53931; Region; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Region.Code;
        }
        field(53932; "Employee Job Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,A,B,C,D,E,F,G,H;
        }
        field(53933; "Pays_Housing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53934; "Nature of Contract"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Fixed Term","Open Ended",Internship,"Independent Contractor";
        }
        field(53935; "Probation End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53936; "Last Working Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53937; "Reason for Separation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Unsatisfactory performance",Resignation,"Termination - Misconduct",Redundancy,"Non-Renewal of Contract","Termination of Probationary Contract";
        }
        field(53938; "Office/Field Based"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Site,Nanyuki,Nairobi;
        }
    }

    keys
    {
        key(Key1; st_no)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure FnFullName()
    begin
        Name := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
    end;

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}