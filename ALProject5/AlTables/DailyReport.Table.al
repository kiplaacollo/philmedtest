table 50020 "Daily Report"
{

    fields
    {
        field(1; "Report Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "No of New Customers"; Integer)
        {
            CalcFormula = Count (Customer WHERE ("Date Registered" = FIELD ("Report Date")));
            FieldClass = FlowField;
        }
        field(3; "Total Invoiced"; Decimal)
        {
            FieldClass = Normal;
        }
        field(4; "Total Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Total Unpaid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Report Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

