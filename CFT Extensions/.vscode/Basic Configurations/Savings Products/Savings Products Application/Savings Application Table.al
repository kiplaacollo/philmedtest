table 50551 "Savings Application Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "BO Application No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Savings Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Products Setup";
        }
        field(3; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Joint,Group,Corporate;
        }
        field(5; "Monthly Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "BO Application No")
        {
            Clustered = true;
        }
        key(Key2; "Account Name")
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