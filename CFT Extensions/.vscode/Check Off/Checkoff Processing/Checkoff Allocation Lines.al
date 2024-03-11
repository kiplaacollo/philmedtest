table 50221 "Checkoff Allocation Lines"
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
        field(3; "Advice No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Deduction Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Transaction Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Loan No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Client Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Client Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Global Dimension Code 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(10; "Global Dimension Code 2"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Current Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Loan Product"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Recovery from Unallocated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Posted;
        }
        field(17; "Former Transaction Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Fosa Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Fosa Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Is Reallocation"; Boolean)
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