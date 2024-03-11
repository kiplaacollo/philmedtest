table 50757 "Downtime Sectors"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Sector; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Start date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Downtime type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Downtime reason"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Dowtime ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Region; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; picked; Boolean)
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

