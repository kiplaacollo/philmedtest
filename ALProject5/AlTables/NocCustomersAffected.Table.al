table 50758 "Noc Customers Affected"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Phone No"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Sector; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "message sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Start date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "End time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Downtime type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

