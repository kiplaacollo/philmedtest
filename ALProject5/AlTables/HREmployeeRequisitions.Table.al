table 50738 "HR Employee Requisitions"
{

    fields
    {
        field(2; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "HR Jobs"."Job ID";

            trigger OnValidate()
            begin
                HRJobs.Reset;
                if HRJobs.Get("Job ID") then begin
                    "Job Description" := HRJobs."Job Description";
                    "Vacant Positions" := HRJobs."Vacant Positions";
                    "Job Grade" := HRJobs.Grade;
                    "Global Dimension 2 Code" := HRJobs."Global Dimension 2 Code";
                    "Job Supervisor/Manager" := HRJobs."Supervisor/Manager";
                    HRJobs."Responsibility Center" := "Responsibility Center";
                end;

                HRJobs.Reset;
                HRJobs.SetRange(HRJobs."Job ID", "Job ID");
                HRJobs.SetFilter(HRJobs.Status, '<>%1', HRJobs.Status::Approved);
                if HRJobs.Find('-') then begin
                    "Job ID" := '';
                    Error('The job position is not approved');
                end;
                /*
              mDivision:='';
              mResponsibility:='';

              userSetup.RESET;
              userSetup.SETRANGE(userSetup."User ID",USERID);
              IF userSetup.FIND('-') THEN BEGIN
               mDivision:=userSetup."Global Dimension 2 Code";
               mResponsibility:=userSetup."Responsibility Center";
              END;

              HRJobs.RESET;
              HRJobs.SETRANGE(HRJobs."Job ID","Job ID");
              HRJobs.SETFILTER(HRJobs."Global Dimension 2 Code",'=%1',mDivision);
              HRJobs.SETFILTER(HRJobs."Responsibility Center",'=%1',mResponsibility);
              IF HRJobs.FIND('-') THEN
               BEGIN
              //  message('success');
               END
              ELSE BEGIN
                "Job ID":='';
                ERROR('The job position chosen is not in your division');
              END;
                    */

            end;
        }
        field(3; "Requisition Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Rec."Requisition Date" - Today) < 0 then
                    Message('Days in the past are not allowed');
            end;
        }
        field(4; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High,Medium,Low;
        }
        field(5; Positions; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Approved; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Date Approved" := Today;
            end;
        }
        field(7; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Job Description"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(10; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Stage Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Qualified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Job Supervisor/Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(17; "Turn Around Time"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Grace Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Requisition Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Internal,External,Both';
            OptionMembers = " ",Internal,External,Both;
        }
        field(27; "Closing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(38; "Required Positions"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Required Positions" > "Vacant Positions" then begin
                    Error('Required positions exceed the total  no of Vacant Positions');
                end;

                if "Required Positions" <= 0 then begin
                    Error('Required positions cannot be Less Than or Equal to Zero');
                end;
            end;
        }
        field(39; "Vacant Positions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3949; "Reason for Request(Other)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3950; "Any Additional Information"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3958; "Job Grade"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST (Grade));
        }
        field(3964; "Type of Contract Required"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".Code WHERE (Type = FILTER ("Contract Type"));
        }
        field(3965; "Reason For Request"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "New Vacancy",Replacement,Retirement,Retrenchment,Demise,Other;
        }
        field(3966; Requestor; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3967; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3968; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3969; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(3970; "Shortlisting Comittee"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error('You cannot delete this record if its status is' + ' ' + Format(Status));
    end;

    trigger OnInsert()
    begin
        //GENERATE DOCUMENT NUMBER
        if "Requisition No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Employee Requisition Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Employee Requisition Nos.", xRec."No. Series", 0D, "Requisition No.", "No. Series");
        end;

        userSetup.Reset;
        userSetup.SetRange(userSetup."User ID", UserId);
        //IF userSetup.FIND('-') THEN BEGIN
        //mDivision:=userSetup."Global Dimension 2 Code";
        //mResponsibility:=userSetup."Responsibility Center";
        //END;

        //POPULATE FIELDS
        Requestor := UserId;
        "Requisition Date" := Today;
        "Responsibility Center" := mResponsibility;
        "Global Dimension 2 Code" := mDivision;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRJobs: Record "HR Jobs";
        HREmployeeReq: Record "HR Employee Requisitions";
        userSetup: Record "User Setup";
        mDivision: Code[50];
        mResponsibility: Code[50];
}

