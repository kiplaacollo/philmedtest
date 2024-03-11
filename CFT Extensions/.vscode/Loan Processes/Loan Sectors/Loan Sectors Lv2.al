table 52014 "Loans Sectors Lv2"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Loan Sectors Lv2 List";
    DrillDownPageId = "Loan Sectors Lv2 List";

    fields
    {
        field(1; "Level Two Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Level Two Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Level One Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loans Sectors Lv1"."Level 1 Code";
            trigger OnValidate()
            var
                ObjSectorsLevelOne: Record "Loans Sectors Lv1";
            begin
                ObjSectorsLevelOne.Reset();
                if ObjSectorsLevelOne.Get("Level One Code") then begin
                    "Sector Code" := ObjSectorsLevelOne."Sector Code";
                    "Level One Name" := ObjSectorsLevelOne."Level One Name";
                end;
            end;
        }
        field(4; "Sector Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Level One Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Level Two Code", "Level Two Name")
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