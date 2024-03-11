table 474 "Job Queue Log Entry"
{
    Caption = 'Job Queue Log Entry';
    ReplicateData = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; ID; Guid)
        {
            Caption = 'ID';
        }
        field(3; "User ID"; Text[65])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(4; "Start Date/Time"; DateTime)
        {
            Caption = 'Start Date/Time';
        }
        field(5; "End Date/Time"; DateTime)
        {
            Caption = 'End Date/Time';
        }
        field(6; "Object Type to Run"; Option)
        {
            Caption = 'Object Type to Run';
            OptionCaption = ',,,Report,,Codeunit';
            OptionMembers = ,,,"Report",,"Codeunit";
        }
        field(7; "Object ID to Run"; Integer)
        {
            Caption = 'Object ID to Run';
        }
        field(8; "Object Caption to Run"; Text[250])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE ("Object Type" = FIELD ("Object Type to Run"),
                                                                           "Object ID" = FIELD ("Object ID to Run")));
            Caption = 'Object Caption to Run';
            FieldClass = FlowField;
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Success,In Process,Error';
            OptionMembers = Success,"In Process",Error;
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(11; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
        field(12; "Error Message 2"; Text[250])
        {
            Caption = 'Error Message 2';
        }
        field(13; "Error Message 3"; Text[250])
        {
            Caption = 'Error Message 3';
        }
        field(14; "Error Message 4"; Text[250])
        {
            Caption = 'Error Message 4';
        }
        field(16; "Processed by User ID"; Text[65])
        {
            Caption = 'Processed by User ID';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(17; "Job Queue Category Code"; Code[10])
        {
            Caption = 'Job Queue Category Code';
            TableRelation = "Job Queue Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(18; "Error Call Stack"; BLOB)
        {
            Caption = 'Error Call Stack';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; ID, Status)
        {
        }
        key(Key3; "Start Date/Time", ID)
        {
        }
    }

    fieldgroups
    {
    }

    var
        NoErrorMessageTxt: Label 'There is no error message.';
        ConfirmDeletingEntriesQst: Label 'Are you sure that you want to delete job queue log entries?';
        ErrorMessageMarkedByTxt: Label 'Marked as an error by %1.', Comment = '%1 = User id';
        OnlyEntriesInProgressCanBeMarkedErr: Label 'Only entries with the status In Progress can be marked as errors.';
        DeletingMsg: Label 'Deleting Entries...';
        DeletedMsg: Label 'Entries have been deleted.';
        Window: Dialog;

    procedure GetErrorMessage(): Text
    var
        TextMgt: Codeunit TextManagement;
    begin
        exit(TextMgt.GetRecordErrorMessage("Error Message", "Error Message 2", "Error Message 3", "Error Message 4"));
    end;

    procedure SetErrorMessage(ErrorText: Text)
    var
        TextMgt: Codeunit TextManagement;
    begin
        TextMgt.SetRecordErrorMessage("Error Message", "Error Message 2", "Error Message 3", "Error Message 4", ErrorText);
    end;

    procedure DeleteEntries(DaysOld: Integer)
    begin
        if not Confirm(ConfirmDeletingEntriesQst) then
            exit;
        Window.Open(DeletingMsg);
        SetFilter(Status, '<>%1', Status::"In Process");
        if DaysOld > 0 then
            SetFilter("End Date/Time", '<=%1', CreateDateTime(Today - DaysOld, Time));
        DeleteAll;
        Window.Close;
        SetRange("End Date/Time");
        SetRange(Status);
        Message(DeletedMsg);
    end;

    procedure ShowErrorMessage()
    var
        e: Text;
    begin
        e := GetErrorMessage;
        if e = '' then
            e := NoErrorMessageTxt;
        Message(e);
    end;

    procedure ShowErrorCallStack()
    begin
        if Status = Status::Error then
            Message(GetErrorCallStack);
    end;

    procedure MarkAsError()
    var
        JobQueueEntry: Record "Job Queue Entry";
        ErrorMessage: Text;
    begin
        if Status <> Status::"In Process" then
            Error(OnlyEntriesInProgressCanBeMarkedErr);

        ErrorMessage := StrSubstNo(ErrorMessageMarkedByTxt, UserId);
        OnBeforeMarkAsError(Rec, JobQueueEntry, ErrorMessage);

        if JobQueueEntry.Get(ID) then
            JobQueueEntry.SetError(ErrorMessage);

        Status := Status::Error;
        SetErrorMessage(ErrorMessage);
        Modify;
    end;

    procedure Duration(): Duration
    begin
        if ("Start Date/Time" = 0DT) or ("End Date/Time" = 0DT) then
            exit(0);
        exit(Round("End Date/Time" - "Start Date/Time", 100));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMarkAsError(var JobQueueLogEntry: Record "Job Queue Log Entry"; var JobQueueEntry: Record "Job Queue Entry"; var ErrorMessage: Text)
    begin
    end;

    procedure SetErrorCallStack(NewCallStack: Text)
    var
        TempBlob: Record TempBlob temporary;
    begin
        Clear("Error Call Stack");
        if NewCallStack = '' then
            exit;
        TempBlob.Blob := "Error Call Stack";
        TempBlob.WriteAsText(NewCallStack, TEXTENCODING::Windows);
        "Error Call Stack" := TempBlob.Blob;
    end;

    procedure GetErrorCallStack(): Text
    var
        TempBlob: Record TempBlob;
        CR: Text;
    begin
        CalcFields("Error Call Stack");
        if not "Error Call Stack".HasValue then
            exit('');

        CR[1] := 10;
        TempBlob.Blob := "Error Call Stack";
        exit(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;
}

