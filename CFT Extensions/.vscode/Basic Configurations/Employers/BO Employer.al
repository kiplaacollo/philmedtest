table 50102 "BO Employer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[100])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Associated Customer No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
    }

    keys
    {
        key(Key1; Code)
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