codeunit 50009 "Funds Transfer Workflow"
{
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(RecRef, GetWorkflowCode(RunWorkflowonSendforApprovalcode, RecRef)) then begin
            Error(NoWorkflowEnabledErr);
        end;
        exit(true);
    end;

    procedure GetWorkflowCode(WorkflowCode: Code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ''));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;
    // Add Events to the Library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::"Funds Transfer Header");
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowonSendforApprovalcode, RecRef), DATABASE::"Funds Transfer Header",
                  GetWorkflowEventDesc(WorkflowSendforApprovalEventDescText, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowonCancelforApprovalcode, RecRef), DATABASE::"Funds Transfer Header",
          GetWorkflowEventDesc(WorkflowCancelforApprovalEventDescText, RecRef), 0, false);
    end;
    // Subscribe
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Funds Transfer Workflow", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(RunWorkflowonSendforApprovalcode, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Funds Transfer Workflow", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(RunWorkflowonCancelforApprovalcode, RecRef), RecRef);
    end;

    procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));
    end;
    // Handle the Document Status from Open to Pending to Approved
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case RecRef.Number of
            database::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.Validate(Status, FundsTransfer.Status::Open);
                    FundsTransfer.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case RecRef.Number of
            database::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.Validate(Status, FundsTransfer.Status::"Pending Approval");
                    FundsTransfer.Modify(true);
                    Variant := FundsTransfer;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case RecRef.Number of
            database::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    ApprovalEntryArgument."Document No." := FundsTransfer."No.";
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case RecRef.Number of
            database::"Funds Transfer Header":
                begin
                    RecRef.SetTable(FundsTransfer);
                    FundsTransfer.Validate(Status, FundsTransfer.Status::Approved);
                    FundsTransfer.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        FundsTransfer: Record "Funds Transfer Header";
    begin
        case ApprovalEntry."Table ID" of
            database::"Funds Transfer Header":
                begin
                    if FundsTransfer.Get(ApprovalEntry."Document No.") then begin
                        FundsTransfer.Validate(Status, FundsTransfer.Status::Rejected);
                        FundsTransfer.Modify(true);
                    end;
                end;
        end;

    end;

    var
        myInt: Integer;
        WorkflowManagement:
                Codeunit "Workflow Management";
        RunWorkflowonSendforApprovalcode:
                Label 'RunWorkflowonSend%1forApproval';
        RunWorkflowonCancelforApprovalcode:
                Label 'RunWorkflowonCancel%1forApproval';
        NoWorkflowEnabledErr:
                Label 'No approval workflow for this record type is enabled.';
        WorkflowSendforApprovalEventDescText:
                Label 'An Approval of Funds Transfer is Requested';
        WorkflowCancelforApprovalEventDescText:
                Label 'An Approval Request of Funds Transfer is Cancelled';
}