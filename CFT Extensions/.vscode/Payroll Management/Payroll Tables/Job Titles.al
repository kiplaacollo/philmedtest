table 50049 "Job Titles"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Job Titles";
    DrillDownPageId = "Job Titles";

    fields
    {
        field(1; Code; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Code[60])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}