table 52009 "Checkoff Adv Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;


        }
        field(2; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Payroll Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Client Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Client Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Transaction Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Deduction Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "ID Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Fosa Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Fosa Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Principal; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Interest; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Installments; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Total Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Total Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Outstanding Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Loan Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Phone No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Entry No")
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