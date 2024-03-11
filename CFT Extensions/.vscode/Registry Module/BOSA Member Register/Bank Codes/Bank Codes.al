table 50027 "Bank Codes"
{
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(10; "Bank Code"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Bank Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Bank Name")
        {

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