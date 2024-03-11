table 52005 "Checkoff Advice"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Account Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Total Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "BO Employer".Code;
            trigger OnValidate()
            var
                boemployer: Record "BO Employer";
            begin
                clearcheckofflines("No.");
                boemployer.Reset();
                boemployer.SetRange(Code, "Employer Code");
                if boemployer.Find('-') then
                    "Employer Name" := boemployer.Description;
                "Employer Account" := boemployer."Associated Customer No";
            end;
        }
        field(10; "Employer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(11; "Loan Cutoff Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Confirmed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Last Advice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Checkoff Posting Mode"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Date Modified"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Is Reopened"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Date Reopened"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Reopened By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Company Id"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(24; "Employer Account"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure clearcheckofflines(No: Code[50])
    begin
        checkoffline.Reset();
        checkoffline.SetRange(checkoffline."No.", No);
        if checkoffline.FindSet()
        then begin
            checkoffline.DeleteAll();
        end;
    end;

    var
        myInt: Integer;
        recGeneralSetup: Record "Funds General Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;
        checkoffline: Record "Checkoff Adv Line";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            recGeneralSetup.Get();
            recGeneralSetup.TestField(recGeneralSetup."Checkoff Advice NOS");
            NoSeriesMngt.InitSeries(recGeneralSetup."Checkoff Advice NOS", recGeneralSetup."Checkoff Advice NOS", 0D, "No.", recGeneralSetup."Checkoff Advice NOS");
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