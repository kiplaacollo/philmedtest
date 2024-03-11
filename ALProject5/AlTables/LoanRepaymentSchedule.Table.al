table 50432 "Loan Repayment Schedule"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Staff Loans"."Loan  No.";
        }
        field(2; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Loan Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Product Setup"."Product type";
        }
        field(8; "Closed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Principal Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Monthly Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Monthly Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Member Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Amount Repayed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(22; "Remaining Debt"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Instalment No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Actual Loan Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Repayment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Loan Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Actual Principal Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Actual Interest Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Actual Installment Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Schedule Principle"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Monthly Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Close Schedule"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Reschedule No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Key"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(37; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = pr_periods.end_date;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Member No.", "Reschedule No", "Instalment No", "Key")
        {
            Clustered = true;
        }
        key(Key2; "Member No.")
        {
        }
        key(Key3; "Actual Principal Paid")
        {
        }
        key(Key4; "Loan No.", "Member No.", "Actual Principal Paid")
        {
        }
    }

    fieldgroups
    {
    }
}

