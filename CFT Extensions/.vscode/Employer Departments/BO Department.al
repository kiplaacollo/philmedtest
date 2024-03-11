table 50103 "BO Department"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[100])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Code; Code)
        {
            Clustered = true;
        }
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