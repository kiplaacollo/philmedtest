table 104081 "UPG Approval Comment Line"
{
    DrillDownPageID = "Approval Comments";
    LookupPageID = "Approval Comments";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Editable = false;
        }
        field(2; "Table ID"; Integer)
        {
            Editable = false;
        }
        field(3; "Document Type"; Option)
        {
            Editable = false;
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        }
        field(4; "Document No."; Code[20])
        {
            Editable = false;
        }
        field(5; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(6; "Date and Time"; DateTime)
        {
            Editable = false;
        }
        field(7; Comment; Text[80])
        {
        }
        field(8; "Record ID to Approve"; RecordID)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

