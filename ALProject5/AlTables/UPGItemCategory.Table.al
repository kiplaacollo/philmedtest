table 104098 "UPG Item Category"
{
    LookupPageID = "Item Categories";

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Def. Gen. Prod. Posting Group"; Code[10])
        {
        }
        field(5; "Def. Inventory Posting Group"; Code[10])
        {
        }
        field(6; "Def. Tax Group Code"; Code[10])
        {
        }
        field(7; "Def. Costing Method"; Option)
        {
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(8; "Def. VAT Prod. Posting Group"; Code[10])
        {
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

