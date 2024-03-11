table 50700 pr_employees
{
    // version Payroll Management v1.0.0


    fields
    {
        field(1; staff_no; Code[20])
        {
            Caption = 'Staff No';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[200])
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
        field(10; branch_code; Code[20])
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
        field(17; department_code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; job_group; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; job_title; Code[20])
        {
            DataClassification = ToBeClassified;
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
            OptionCaption = ' ,active,Tempory halt,exited';
            OptionMembers = " ",active,"Tempory halt",exited;
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
                FnFullName
            end;
        }
        field(29; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                FnFullName
            end;
        }
        field(30; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                FnFullName
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
        field(36; "Finacial Institution"; Text[100])
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
    }

    keys
    {
        key(Key1; staff_no)
        {
        }
    }

    fieldgroups
    {
    }

    local procedure FnFullName()
    begin
        Name := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
    end;
}

