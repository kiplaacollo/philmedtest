table 104052 "UPG Custom Report Layout"
{
    DataPerCompany = false;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Report ID"; Integer)
        {
        }
        field(4; "Company Name"; Text[30])
        {
            TableRelation = Company;
        }
        field(6; Type; Option)
        {
            InitValue = Word;
            OptionMembers = RDLC,Word;
        }
        field(7; "Layout"; BLOB)
        {
        }
        field(8; "Last Modified"; DateTime)
        {
            Editable = false;
        }
        field(9; "Last Modified by User"; Code[50])
        {
            Editable = false;
        }
        field(10; "File Extension"; Text[30])
        {
            Editable = false;
        }
        field(11; Description; Text[80])
        {
        }
        field(12; "Custom XML Part"; BLOB)
        {
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

