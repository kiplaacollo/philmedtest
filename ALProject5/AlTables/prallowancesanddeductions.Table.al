table 50424 pr_allowances_and_deductions
{

    fields
    {
        field(1; st_no; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.st_no;
        }
        field(2; transaction_code; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_transaction_types.code WHERE (Type = CONST ("Deduction/Allowance"));

            trigger OnValidate()
            begin
                ObjTransactionTypes.Reset;
                ObjTransactionTypes.Get(transaction_code);
                amount_reference := ObjTransactionTypes.amount_reference;
                transaction_name := ObjTransactionTypes.trans_name;
                group_title := ObjTransactionTypes.group_title;
                taxable := ObjTransactionTypes.taxable;
                frequency := ObjTransactionTypes.frequency;
                ObjPeriods.Reset;
                ObjPeriods.SetRange(Active, true);
                if ObjPeriods.Find('-') then begin
                    period_code := ObjPeriods.period_code;
                    period_year := ObjPeriods.period_year;
                    period_month := ObjPeriods.period_month;
                end;
            end;
        }
        field(3; transaction_name; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; period_month; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; period_year; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; period_code; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; group_order; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; sub_group_order; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; gl_account_no; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; gl_account_name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; amount_reference; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,INCOME,DEDUCTION';
            OptionMembers = " ",INCOME,DEDUCTION;
        }
        field(13; group_title; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(14; "loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "loan type"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Loans"."Loan product type";
        }
        field(16; "Sacco Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; taxable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; frequency; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Fixed,Varied';
            OptionMembers = " ","Fixed",Varied;
        }
    }

    keys
    {
        key(Key1; st_no, transaction_code, period_code, "loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjTransactionTypes: Record pr_transaction_types;
        ObjPeriods: Record pr_periods;
}

