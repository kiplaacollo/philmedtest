table 50047 "Techie Recoveries"
{

    fields
    {
        field(1; "Customer No"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Customer.Get("Customer No") then begin
                    "Customer Name" := Customer.Name;
                    Amount := 3000;
                end;
            end;
        }
        field(2; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Technician ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Regions; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Condition; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Reference No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date recovered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Recovery Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(12; "Bank Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
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

    var
        Customer: Record Customer;
}

