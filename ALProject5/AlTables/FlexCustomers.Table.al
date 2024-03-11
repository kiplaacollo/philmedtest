table 50016 "Flex Customers"
{

    fields
    {
        field(1; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                Customer.Reset;
                Customer.SetRange("No.", "Customer No");
                if Customer.Find('-') then
                    "Customer Name" := Customer.Name;
            end;
        }
        field(2; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Customer: Record Customer;
}

