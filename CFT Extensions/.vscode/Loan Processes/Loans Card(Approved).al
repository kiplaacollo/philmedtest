page 50145 "Loans Card(Approved)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Loans;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;
    SourceTableView = where("Approval Status" = const(Approved));

    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                Editable = false;
                field("Loan Number"; Rec."Loan Number")
                {
                    Visible = false;
                }
                field("Member Number"; Rec."Member Number")
                {
                    Importance = Promoted;
                }
                field("Full Name"; Rec."Full Name")
                {
                    Importance = Promoted;
                }
                field("ID Number"; Rec."ID Number")
                {

                }
                field("Mobile Number"; Rec."Mobile Number")
                {

                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    Importance = Additional;
                }
                field("RM Code"; Rec."RM Code")
                {

                }
                field("RM Name"; Rec."RM Name")
                {
                    Editable = false;
                }
            }
            group("Loan Information")
            {
                Editable = false;
                field("Loan Product"; Rec."Loan Product")
                {
                    ShowMandatory = true;
                    Importance = Promoted;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {

                }
                field(Installments; Rec.Installments)
                {

                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {

                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {

                }
                field("Deposits Factor"; Rec."Deposits Factor")
                {
                    Visible = false;
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    Importance = Promoted;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Importance = Promoted;
                }
                field("Credit Life Type"; Rec."Credit Life Type")
                {

                }
                field("Credit Life Rate"; Rec."Credit Life Rate")
                {

                }
                field("Total Offset Amount"; Rec."Total Offset Amount")
                {

                }
                field("Total Upfront Deductions"; Rec."Total Upfront Deductions")
                {

                }
                field("New Collateral Amount"; Rec."New Collateral Amount")
                {
                    Importance = Additional;
                }
            }

            group("Guarantor Details")
            {
                part(Guarantordetails; "Guarantors(New)")
                {
                    SubPageLink = "Loan Number" = field("Loan Number");
                }
            }
            group("Loans Collateral")
            {
                part(Loanscollateral; "Loan Collateral Security")
                {
                    Editable = false;
                    SubPageLink = "Loan No" = field("Loan Number");
                }
            }
            group("Credit Ratios")
            {
                Visible = false;
                Editable = true;
                field("Fee Collection Rate(%)"; Rec."Fee Collection Rate(%)")
                {

                }
                field("Maximum Possible DBR(%)"; Rec."Maximum Possible DBR(%)")
                {

                }
                field("Profitability Margin(%)"; Rec."Profitability Margin(%)")
                {

                }
                field("Appraised Obligations Monthly"; Rec."Appraised Obligations Monthly")
                {

                }
            }
            group("Bank Details")
            {
                Visible = false;
                Editable = false;
                group("Main Bank")
                {
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
                group("Alternative Bank")
                {
                    field("Bank Code 2"; Rec."Bank Code 2")
                    {

                    }
                    field("Bank Name 2"; Rec."Bank Name 2")
                    {

                    }
                    field("Bank Branch 2"; Rec."Bank Branch 2")
                    {

                    }
                    field("Bank Branch Name 2"; Rec."Bank Branch Name 2")
                    {

                    }
                    field("Bank Account No. 2"; Rec."Bank Account No. 2")
                    {

                    }
                    field("Swift Code 2"; Rec."Swift Code 2")
                    {

                    }
                }
                group("ABB Bank Details")
                {
                    Visible = false;
                    Editable = false;
                    field("ABB Bank1 Details"; Rec."ABB Bank1 Details")
                    {

                    }
                    field("ABB Bank2 Details"; Rec."ABB Bank2 Details")
                    {

                    }
                    field("ABB Bank3 Details"; Rec."ABB Bank3 Details")
                    {

                    }
                }

            }
            group("Audit Information")
            {
                field("Application Date"; Rec."Application Date")
                {

                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {

                }
                field("Guarantors Notified"; Rec."Guarantors Notified")
                {

                }
                field("Created By"; Rec."Created By")
                {

                }
                field("Approval Status"; Rec."Approval Status")
                {

                }
            }
            group("Disbursement Information")
            {
                Editable = DisbursementEditable;
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {

                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {

                }
                field("Repayment Debut Date"; Rec."Repayment Debut Date")
                {

                }
                field("Loan Perfection Charges"; Rec."Loan Perfection Charges")
                {

                }
                field("Loan Prepayments"; Rec."Loan Prepayments")
                {

                }
                field("Gross Disbursed Amount"; Rec."Gross Disbursed Amount")
                {

                }
                field("Total Monthly Repayment"; Rec."Total Monthly Repayment")
                {

                }
                field("BO Group"; Rec."BO Group")
                {

                }

            }
        }
        area(FactBoxes)
        {
            part(Appraisalstatistics; "Appraisal Statistics")
            {
                SubPageLink = "Loan Number" = field("Loan Number");
            }
            part(Customerstatistics; "BO Statistics")
            {
                SubPageLink = "No." = field("Member Number");
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Disburse)
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    // Rec.TestField("Approved Amount");
                    // Rec.TestField("Total Monthly Repayment");
                    Rec."Loan Status" := Rec."Loan Status"::Approved;
                    if Rec."Branch Code" = '' then
                        Rec."Branch Code" := 'NAIROBI';
                    Rec.Modify();
                    // Rec.TestField("Mode of Disbursement");
                    Rec.TestField("Loan Status", rec."Loan Status"::Approved);
                    Rec.TestField("Approval Status", rec."Approval Status"::Approved);
                    FnCheckDisbursementExists();
                    FnCreateDisbursement();
                end;
            }
            action("Restart Process")
            {
                ApplicationArea = all;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec."Loan Status" := Rec."Loan Status"::New;
                    Rec."Approval Status" := Rec."Approval Status"::Open;
                    Rec.Modify(true);

                end;
            }
        }
    }
    procedure FnCreateDisbursement()
    begin
        if Rec."Amount Disbursed" <> rec."Approved Amount" then begin
            ObjGeneralSetup.GET;
            ObjGeneralSetup.TESTFIELD(ObjGeneralSetup."BO Loan Disbursement Nos");
            NoSeriesMgt.InitSeries(ObjGeneralSetup."BO Loan Disbursement Nos", ObjGeneralSetup."BO Loan Disbursement Nos", 0D, ObjGeneralSetup."BO Loan Disbursement Nos", ObjGeneralSetup."BO Loan Disbursement Nos");
            LDisbursement.Init();
            if LDisbursement."No." = '' then begin
                ObjGeneralSetup.GET;
                ObjGeneralSetup.TESTFIELD(ObjGeneralSetup."BO Loan Disbursement Nos");
                NoSeriesMgt.InitSeries(ObjGeneralSetup."BO Loan Disbursement Nos", ObjGeneralSetup."BO Loan Disbursement Nos", 0D, LDisbursement."No.", ObjGeneralSetup."BO Loan Disbursement Nos");
            end;
            LDisbursement."Client No" := rec."Member Number";
            LDisbursement.Validate(LDisbursement."Client No");
            LDisbursement."Loan No" := Rec."Loan Number";
            LDisbursement.Validate(LDisbursement."Loan No");
            LDisbursement."Approval Date" := Rec."Approval Date";
            LDisbursement."Repayment Start Date" := Rec."Repayment Debut Date";
            LDisbursement."Loan Disbursement Date" := Rec."Disbursement Date";
            LDisbursement."Booked By" := UserId;
            LDisbursement."Loan Product Type" := Rec."Loan Product";
            if (Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::Full) then
                LDisbursement."Disbursement Type" := LDisbursement."Disbursement Type"::"Full/Single disbursement" else
                if (Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::Tranches) then
                    IF rec."Gross Disbursed Amount" <= 0 THEN begin
                        ERROR('For Trunch Disbursement, Gross Disbursement Amount Must be Specified!');
                        LDisbursement."Disbursement Type" := LDisbursement."Disbursement Type"::"Tranche/Multiple Disbursement";
                    end;
            // end;
            LDisbursement.Validate(LDisbursement."Disbursement Type");
            if rec."Gross Disbursed Amount" > 0 then begin
                LDisbursement."Requested Amount" := rec."Gross Disbursed Amount";

            end;
            if Rec."Loan Status" = Rec."Loan Status"::Approved then
                if LDisbursement.Insert then begin
                    rec."Initial Disbursement Created" := true;
                    Rec.Modify();
                    Message('Record Successfully Sent to Disbursement for Posting.');
                end;
        end;
    end;

    procedure FnCheckDisbursementExists()
    begin
        LDisbursement.Reset();
        LDisbursement.SetRange("Loan No", Rec."Loan Number");
        if LDisbursement.Find(('-')) then
            Error('First Disbursement Record Already Exists under the Disbursement Module');
    end;

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
        if ((Rec."Approval Status" = Rec."Approval Status"::Approved) and (Rec."Member Number" = '')) then
            EnableCreateMember := true;
        if ((Rec."Approval Status" = Rec."Approval Status"::"Pending Approval") or (Rec."Approval Status" = Rec."Approval Status"::Approved)) then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;
        if Rec."Initial Disbursement Created" = true then begin
            DisbursementEditable := false;
        end
        else
            DisbursementEditable := true;
    end;

    var
        myInt: Integer;
        ObjGeneralSetup: Record "BO General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LDisbursement: Record "Loan Disbursement";
        EditableData: Boolean;
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RECORDID: RecordId;
        DisbursementEditable: Boolean;
}