table 50217 "Checkoff Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Advice No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Payroll Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Remitted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Allocated; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Unallocated; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Client Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Client Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Loan Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Saving Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Loan Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "ID Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Fosa Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Fosa Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Expected Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Variance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Principal; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Interest; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Staff Not Found"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Transaction Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Member Found"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; Reconciled; Boolean)
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