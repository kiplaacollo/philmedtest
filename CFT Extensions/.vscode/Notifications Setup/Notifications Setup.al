table 50105 "Notifications Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[100])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Notification Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = SMS,Email;
            Caption = 'sms,Email';
        }
        field(3; "Message"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        // field(6; "Notifications Code"; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionMembers = "MEMBER APP";
        //     trigger OnValidate()
        //     begin
        //         Code:="Notifications Code";
        //     end;
        // }
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