table 50707 "Payroll Employee P9."
{

    fields
    {
        field(10; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.staff_no;
        }
        field(11; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Allowances; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Benefits; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Value Of Quarters"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Defined Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Owner Occupier Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Gross Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Taxable Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Tax Charged"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Insurance Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Tax Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; PAYE; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; NSSF; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; NHIF; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; Deductions; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Net Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Period Month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Period Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(31; Pension; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; HELB; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Payroll Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; period_code; Code[25])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Employee Code", period_code)
        {
        }
    }

    fieldgroups
    {
    }
}

