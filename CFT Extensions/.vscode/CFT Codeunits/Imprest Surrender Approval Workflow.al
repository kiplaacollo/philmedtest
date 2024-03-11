codeunit 50016 "Imprest Surrender Workflow"
{
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(RecRef, GetWorkflowCode(RunWorkflowOnsendforApprovalCode, RecRef)) then begin

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
    // Add events to the library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::"Imprest Surrender Header");
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowOnsendforApprovalCode, RecRef), DATABASE::"Imprest Surrender Header",
                   GetWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowOncancelforApprovalCode, RecRef), DATABASE::"Imprest Surrender Header",
          GetWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt, RecRef), 0, false);
    end;
    // Subscribe
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Imprest Surrender Workflow", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(RunWorkflowOnsendforApprovalCode, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Imprest Surrender Workflow", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(RunWorkflowOncancelforApprovalCode, RecRef), RecRef);
    end;

    procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));
    end;
    // Handle the Document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ImprestSurrender: Record "Imprest Surrender Header";
    begin
        case RecRef.Number of
            database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::Open);
                    ImprestSurrender.Modify(true);
                    Handled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ImprestSurrender: Record "Imprest Surrender Header";
    begin
        case RecRef.Number of
            database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::"Pending Approval");
                    ImprestSurrender.Modify(true);
                    Variant := ImprestSurrender;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ImprestSurrender: Record "Imprest Surrender Header";
    begin
        case RecRef.Number of
            database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ApprovalEntryArgument."Document No." := ImprestSurrender.No;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ImprestSurrender: Record "Imprest Surrender Header";
    begin
        case RecRef.Number of
            database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::Approved);
                    ImprestSurrender.Modify(true);
                    Handled := true;
                end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        ImprestSurrender: Record "Imprest Surrender Header";
    begin
        case ApprovalEntry."Table ID" of
            database::"Imprest Surrender Header":
                begin
                    if ImprestSurrender.Get(ApprovalEntry."Document No.") then begin
                        ImprestSurrender.Validate(Status, ImprestSurrender.Status::Rejected);
                        ImprestSurrender.Modify(true);
                    end;
                end;
        end;

    end;

    var
        myInt: Integer;
        WorkflowManagement: Codeunit "Workflow Management";
        RunWorkflowOnsendforApprovalCode: Label 'RUNWORKFLOWONSEND%1FORAPPROVAL';
        RunWorkflowOncancelforApprovalCode: Label 'RUNWORKFLOWONCANCEL%1FORAPPROVAL';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        WorkflowSendForApprovalEventDescTxt: Label 'Approval of Imprest Surrender is requested.';
        WorkflowCancelForApprovalEventDescTxt: Label 'Approval of Imprest Surrender is cancelled.';
}