table 50011 "Proforma Invoice Lines"
{

    fields
    {
        field(1; "Entry Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Package Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Customer Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Customer No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry Id", "Document No")
        {
            Clustered = true;
        }
        key(Key2; "Document No")
        {
        }
    }

    fieldgroups
    {
    }
}

