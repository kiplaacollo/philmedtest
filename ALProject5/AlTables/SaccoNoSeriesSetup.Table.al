table 50437 "Sacco No Series Setup"
{
    Caption = 'Sales & Receivables Setup';
    DrillDownPageID = "Sales & Receivables Setup";
    LookupPageID = "Sales & Receivables Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Leave App Nos"; Code[22])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "Base Calendar"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Leave Doc Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'Job Queue Priority must be zero or positive.';
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get;
        RecordHasBeenRead := true;
    end;

    procedure GetLegalStatement(): Text
    begin
        exit('');
    end;

    procedure JobQueueActive(): Boolean
    begin
    end;

    local procedure CheckGLAccPostingTypeBlockedAndGenProdPostingType(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin
    end;
}

