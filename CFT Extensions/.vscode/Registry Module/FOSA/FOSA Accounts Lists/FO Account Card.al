page 50083 "FO Account Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    InsertAllowed = false;
    ModifyAllowed = true;
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
                    Importance = Promoted;
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
                field("FO Account Type"; Rec."FO Account Type")
                {
                    Importance = Promoted;
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
                }
                field("Workplace Extension"; Rec."Workplace Extension")
                {
                    Importance = Additional;
                }
                field("Email Address"; Rec."Email Address")
                {
                    Importance = Promoted;
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
                part(Kin; "BO Kins")
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
            part(CustomerStatistics; "FO Statistics")
            {
                SubPageLink = "Member Number" = field("Member Number");
            }
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        EditableData := true;
        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := true;
        if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if ((Rec."Approval Status" = rec."Approval Status"::Approved) and (Rec."Member Number" = '')) then
            EnableCreateMember := true;
        if ((Rec."Approval Status" = Rec."Approval Status"::"Pending Approval") or (Rec."Approval Status" = Rec."Approval Status"::Approved)) then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;
    end;

    var
        myInt: Integer;
        EditableData: Boolean;
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RECORDID: RecordId;
}