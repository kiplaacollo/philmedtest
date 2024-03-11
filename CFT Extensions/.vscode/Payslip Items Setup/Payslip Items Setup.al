table 50108 "Payslip Items Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Enabled = true;
        }
        field(4; "Payslip Item"; Code[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(5; "Payslip Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Basic pay",Allowance,"Statutory Deduction","Other Deduction",Provident,Relief;
            OptionCaption = 'Basic pay,Allowance,Statutory Deduction,Other Deduction,Provident,Relief';
            Enabled = true;
        }
        field(7; Taxable; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(8; Default; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
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