page 50081 "FO Application Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Applications";
    // SourceTableView = where(Processed = const(false), "Member Posting Group" = const('FO'));
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                Editable = EditableData;
                field(No; Rec.No)
                {
                    trigger OnValidate()
                    begin

                    end;
                }
                field("BO No"; Rec."BO No")
                {

                }
                field("First Name"; Rec."First Name")
                {

                }
                field("Middle Name"; Rec."Middle Name")
                {

                }
                field("Last Name"; Rec."Last Name")
                {

                }
                field("Full Name"; Rec."Full Name")
                {
                    Importance = Promoted;
                }
                field("Account Name"; Rec."Account Name")
                {

                }
                field("ID Number"; Rec."ID Number")
                {
                    Importance = Promoted;
                }
                field("KRA Pin"; Rec."KRA Pin")
                {

                }
                field("Application Date"; Rec."Application Date")
                {
                    Importance = Promoted;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Importance = Additional;
                }
                field("Member Posting Group"; Rec."Member Posting Group")
                {

                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                }
                field(Processed; Rec.Processed)
                {
                    Importance = Additional;
                }
                field("Member Number"; Rec."Member Number")
                {
                    Importance = Additional;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    Importance = Additional;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    Importance = Additional;
                }
            }
            group("FOSA Account Details")
            {
                // Editable = EditableData;
                field("FO Account Type"; Rec."FO Account Type")
                {

                }
                field("FO Account Category"; Rec."FO Account Category")
                {

                }
                field("Is Current Account"; Rec."Is Current Account")
                {

                }
                field("Current Account No"; Rec."Current Account No")
                {

                }
            }
            group("Communication Information")
            {
                Editable = EditableData;
                field(County; Rec.County)
                {

                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Workplace Extension"; Rec."Workplace Extension")
                {
                    Importance = Additional;
                }
                field("Email Address"; Rec."Email Address")
                {
                    Importance = Promoted;
                    Style = Favorable;
                }
                field(District; Rec.District)
                {
                    Importance = Additional;
                }
                field(Location; Rec.Location)
                {
                    Importance = Additional;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    Importance = Additional;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ShowMandatory = true;
                    Importance = Additional;
                }
                field("Contact Person Phone"; Rec."Contact Person Phone")
                {
                    Importance = Additional;
                }
                field("Contact Person Designation"; Rec."Contact Person Designation")
                {
                    Importance = Additional;
                }
            }
            group("Personal Information")
            {
                Editable = EditableData;
                field("Date of Birth"; Rec."Date of Birth")
                {
                    Importance = Promoted;
                }
                field(Age; Rec.Age)
                {
                    Importance = Promoted;
                }
                field(Gender; Rec.Gender)
                {

                }
                field("Marital Status"; Rec."Marital Status")
                {

                }
                field(Disabled; Rec.Disabled)
                {

                }
            }
            group("Employment Information")
            {
                Editable = EditableData;
                field("Employer Code"; Rec."Employer Code")
                {

                }
                field("Employer Description"; Rec."Employer Description")
                {
                    Importance = Promoted;
                }
                field("Department Code"; Rec."Department Code")
                {

                }
                field("Department Description"; Rec."Department Description")
                {

                }
                field(Occupation; Rec.Occupation)
                {

                }
                field("Terms of Employment"; Rec."Terms of Employment")
                {

                }
                field("Payroll Number"; Rec."Payroll Number")
                {
                    Importance = Promoted;
                }
            }
            group(Kins)
            {
                Editable = EditableData;
                part(KinsPart; "BO Kins")
                {
                    SubPageLink = "BO Application No" = field(No);
                }
            }
            group("Bank Details")
            {
                Editable = EditableData;
                field("Bank Code"; Rec."Bank Code")
                {

                }
                field("Bank Name"; Rec."Bank Name")
                {

                }
                field("Bank Branch"; Rec."Bank Branch")
                {

                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {

                }
                field("Bank Account No."; Rec."Bank Account No.")
                {

                }
                field("Swift Code"; Rec."Swift Code")
                {

                }
            }
            group("Referee Details")
            {
                Editable = EditableData;
                field("Referee Name"; Rec."Referee Name")
                {

                }
                field("Referee ID No"; Rec."Referee ID No")
                {

                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {

                }
            }
            group("Audit Information")
            {
                Editable = false;
                field("Captured By"; Rec."Captured By")
                {

                }
                field("Capture Date Time"; Rec."Capture Date Time")
                {

                }
                field("Date Approved"; Rec."Date Approved")
                {

                }
                field("Processed By"; Rec."Processed By")
                {

                }
                field("Date Processed"; Rec."Date Processed")
                {

                }
                field("Processed Date Time"; Rec."Processed Date Time")
                {

                }
            }
        }
        area(FactBoxes)
        {
            part(Passport; "BO Account Passport")
            {
                SubPageLink = No = field(No);
            }
            part(Signature; "BO Account Signature")
            {
                SubPageLink = No = field(No);
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;

                trigger OnAction()
                var
                    CustomWorkflowMngt: Codeunit "CFT Workflows";
                    RecRef: RecordRef;


                begin
                    RecRef.GetTable(Rec);
                    if CustomWorkflowMngt.CheckApprovalsWorkflowEnabled(RecRef) then
                        CustomWorkflowMngt.OnSendWorkflowForApproval(RecRef);

                end;

            }
            action("Cancel Approval Request")

            {
                ApplicationArea = all;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = CanCancelApprovalForRecord;
                trigger OnAction()
                var
                    CustomWorkflowMngt: Codeunit "CFT Workflows";
                    recref: RecordRef;
                begin
                    CustomWorkflowMngt.OnCancelWorkflowForApproval(RecRef);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = all;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ApprovalEntries: Page 658;
                begin
                    ApprovalEntries.Run;

                end;
            }
            action("Finish Process")
            {
                ApplicationArea = all;
                Enabled = EnableCreateMember;
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var

                    ObjGeneralSetup: Record "BO General Setup";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    mybooleanfield: Boolean;

                begin

                    if Rec."Member Number" = '' then begin
                        ObjGeneralSetup.Get();
                        ObjGeneralSetup.TestField(ObjGeneralSetup."BO Nos");
                        NoSeriesMgt.InitSeries(ObjGeneralSetup."BO Nos", ObjGeneralSetup."BO Nos", 0D, Rec."Member Number", ObjGeneralSetup."BO Nos");
                        Rec.Name := Rec."Full Name";
                        Rec."No." := Rec."Member Number";
                        Rec.Processed := TRUE;
                        Rec."Processed Date Time" := CurrentDateTime;
                        Rec."Date Processed" := Today;
                        rec."Processed By" := UserId;
                        rec."Registration Date" := Today;
                        rec."Membership Status" := Rec."Membership Status"::Active;
                        Rec.Validate(Processed);

                        Rec.Modify(true);
                        Message('Savings Account %1 has Been Created', Rec."Member Number");




                    end;


                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Member Posting Group" := 'FO';
        Rec."Activity Code" := 'FOSA';

    end;

    trigger OnAfterGetCurrRecord()
    begin
        EditableData := true;
        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := true;
        if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
            OpenApprovalEntriesExist := FALSE;
            CanCancelApprovalForRecord := FALSE;
            EnabledApprovalWorkflowsExist := FALSE;
        end;
        if ((Rec."Approval Status" = Rec."Approval Status"::Approved) and (Rec."Member Number" = '')) then
            EnableCreateMember := true;
        IF ((Rec."Approval Status" = rec."Approval Status"::"Pending Approval") OR (Rec."Approval Status" = rec."Approval Status"::Approved)) THEN BEGIN
            CurrPage.EDITABLE := FALSE;
            EditableData := FALSE;
        END;
    end;


    var
        myInt: Integer;
        EnableCreateMember: Boolean;
        EditableData: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RECORDID: RecordId;
        CustomWorkflowMngt: Codeunit "CFT Workflows";

}