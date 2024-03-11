table 52013 "Loans Sectors Lv1"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Loan Sectors Lv1 List";
    LookupPageId = "Loan Sectors Lv1 List";

    fields
    {
        field(1; "Level 1 Code"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Level One Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Sector Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Sectors"."Sector Code";
        }
    }

    keys
    {
        key(Key1; "Level 1 Code")
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