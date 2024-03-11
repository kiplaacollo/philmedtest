table 50028 "Invoice Tracker"
{

    fields
    {
        field(1; "Erntry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Invoice No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Source; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Erntry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

