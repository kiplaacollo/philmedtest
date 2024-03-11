table 50442 "HR Leave Journal Batch"
{

    fields
    {
        field(1; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "HR Leave Journal Template";
        }
        field(2; Name; Code[20])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(18; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Positive,Negative';
            OptionMembers = Positive,Negative;
        }
        field(19; "Posting Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        InsuranceJnlTempl: Record "HR Leave Journal Template";
        InsuranceJnlLine: Record "HR Journal Line";

    [Scope('Internal')]
    procedure SetupNewBatch()
    begin
        InsuranceJnlTempl.Get("Journal Template Name");
        "No. Series" := InsuranceJnlTempl."No. Series";
        "Posting No. Series" := InsuranceJnlTempl."Posting No. Series";
        "Reason Code" := InsuranceJnlTempl."Reason Code";
    end;
}

