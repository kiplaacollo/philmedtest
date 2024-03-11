codeunit 50014 "Disbursement Workflow"
{
    procedure CheckApprovalsWorkflowEnabled(var recref: RecordRef): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(recref, GetWorkflowCode(runworkflowonsendforapprovalabel, recref)) then begin

            Error(NoWorkflowEnabledErr);
        end;
        exit(true);
    end;

    local procedure GetWorkflowCode(workflowcode: Code[128]; recref: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkFlowCode, RecRef.Name), '=', ''));
    end;
    // Raise the Events
    [IntegrationEvent(false, false)]
    procedure OnSendWorkflowForApproval(var recref: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelWorkflowForApproval(var recref: RecordRef)
    begin
    end;
    // Add Events to the Library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        RecRef: RecordRef;
        workfloweventhandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::"Loan Disbursement");
        workfloweventhandling.AddEventToLibrary(GetWorkflowCode(runworkflowonsendforapprovalabel, RecRef), DATABASE::"Loan Disbursement",
                 GetWorkflowEventDes(disbursementsendapprovalventdes, RecRef), 0, false);
        workfloweventhandling.AddEventToLibrary(GetWorkflowCode(runworkflowoncancelforapprovalabel, RecRef), DATABASE::"Loan Disbursement",
          GetWorkflowEventDes(disbursementscancelapprovaleventdes, RecRef), 0, false);
    end;
    // Subscribe
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Disbursement Workflow", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var recref: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(runworkflowonsendforapprovalabel, recref), recref);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Disbursement Workflow", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(var recref: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(runworkflowoncancelforapprovalabel, recref), recref);
    end;

    procedure GetWorkflowEventDes(WorkFlowEventDesc: Text; RecRef: RecordRef): Text

    begin
        exit(StrSubstNo(WorkFlowEventDesc, RecRef.Name));
    end;
    // Handle Document Status
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        loandisbursement: Record "Loan Disbursement";
    begin
        case RecRef.Number of
            database::"Loan Disbursement":
                begin
                    RecRef.SetTable(loandisbursement);
                    loandisbursement.Validate(Status, loandisbursement.Status::Open);
                    loandisbursement.Modify(true);
                    Handled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        loandisbursement: Record "Loan Disbursement";
    begin
        case RecRef.Number of
            database::"Loan Disbursement":
                begin
                    RecRef.SetTable(loandisbursement);
                    loandisbursement.Validate(Status, loandisbursement.Status::"Pending Approval");
                    loandisbursement.Modify(true);
                    Variant := loandisbursement;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        loandisbursement: Record "Loan Disbursement";
    begin
        case RecRef.Number of
            database::"Loan Disbursement":
                begin
                    RecRef.SetTable(loandisbursement);
                    ApprovalEntryArgument."Document No." := loandisbursement."No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        loandisbursement: Record "Loan Disbursement";
    begin
        case RecRef.Number of
            database::"Loan Disbursement":
                begin
                    RecRef.SetTable(loandisbursement);
                    loandisbursement.Validate(Status, loandisbursement.Status::Approved);
                    loandisbursement.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        loandisbursement: Record "Loan Disbursement";
    begin
        case ApprovalEntry."Table ID" of
            database::"Loan Disbursement":
                begin
                    if loandisbursement.Get(ApprovalEntry."Entry No.") then begin
                        loandisbursement.Validate(loandisbursement.Status, loandisbursement.Status::Rejected);
                        loandisbursement.Modify(true);
                    end;
                end;
        end;
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        runworkflowonsendforapprovalabel: Label 'Runworkflowonsend%1forapproval';
        runworkflowoncancelforapprovalabel: Label 'Runworkflowoncancel%1forapproval';
        NoWorkflowEnabledErr:
                Label 'No Approval Workflow for this Record Type is Enabled';
        disbursementsendapprovalventdes: Label 'An Approval of Loan Disbursement is Requested';
        disbursementscancelapprovaleventdes: Label 'An Approval Request of Loan Disbursement is Cancelled';
}