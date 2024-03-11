table 50220 "Accrual Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "no"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Client Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Client Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Loan Product"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Gl Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Global Dimension Code 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(13; "Global Dimension Code 2"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Outstanding Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Accrual Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Interest Due","Penalty Charged";
        }
        field(16; "Calculation Method"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Loan Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Amortized,"Reducing Balance","Straight Line",Discounted;
            OptionCaption = 'Amortized,Reducing Balance,Straight Line,Discounted';
        }
        field(17; "Loan Cutoff Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Payroll Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Action Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Acrual,Writeoff;
        }
        field(20; "Loan Stopped"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; no, "Entry No")
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