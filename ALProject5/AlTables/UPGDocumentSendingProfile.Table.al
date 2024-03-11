table 104076 "UPG Document Sending Profile"
{
    LookupPageID = "Document Sending Profiles";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(51; Usage; Option)
        {
            OptionMembers = "Sales Invoice","Sales Credit Memo","Service Invoice","Service Credit Memo";
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

