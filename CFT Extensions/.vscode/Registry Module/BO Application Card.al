page 50122 "BO Application Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Applications";
    // SourceTableView = where(Processed = const(false));


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
                field("First Name"; Rec."First Name")

                {
                    ShowMandatory = true;
                    NotBlank = true;
                    trigger OnValidate()
                    begin
                        // Update Savings Account
                        // SavingsAccount.Init();
                        // SavingsAccount."Savings Product" := 'ORDINARY';
                        // SavingsAccount."Account Name" := rec."Full Name";
                        // SavingsAccount.Insert(true);
                    end;
                }
                field("Middle Name"; Rec."Middle Name")
                {

                }
                field("Last Name"; Rec."Last Name")
                {
                    ShowMandatory = true;
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
                    ShowMandatory = true;
                    NotBlank = true;
                    Importance = Promoted;
                    trigger OnValidate()
                    begin
                        // fngeneratesavingsline;
                    end;
                }
                field("KRA Pin"; Rec."KRA Pin")
                {
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Member Class"; Rec."Member Class")
                {

                }
                field("Registry Type"; Rec."Registry Type")
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
                field("Monthly Deposit Contribution"; Rec."Monthly Deposit Contribution")
                {

                }
                field("Share Capital"; Rec."Share Capital")
                {

                }
                field("Activity Code"; Rec."Activity Code")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    Importance = Additional;
                }
                field("Is Employed"; Rec."Is Employed")
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
                    ShowMandatory = true;
                    Importance = Promoted;
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
                    // Enabled = false;
                }
                field("Contact Person Phone"; Rec."Contact Person Phone")
                {
                    ShowMandatory = true;
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
                field("Passport Photo"; Rec."Passport Photo")
                {

                }
                field(Signature; Rec.Signature)
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
                    Caption = 'Employer Description';
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
                part("BO Kins"; "BO Kins")
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
                    Caption = 'Referee Number';
                }
                field("Referee Full Name"; Rec."Referee Full Name")
                {

                }
                field("Referee ID No"; Rec."Referee ID No")
                {

                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {

                }
            }
            group(Savings)
            {
                Editable = EditableData;
                part(Savingspart; "Savings Application Listpart")
                {
                    SubPageLink = "BO Application No" = field(No);
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
            part("Passport"; "BO Applications Passport")
            {
                SubPageLink = No = field(No);
            }
            part("BO Applcations Signature"; "BO Applications Signature")
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
                Enabled = not OpenApprovalEntriesExist and EnabledApprovalWorkflowsExist;

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

                begin
                    // DocumentType := DocumentType::"BO Application";
                    // ApprovalEntries.Setfilters(DATABASE::"BO Applications", DocumentType, No);
                    ApprovalEntries.Run;
                end;
            }
            action("Finish Process")
            {
                ApplicationArea = all;

                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                enabled = EnableCreateMember;
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
                        Rec."No." := Rec."Member Number";
                        Rec.Name := Rec."Full Name";
                        Rec.Processed := TRUE;
                        Rec."Processed Date Time" := CurrentDateTime;
                        Rec."Date Processed" := Today;
                        rec."Processed By" := UserId;
                        rec."Registration Date" := Today;
                        rec."Membership Status" := Rec."Membership Status"::Active;
                        Rec.Validate(Processed);
                        Rec.Modify(true);

                    end;
                    Message('BO Member %1 Has Been Created', Rec."Member Number");

                    SavingsAccount.Reset();
                    SavingsAccount.SetRange(SavingsAccount."BO Application No", Rec.No);
                    if SavingsAccount.Find('-') then begin
                        repeat

                            CustomerAccounts.Init();
                            // General Information

                            if CustomerAccounts."Member Number" = '' then begin
                                ObjGeneralSetup.Get();
                                ObjGeneralSetup.TestField(ObjGeneralSetup."BO Nos");
                                NoSeriesMgt.InitSeries(ObjGeneralSetup."BO Nos", ObjGeneralSetup."BO Nos", 0D, CustomerAccounts."Member Number", ObjGeneralSetup."BO Nos");
                            end;
                            CustomerAccounts."No." := CustomerAccounts."Member Number";
                            CustomerAccounts."Customer Posting Group" := 'CUSTOMER';
                            CustomerAccounts.No := Rec.No;
                            CustomerAccounts."BO No" := CustomerAccounts."Member Number";
                            CustomerAccounts."First Name" := SavingsAccount."First Name";
                            // CustomerAccounts."Middle Name" := Rec."Middle Name";
                            CustomerAccounts."Last Name" := SavingsAccount."Last Name";
                            CustomerAccounts."Full Name" := SavingsAccount."Account Name";
                            CustomerAccounts."Account Name" := SavingsAccount."Account Name";
                            CustomerAccounts."ID Number" := Rec."ID Number";
                            CustomerAccounts."KRA Pin" := Rec."KRA Pin";
                            CustomerAccounts."Application Date" := Today;
                            CustomerAccounts."Registration Date" := Today;
                            CustomerAccounts."Member Posting Group" := 'FO';
                            CustomerAccounts."Approval Status" := CustomerAccounts."Approval Status"::Approved;

                            CustomerAccounts."Activity Code" := 'FOSA';
                            CustomerAccounts.Processed := true;
                            // Savings Account Details
                            CustomerAccounts."FO Account Type" := SavingsAccount."Savings Product";
                            CustomerAccounts."FO Account Category" := SavingsAccount."Account Category";
                            CustomerAccounts."FO Account Category" := SavingsAccount."Account Category";
                            // Communication Information
                            CustomerAccounts.County := Rec.County;
                            CustomerAccounts."Mobile Number" := Rec."Mobile Number";
                            CustomerAccounts."Workplace Extension" := Rec."Workplace Extension";
                            CustomerAccounts."Email Address" := Rec."Email Address";
                            CustomerAccounts.District := Rec.District;
                            CustomerAccounts.Location := Rec.Location;
                            CustomerAccounts."Sub-Location" := Rec."Sub-Location";
                            CustomerAccounts."Contact Person" := Rec."Contact Person";
                            CustomerAccounts."Contact Person Designation" := Rec."Contact Person Designation";
                            // Personal Information
                            CustomerAccounts."Date of Birth" := Rec."Date of Birth";
                            CustomerAccounts.Age := Rec.Age;
                            CustomerAccounts.Gender := Rec.Gender;
                            CustomerAccounts."Marital Status" := Rec."Marital Status";
                            // Employment Information
                            CustomerAccounts."Employer Code" := Rec."Employer Code";
                            CustomerAccounts."Employer Description" := Rec."Employer Description";
                            CustomerAccounts."Department Code" := Rec."Department Code";
                            CustomerAccounts."Department Description" := Rec."Department Description";
                            CustomerAccounts.Occupation := Rec.Occupation;
                            CustomerAccounts."Terms of Employment" := Rec."Terms of Employment";
                            CustomerAccounts."Payroll Number" := Rec."Payroll Number";
                            // Bank Details
                            CustomerAccounts."Bank Code" := Rec."Bank Code";
                            CustomerAccounts."Bank Name" := Rec."Bank Name";
                            CustomerAccounts."Bank Branch" := Rec."Bank Branch";
                            CustomerAccounts."Bank Branch Name" := Rec."Bank Branch Name";
                            CustomerAccounts."Bank Account No." := Rec."Bank Account No.";
                            CustomerAccounts."Swift Code" := Rec."Swift Code";
                            // Referee Details
                            CustomerAccounts."Referee Name" := Rec."Referee Name";
                            CustomerAccounts."Referee ID No" := Rec."Referee ID No";
                            CustomerAccounts."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                            // Audit Information
                            CustomerAccounts."Captured By" := UserId;
                            CustomerAccounts."Capture Date Time" := CurrentDateTime;
                            CustomerAccounts."Date Approved" := Today;
                            CustomerAccounts."Date Processed" := Today;
                            CustomerAccounts."Processed Date Time" := CurrentDateTime;
                            CustomerAccounts."Processed By" := UserId;
                            CustomerAccounts.Insert(true);
                            // Message('Savings Product is,%1', SavingsAccount."Savings Product");
                            Message('Savings Account %1 has been Created', CustomerAccounts."Member Number");
                        until SavingsAccount.Next = 0;

                    end;







                end;




            }
            action("Add Member Savings Accounts")
            {
                trigger OnAction()
                begin
                    fngeneratesavingsline;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Member Posting Group" := 'BO';
        Rec."Activity Code" := 'BOSA';
        fngeneratesavingsline;
    end;

    trigger OnOpenPage()
    var


    begin

        if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;





    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.Editable := true;
        EditableData := true;
        EnableCreateMember := false;
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        EnabledApprovalWorkflowsExist := true;
        if rec."Approval Status" = Rec."Approval Status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if ((Rec."Approval Status" = Rec."Approval Status"::Approved) and (Rec."Member Number" = '')) then
            EnableCreateMember := true;
        IF ((Rec."Approval Status" = rec."Approval Status"::"Pending Approval") OR (Rec."Approval Status" = rec."Approval Status"::Approved)) THEN BEGIN
            CurrPage.EDITABLE := FALSE;
            EditableData := FALSE;
        END;
        // fngeneratesavingsline;
    end;

    procedure fngeneratesavingsline()
    begin
        SavingsAccount.Reset();
        SavingsAccount.SetRange(SavingsAccount."BO Application No", Rec.No);
        SavingsAccount.SetRange(SavingsAccount."Savings Product", 'ORDINARY');
        if SavingsAccount.Find('-')
        then
            exit
        else begin
            BoApplications.Reset();
            BoApplications.SetRange(BoApplications.No, Rec.No);
            if BoApplications.find('-') then begin
                SavingsAccount.Init();
                SavingsAccount."BO Application No" := Rec.No;
                SavingsAccount."Savings Product" := 'ORDINARY';
                SavingsAccount."First Name" := Rec."First Name";
                SavingsAccount."Last Name" := Rec."Last Name";
                SavingsAccount."Account Name" := rec."Full Name";
                SavingsAccount."Savings No" := EntryNo;
                SavingsAccount."Account Category" := SavingsAccount."Account Category"::Single;
                SavingsAccount."Monthly Savings" := 2000;
                SavingsAccount.Insert(true);
            end;

            // Message('Savings line inserted %1', SavingsAccount."Savings No");
        end;
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
        // DocumentType: Option;
        ApprovalEntries: Page 658;
        DocumentType: Option "BO Application","Blanket Order","Credit Memo","Funds Transfer","Imprest Requisation","Imprest Surrender",Invoice,Order,"Payment Voucher";
        SavingsAccount: Record "Savings Table4";
        CustomerAccounts: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        BoApplications: Record "BO Applications";
        EntryNo: Integer;







}