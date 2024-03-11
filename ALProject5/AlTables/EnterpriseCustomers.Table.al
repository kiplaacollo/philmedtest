table 50006 "Enterprise Customers"
{

    fields
    {
        field(1; No; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

