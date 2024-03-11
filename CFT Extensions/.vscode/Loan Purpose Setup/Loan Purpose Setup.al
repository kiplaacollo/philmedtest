table 50167 "Loan Purpose Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoIncrement = true;
            Enabled = true;
        }
        field(2; Code; Code[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
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