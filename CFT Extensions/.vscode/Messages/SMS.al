table 50403 "SMS Messages"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            AutoIncrement = true;
        }
        field(2; "Message Source"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Mobile Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Date of Entry"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Time of Entry"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Entered By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Message; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Sent to Server"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
    }

    keys
    {
        key(Key1; "Entry No")
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