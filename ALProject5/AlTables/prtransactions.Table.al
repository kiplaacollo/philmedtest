table 50427 pr_transactions
{

    fields
    {
        field(1; staff_no; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.st_no;

            trigger OnValidate()
            begin
                ObjEmployees.Reset;
                ObjEmployees.SetRange(st_no, staff_no);
                if ObjEmployees.Find('-') then
                    Name := ObjEmployees.Name;
            end;
        }
        field(2; transaction_code; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_transaction_types.code;

            trigger OnValidate()
            begin
                ObjTransactionTypes.Reset;
                if ObjTransactionTypes.Get(transaction_code) then begin
                    group_no := ObjTransactionTypes.group_no;
                    gl_account_no := ObjTransactionTypes.acc_no;
                    group_order := ObjTransactionTypes.group_order;
                    sub_group_order := ObjTransactionTypes.sub_group_order;
                end;
            end;
        }
        field(3; group_title; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; transaction_reference; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; transaction_name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; group_order; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; sub_group_order; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; period_month; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; period_year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; period_code; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_periods.period_code;

            trigger OnValidate()
            begin
                ObjPeriods.Reset;
                ObjPeriods.Get(period_code);
                period_month := ObjPeriods.period_month;
                period_year := ObjPeriods.period_year;
            end;
        }
        field(12; gl_account_no; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(13; status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Open,Posted,Voided';
            OptionMembers = " ",Open,Posted,Voided;
        }
        field(14; group_no; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Name; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Loan No"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(17; DeleteNotAllowed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Sacco Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Loan Product Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Product Setup"."Product type";
        }
        field(20; "Loan Type"; Code[35])
        {
            TableRelation = "Loan Product Setup"."Product type";
        }
        field(21; "Transaction Code  Filter"; Code[30])
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; staff_no, transaction_code, period_code, "Loan No")
        {
            Clustered = true;
        }
        key(Key2; group_order, sub_group_order)
        {
        }
        key(Key3; "Loan No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ObjPeriods: Record pr_periods;
        ObjTransactionTypes: Record pr_transaction_types;
        ObjPayrollGeneralsetup: Record "Payroll General setup";
        ObjEmployees: Record pr_employees;
}

