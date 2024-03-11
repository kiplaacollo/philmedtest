table 50500 "Annual Holidays"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Day; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Month; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Holiday Name"; Text[50])
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