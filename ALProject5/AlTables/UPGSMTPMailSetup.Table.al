table 104082 "UPG SMTP Mail Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(5; Password; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

