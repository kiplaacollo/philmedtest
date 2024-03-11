table 50755 PesaWise
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Payment ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Reference; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Amount Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Amount Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Details; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Payment Status"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Transfare Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; currency; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "tag name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "tag code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Global Account ID"; Code[100])
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

