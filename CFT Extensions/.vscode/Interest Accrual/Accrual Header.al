table 50218 "Accrual Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Cutoff Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Time Stamp"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Accrual Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","Interest Due","Penalty Charged";
        }
        field(11; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "BO Employer";
            trigger OnValidate()
            var
                boEmployer: Record "BO Employer";
            begin
                boEmployer.Reset();
                boEmployer.SetRange(code, "Employer Code");
                if boEmployer.Find('-') then
                    "Employer Description" := boEmployer.Description;
            end;
        }
        field(12; "Employer Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Daily Accrual"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Total Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Total Lines Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Reversed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Rversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Currency Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Exchange Rate"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Lcy Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; No)
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
        recGeneralSetup: Record "Funds General Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No" = '' then begin
            recGeneralSetup.Get();
            recGeneralSetup.TestField(recGeneralSetup."Interest Accrual Nos");
            NoSeriesMngt.InitSeries(recGeneralSetup."Interest Accrual Nos", recGeneralSetup."Interest Accrual Nos", 0D, "No", recGeneralSetup."Interest Accrual Nos");
        end;
        "Captured By" := UserId;
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