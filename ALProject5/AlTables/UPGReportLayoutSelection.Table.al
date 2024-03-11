table 104089 "UPG Report Layout Selection"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Report ID"; Integer)
        {
        }
        field(2; "Report Name"; Text[80])
        {
            Editable = false;
        }
        field(3; "Company Name"; Text[30])
        {
            TableRelation = Company;
        }
        field(6; "Custom Report Layout ID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Report ID", "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

