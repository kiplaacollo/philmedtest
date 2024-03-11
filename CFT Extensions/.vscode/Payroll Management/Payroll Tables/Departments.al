table 50435 "Employer Departments"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Department; Code[80])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Department)
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