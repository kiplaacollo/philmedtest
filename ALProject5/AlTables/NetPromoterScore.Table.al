table 1433 "Net Promoter Score"
{
    Caption = 'Net Promoter Score';
    DataPerCompany = false;

    fields
    {
        field(1; "User SID"; Guid)
        {
            Caption = 'User SID';
            DataClassification = EndUserPseudonymousIdentifiers;
        }
        field(4; "Last Request Time"; DateTime)
        {
            Caption = 'Last Request Time';
        }
        field(5; "Send Request"; Boolean)
        {
            Caption = 'Send Request';
        }
    }

    keys
    {
        key(Key1; "User SID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        NpsCategoryTxt: Label 'AL NPS Prompt', Locked = true;
        FailedToUpdateNPSTxt: Label 'Failed to update NPS on %1.', Locked = true;
        FailedToGetNPSRecordTxt: Label 'Failed to get updated NPS record after SelectLatestVersion.', Locked = true;
        OldVersionOfNPSRecordTxt: Label 'Old version of the NPS version was - USERSID %1, LastRequestTime %2, SendRequest %3.', Locked = true;
        DisablingNPSRecordTxt: Label 'Disabling NPS record - USERSID %1.', Locked = true;
        FailedToUpdateNPSForUserTxt: Label 'Failed to update NPS on %1. USERSID %2.', Locked = true;

    procedure UpdateRequestSendingStatus()
    var
        NetPromoterScoreMgt: Codeunit "Net Promoter Score Mgt.";
    begin
        if not NetPromoterScoreMgt.IsNpsSupported then
            exit;

        if not Get(UserSecurityId) then begin
            Init;
            "User SID" := UserSecurityId;
            "Last Request Time" := CurrentDateTime;
            "Send Request" := true;
            if not Insert then
                LogUpdateError('Insert');
        end else begin
            "Last Request Time" := CurrentDateTime;
            "Send Request" := true;
            if not Modify then
                LogUpdateError('Modify');
        end;
    end;

    procedure DisableRequestSending()
    var
        NetPromoterScoreMgt: Codeunit "Net Promoter Score Mgt.";
    begin
        if not NetPromoterScoreMgt.IsNpsSupported then
            exit;

        if not Get(UserSecurityId) then
            exit;

        "Send Request" := false;
        SendTraceTag(
          '00009NW', NpsCategoryTxt, VERBOSITY::Normal, StrSubstNo(DisablingNPSRecordTxt, UserSecurityId),
          DATACLASSIFICATION::EndUserPseudonymousIdentifiers);
        Modify;
    end;

    procedure ShouldSendRequest(): Boolean
    begin
        if not Get(UserSecurityId) then
            exit(true);

        exit("Send Request");
    end;

    local procedure LogUpdateError(Operation: Text)
    begin
        SendTraceTag(
          '00009NX', NpsCategoryTxt, VERBOSITY::Warning, StrSubstNo(FailedToUpdateNPSTxt, Operation), DATACLASSIFICATION::SystemMetadata);

        SendTraceTag(
          '00009O6', NpsCategoryTxt, VERBOSITY::Warning, StrSubstNo(FailedToUpdateNPSForUserTxt, Operation, UserSecurityId),
          DATACLASSIFICATION::EndUserPseudonymousIdentifiers);
        SelectLatestVersion;

        if not Get(UserSecurityId) then begin
            SendTraceTag(
              '00009NY', NpsCategoryTxt, VERBOSITY::Warning, FailedToGetNPSRecordTxt, DATACLASSIFICATION::SystemMetadata);
            exit;
        end;

        SendTraceTag(
          '00009NZ', NpsCategoryTxt, VERBOSITY::Normal, StrSubstNo(OldVersionOfNPSRecordTxt, "User SID", "Last Request Time", "Send Request"),
          DATACLASSIFICATION::EndUserPseudonymousIdentifiers);
    end;
}

