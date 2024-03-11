table 52012 "Loan Sectors"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Loan Sectors List.al";
    LookupPageId = "Loan Sectors List.al";

    fields
    {
        field(1; "Sector Code"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Sector Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Sector Code")
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