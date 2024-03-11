table 50444 "HR Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(3; "Training Application Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(4; "Leave Application Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(5; "Disciplinary Cases Nos.;"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(6; "Base Calender"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Job Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(13; "Transport Req Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(14; "Employee Requisition Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(15; "Leave Posting Period[FROM]"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Leave Posting Period[TO]"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Job Application Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(18; "Exit Interview Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(19; "Appraisal Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(20; "Company Activities"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(21; "Default Leave Posting Template"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Positive Leave Posting Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Leave Template"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Leave Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Job Interview Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(26; "Company Documents"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(27; "HR Policies"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(28; "Notice Board Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(29; "Leave Reimbursement Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(30; "Min. Leave App. Months"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Minimum Leave Application Months';
        }
        field(31; "Negative Leave Posting Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Appraisal Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Normal Appraisal","360 Appraisal";
        }
        field(50000; "Loan Application Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50001; "Leave Carry Over App Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50002; "Pay-change No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50003; "Max Appraisal Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Medical Claims Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50005; "Employee Transfer Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50006; "Leave Planner Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50007; "Deployed Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50008; "Full Time Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50009; "Board Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50010; "Committee Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50011; "Hr Email"; Text[45])
        {
            DataClassification = ToBeClassified;
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