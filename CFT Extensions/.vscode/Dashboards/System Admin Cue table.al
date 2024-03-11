table 50450 "System admin cue table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Total Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Approval Status" = const(approved), Processed = const(true), "Member Posting Group" = filter('BO' | 'FO')));
        }
        field(3; "Total BO Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Approval Status" = const(approved), Processed = const(true), "Member Posting Group" = const('BO')));
        }
        field(4; "Total FO Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Approval Status" = const(approved), Processed = const(true), "Member Posting Group" = const('FO')));
        }
        field(5; "Total Member Deposits"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = const("Deposit Contribution")));
        }
        field(6; "Total Share Capital"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = const("Share Capital")));
        }
        field(7; "Total Registration Fees"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = const("Registration Fees")));
        }
        field(8; "Total Loan Book"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Transaction Type" = filter("Loan" | "Principal Repayment")));
        }
        field(9; "Active Loans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("End Use Status" = filter(Open | Pending)));
        }
        field(10; "Expired Loans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("End Use Status" = const(Done)));
        }
        field(11; "Approved Loans(Unposted)"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Approval Status" = const(Approved), Posted = const(false)));
        }
        field(12; "Pending Loans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Approval Status" = const("Pending Approval")));
        }
        field(13; "Active Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Membership Status" = const(active), Processed = const(true)));
        }
        field(14; "Dormant Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Membership Status" = const(Dormant), Processed = const(true)));
        }
        field(15; "Non-Active Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Membership Status" = const(Inactive), Processed = const(true)));
        }
        field(16; "Deceased Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Membership Status" = const(inactive), Processed = const(true)));
        }
        field(17; "Withdrawn Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Membership Status" = const(Withdrawal), Processed = const(true)));
        }
        field(18; "Female Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where(Gender = const(Female), "Membership Status" = const(Active), Processed = const(true)));
        }
        field(19; "Male Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where(Gender = const(Male), "Membership Status" = const(Active), Processed = const(true)));
        }
        field(20; "Cooporate Members"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("FO Account Category" = const(Corporate), Processed = const(true)));
        }
        field(21; "Normal Loans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Loan Product" = const('BRIDGE'), Posted = const(true)));
        }
        field(22; "Emergency Loans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Loan Product" = const('EMERGENCY'), Posted = const(true)));
        }
        field(23; "School Fees Loan"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Loan Product" = const('SCHOOL'), Posted = const(true)));
        }
        field(24; "Salary in Advance"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Loan Product" = const('SALARYADVANCE'), Posted = const(true)));
        }
        field(25; "Fosa Loan"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Loan Product" = const('FOSALOAN'), Posted = const(true)));
        }
        field(26; "Advance 1A"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Loan Product" = const('ADVANCE1A'), Posted = const(true)));
        }
        field(27; "Advance 1B"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Loan Product" = const('ADVANCE1B'), Posted = const(true)));
        }
        field(28; "Advance 1C"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Loans where("Loan Product" = const('ADVANCE1C'), Posted = const(true)));
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

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