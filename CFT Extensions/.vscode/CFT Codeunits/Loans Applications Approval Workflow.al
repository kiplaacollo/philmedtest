codeunit 50012 "Loan Approval Workflow"
{
    procedure CheckApprovalsWorkflowEnabled(var recref: recordref): Boolean
    begin
        if not WorkflowMgt.CanExecuteWorkflow(recref, GetWorkflowCode(RunWorkflowOnSendForApprovalCODE, recref)) then begin

            Error(NoWorkflowEnabledError);
        end;
        exit(true);
    end;

    procedure GetWorkflowCode(WorkFlowCode: Code[128]; RecRef: RecordRef): Code[128]

    begin
        exit(DelChr(StrSubstNo(WorkFlowCode, RecRef.Name), '=', ''));
    end;
    // Raise Events

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
        recref: RecordRef;
        workfloweventhandling: Codeunit "Workflow Event Handling";
    begin
        recref.Open(Database::Loans);
        workfloweventhandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowOnSendForApprovalCODE, recref), DATABASE::Loans,
           GetWorkflowEventDes(loanSendApprovalRequestDes, recref), 0, false);
        workfloweventhandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowOnCancelForApprovalCODE, recref), DATABASE::Loans,
          GetWorkflowEventDes(loanCancelApprovalRequestDes, recref), 0, false);
    end;
    // Subscribe
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Loan Approval Workflow", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
        Workflowmgt.HandleEvent(GetWorkflowCode(RunWorkflowOnSendForApprovalCODE, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Loan Approval Workflow", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowCancelWorkflowforApproval(var RecRef: RecordRef)
    begin
        WorkFlowMgt.HandleEvent(GetWorkflowCode(RunWorkflowOnCancelForApprovalCODE, RecRef), RecRef);
    end;

    procedure GetWorkflowEventDes(WorkFlowEventDesc: Text; RecRef: RecordRef): Text

    begin
        exit(StrSubstNo(WorkFlowEventDesc, RecRef.Name));
    end;
    // Handle the Document from open to pending approval to approved
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(recref: RecordRef; var handled: Boolean)
    var
        loans: Record Loans;
    begin
        case recref.Number of
            database::Loans:
                begin
                    recref.SetTable(loans);
                    loans.Validate("Approval Status", loans."Approval Status"::Open);
                    loans.Modify(true);
                    Handled := true;
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        loans: Record loans;
    begin
        case RecRef.Number of
            database::Loans:
                begin
                    RecRef.SetTable(loans);
                    loans.Validate("Approval Status", loans."Approval Status"::"Pending Approval");
                    loans.Modify(true);
                    Variant := loans;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        loans: Record Loans;
    begin
        case RecRef.Number of
            database::Loans:
                begin
                    RecRef.SetTable(loans);
                    ApprovalEntryArgument."Document No." := loans."Member Number";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        loans: Record Loans;
    begin
        case RecRef.Number of
            database::Loans:
                begin
                    RecRef.SetTable(loans);
                    loans.Validate("Approval Status", loans."Approval Status"::Approved);
                    loans.Modify(true);
                    Handled := true

                end;

        end;
    end;

    var
        myInt: Integer;
        Workflowmgt: Codeunit "Workflow Management";
        RunWorkflowOnSendForApprovalCODE:
                Label 'RunWorkflowOnSend%1ForApproval';
        RunWorkflowOnCancelForApprovalCODE:
                Label 'RunWorkflowOnCancel%1ForApproval';
        NoWorkflowEnabledError:
                Label 'No Approval Workflow for this Record Type is Enabled';
        loanSendApprovalRequestDes:
                Label 'Approval For Loan Applicationsis Requested';
        loanCancelApprovalRequestDes:
                Label 'An Approval Request for Loan Application is Cancelled';
}