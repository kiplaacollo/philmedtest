table 1281 "Bank Data Conversion Pmt. Type"
{
    Caption = 'Bank Data Conversion Pmt. Type';
    LookupPageID = "Bank Data Conv. Pmt. Types";

    fields
    {
        field(1; "Code"; Text[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

