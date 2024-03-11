table 50216 "Checkoff Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Entry Date"; Date)
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
        field(8; "Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Account Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Document No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Global Dimension Code 1"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(12; "Global Dimension Code 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(13; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Sheduled Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "BO Employer".Code;
        }
        field(16; "Employer Name"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Total Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Checkoff Adv Line");
        }
        field(18; "Checkoff Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Distributed,Block,"Distributed Hybrid";
        }
        field(19; "Skip Loans"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Checkoff Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Posted;
        }
        field(22; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Manual Checkoff"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Loans Only"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Is Debit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Is Reopened"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Reopened By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Date Reopened"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Date Modified"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Loan Cutoff Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(36; "Total Schedule Amount"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = sum("Checkoff Lines Table".amount where("No." = field("No.")));
            Editable = false;
        }
        field(37; "Cheque Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
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
        if "No." = '' then begin
            recGeneralSetup.Get();
            recGeneralSetup.TestField(recGeneralSetup."Checkoff Header NOS");
            NoSeriesMngt.InitSeries(recGeneralSetup."Checkoff Header NOS", recGeneralSetup."Checkoff Header NOS", 0D, "No.", recGeneralSetup."Checkoff Header NOS");
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