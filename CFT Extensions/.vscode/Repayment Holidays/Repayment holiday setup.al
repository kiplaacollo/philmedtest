table 50178 "Repayment holiday setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Enabled = true;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(3; "Month code"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Month"; Code[20])
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