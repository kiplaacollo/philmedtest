codeunit 50011 "CFT Workflows"
{
    procedure CheckApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(RecRef, GetWorkflowCode(RunWorkflowOnSendForApproval, RecRef)) then begin

            Error(NoWorkflowEnabledError);
        end;
        exit(true);
    end;

    procedure GetWorkflowCode(WorkFlowCode: Code[128]; RecRef: RecordRef): Code[128]

    begin
        exit(DelChr(StrSubstNo(WorkFlowCode, RecRef.Name), '=', ''));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelWorkflowForApproval(var RecRef: RecordRef)
    begin
    end;
    //Add Events to the Library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddWorkflowEventstoLibrary()
    var
        recref: RecordRef;
        workfloweventhandling: Codeunit "Workflow Event Handling";
    begin
        recref.Open(Database::"BO Applications");
        workfloweventhandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowOnSendForApproval, recref), DATABASE::"BO Applications",
           GetWorkflowEventDes(BOSendForApprovalRequestDes, recref), 0, false);
        workfloweventhandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowOnCancelForApproval, recref), DATABASE::"BO Applications",
          GetWorkflowEventDes(BOSendForCancelRequestDes, recref), 0, false);
    end;
    //Subscribe
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CFT Workflows", 'OnSendWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowOnSendWorkflowforApproval(var RecRef: RecordRef)
    begin
        WorkFlowManagement.HandleEvent(GetWorkflowCode(RunWorkflowOnSendForApproval, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CFT Workflows", 'OnCancelWorkflowForApproval', '', false, false)]
    local procedure RunWorkflowCancelWorkflowforApproval(var RecRef: RecordRef)
    begin
        WorkFlowManagement.HandleEvent(GetWorkflowCode(RunWorkflowOnCancelForApproval, RecRef), RecRef);
    end;

    procedure GetWorkflowEventDes(WorkFlowEventDesc: Text; RecRef: RecordRef): Text

    begin
        exit(StrSubstNo(WorkFlowEventDesc, RecRef.Name));
    end;
    //Handle Document Status from Open to Pending to Approved 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BOApplications: Record "BO Applications";
    begin
        case RecRef.Number of
            database::"BO Applications":
                begin
                    RecRef.SetTable(BOApplications);
                    BOApplications.Validate("Approval Status", BOApplications."Approval Status"::Open);
                    BOApplications.Modify(true);
                    Handled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        BOApplications: Record "BO Applications";
    begin
        case RecRef.Number of
            database::"BO Applications":
                begin
                    RecRef.SetTable(BOApplications);
                    BOApplications.Validate("Approval Status", BOApplications."Approval Status"::"Pending Approval");
                    BOApplications.Modify(true);
                    Variant := BOApplications;
                    IsHandled := true;

                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        BOApplications: Record "BO Applications";
    begin
        case RecRef.Number of
            database::"BO Applications":
                begin
                    RecRef.SetTable(BOApplications);
                    ApprovalEntryArgument."Document No." := BOApplications.No;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BOApplications: Record "BO Applications";
    begin
        case RecRef.Number of
            database::"BO Applications":
                begin
                    RecRef.SetTable(BOApplications);
                    BOApplications.Validate("Approval Status", BOApplications."Approval Status"::Approved);
                    BOApplications.Modify(true);
                    Handled := true

                end;

        end;
    end;



    var
        WorkFlowManagement:
            Codeunit "Workflow Management";
        RunWorkflowOnSendForApproval:
                Label 'RunWorkflowOnSendForApproval';
        RunWorkflowOnCancelForApproval:
                Label 'RunWorkflowOnCancelForApproval';
        NoWorkflowEnabledError:
                Label 'No Approval Workflow for this Record Type is Enabled';
        WorkFlowEventHandling:
                Codeunit "Workflow Event Handling";
        BOSendForApprovalRequestDes:
                Label 'Approval For BO Applications is Requested';
        BOSendForCancelRequestDes:
                Label 'BO Applications Request for Approval is Cancelled';

}
