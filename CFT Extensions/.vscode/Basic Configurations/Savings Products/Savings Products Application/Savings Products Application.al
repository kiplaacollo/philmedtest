table 50550 "Savings Products Application"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Savings Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Products Setup";
        }
        field(2; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Joint,Group,Corporate;
        }
        field(4; "Monthly Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Savings Product")
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