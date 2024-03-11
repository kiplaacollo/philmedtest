codeunit 50015 "Imprest Requisition Workflow"
{
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(RecRef, GetWorkflowCode(RunWorkflowonSendforApprovalCode, RecRef)) then begin

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
        RecRef.Open(Database::"Imprest Header");
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowonSendforApprovalCode, RecRef), DATABASE::"Imprest Header",
                  GetWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowonCancelforApprovalCode, RecRef), DATABASE::"Imprest Header",
          GetWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt, RecRef), 0, false);

    end;
    // Subscribe
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Imprest Requisition Workflow", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(RunWorkflowonSendforApprovalCode, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Imprest Requisition Workflow", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(RunWorkflowonCancelforApprovalCode, RecRef), RecRef);
    end;

    procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));
    end;
    // Handle the Document Status
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ImprestHeader: Record "Imprest Header";
    begin
        case RecRef.Number of
            database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::Open);
                    ImprestHeader.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ImprestHeader: Record "Imprest Header";
    begin
        case RecRef.Number of
            database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::"Pending Approval");
                    ImprestHeader.Modify(true);
                    Variant := ImprestHeader;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ImprestHeader: Record "Imprest Header";
    begin
        case RecRef.Number of
            database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ApprovalEntryArgument."Document No." := ImprestHeader."No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ImprestHeader: Record "Imprest Header";
    begin
        case RecRef.Number of
            database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::Approved);
                    ImprestHeader.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        ImprestHeader: Record "Imprest Header";
    begin
        case ApprovalEntry."Table ID" of
            database::"Imprest Header":
                begin
                    if ImprestHeader.Get(ApprovalEntry."Document No.") then begin
                        ImprestHeader.Validate(Status, ImprestHeader.Status::Rejected);
                        ImprestHeader.Modify(true);
                    end;
                end;
        end;
    end;

    var
        myInt: Integer;
        WorkflowManagement: Codeunit "Workflow Management";
        RunWorkflowonSendforApprovalCode: Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RunWorkflowonCancelforApprovalCode: Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        WorkflowSendForApprovalEventDescTxt: Label 'Approval of Imprest Requisition is requested.';
        WorkflowCancelForApprovalEventDescTxt: Label 'Approval of Imprest Requisition is Cancelled.';
}