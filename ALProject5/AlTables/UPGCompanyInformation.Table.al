table 104079 "UPG Company Information"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(101; "Intrastat Contact Type"; Option)
        {
            OptionMembers = " ",Contact,Vendor;
        }
        field(102; "Intrastat Contact No."; Code[20])
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

