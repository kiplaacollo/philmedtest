table 50754 "Update Items to Install"
{

    fields
    {
        field(1; "Serial No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                item: Record Item;
            begin
                item.Reset;
                item.SetRange(item."No.", "Item No");
                if item.Find('-') then
                    "Item Name" := item.Description;
            end;
        }
        field(3; "Item Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Location Code"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Customer No"; Code[40])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if customer.Get("Customer No") then
                    "Customer Name" := customer.Name;
            end;
        }
        field(6; Installed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date of Installation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Customer Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Staff No"; Code[40])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees.st_no, "Staff No");
                if Employees.Find('-') then begin
                    "Staff Name" := Employees.Name;
                end;
            end;
        }
        field(10; "Staff Name"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Serial No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        customer: Record Customer;
        Employees: Record pr_employees;
}

