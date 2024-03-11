codeunit 50008 "Payments Approval Workflow"
{
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(RecRef, GetWorkflowCode(Runworkflowonsendforapprovalcode, RecRef)) then begin
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
        RecRef.Open(Database::"Payments Header");
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(Runworkflowonsendforapprovalcode, RecRef), Database::"Payments Header",
                  GetWorkflowEventDesc(WorkflowSendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(Runworkflowoncancelapprovalcode, RecRef), DATABASE::"Payments Header",
          GetWorkflowEventDesc(WorkflowCancelForApprovalEventDescTxt, RecRef), 0, false);
    end;
    // Subscribe
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Payments Approval Workflow", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(Runworkflowonsendforapprovalcode, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Payments Approval Workflow", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(Runworkflowoncancelapprovalcode, RecRef), RecRef);
    end;

    procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));
    end;
    // Handle the Status of the Document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        paymentsheader: Record "Payments Header";
    begin
        case RecRef.Number of
            database::"Payments Header":
                begin
                    RecRef.SetTable(paymentsheader);
                    paymentsheader.Validate(Status, paymentsheader.Status::Open);
                    paymentsheader.Modify(true);
                    Handled := true;
                end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        PaymentsHeader: Record "Payments Header";
    begin
        case RecRef.Number of
            database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    PaymentsHeader.Validate(Status, PaymentsHeader.Status::"Pending Approval");
                    PaymentsHeader.Modify(true);
                    Variant := PaymentsHeader;
                    IsHandled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        PaymentsHeader: Record "Payments Header";
    begin
        case RecRef.Number of
            database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    ApprovalEntryArgument."Document No." := PaymentsHeader."No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentsHeader: Record "Payments Header";
    begin
        case RecRef.Number of
            database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    PaymentsHeader.Validate(Status, PaymentsHeader.Status::Approved);
                    PaymentsHeader.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        PaymentsHeader: Record "Payments Header";
    begin
        case ApprovalEntry."Table ID" of
            database::"Payments Header":
                begin
                    if PaymentsHeader.Get(ApprovalEntry."Entry No.") then begin
                        PaymentsHeader.Validate(PaymentsHeader.Status, PaymentsHeader.Status::Rejected);
                        PaymentsHeader.Modify(true);
                    end;
                end;
        end;

    end;

    var
        myInt: Integer;
        WorkflowManagement: Codeunit "Workflow Management";
        Runworkflowonsendforapprovalcode: Label 'RunWorkflowonsend%1forapproval';
        Runworkflowoncancelapprovalcode: Label 'RunWorkflowoncancel%1forapproval';
        NoWorkflowEnabledErr: Label 'No Approval Workflow for this Record Type is Enabled';
        WorkflowSendForApprovalEventDescTxt: Label 'Approval of a Payment is requested.';
        WorkflowCancelForApprovalEventDescTxt: Label 'An Approval Request for a Payment is Cancelled';
}