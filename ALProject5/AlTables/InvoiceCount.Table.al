table 50029 "Invoice Count"
{

    fields
    {
        field(1; "Count"; Integer)
        {
            CalcFormula = Count ("Sales Invoice Header" WHERE ("Posting Date" = FIELD ("Posting Date")));
            FieldClass = FlowField;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Posting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

