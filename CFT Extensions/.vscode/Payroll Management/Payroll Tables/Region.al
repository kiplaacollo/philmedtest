table 50042 Region
{
    DataClassification = ToBeClassified;
    LookupPageId = "Region List";
    DrillDownPageId = "Region List";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        // field(3; Count; Integer)
        // {
        //     FieldClass = FlowField;
        // }
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