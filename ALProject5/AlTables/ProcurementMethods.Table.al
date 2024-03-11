table 50602 "Procurement Methods"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Invite/Advertise date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Invite/Advertise period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Open tender period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Evaluate tender period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Committee period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Notification period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Contract period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Planned Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Planned Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Actual Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

