page 50141 "Loans Card(New)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = loans;
    SourceTableView = where("Approval Status" = const(Open));

    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                field("Loan Number"; Rec."Loan Number")
                {

                }
                field("Member Number"; Rec."Member Number")
                {
                    Description = 'Loaded form BO Applications - Tracking Individual Account Number for Tracking Member';
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
                field("Loan Product"; Rec."Loan Product")
                {
                    ShowMandatory = true;
                    Importance = Promoted;
                    NotBlank = true;
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
                // field("Loan Purpose"; Rec."Loan Purpose")
                // {

                // }
                field("Loan Sector"; Rec."Loan Sector")
                {

                }
                field("Level 1"; Rec."Level 1")
                {

                }
                field("Level 2"; Rec."Level 2")
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
                    Caption = 'Total Collateral Amount';
                }
            }

            group("Guarantor Details")
            {
                part(Guarantors; "Guarantors(New)")
                {
                    SubPageLink = "Loan Number" = field("Loan Number");
                }
            }
            group("Payslip Information")
            {
                part(Payslip; "Payslip Information")
                {
                    SubPageLink = "Loan Number" = field("Loan Number");
                }
            }
            group("Loans Collateral")
            {
                part(LoansCollateral; "Loan Collateral Security")
                {
                    SubPageLink = "Loan No" = field("Loan Number");

                }
            }
            group("Credit Ratios")
            {
                Visible = false;
                field("Fee Collection Rate(%)"; Rec."Fee Collection Rate(%)")
                {

                }
                field("Maximum Possible DBR(%)"; Rec."Maximum Possible DBR(%)")
                {

                }
                field("Profitability Margin"; Rec."Profitability Margin")
                {

                }
                field("Appraised Obligations Monthly"; Rec."Appraised Obligations Monthly")
                {

                }

            }
            group("Bank Details")
            {
                Visible = false;
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
            group("Cash Collection Details")
            {
                Visible = false;
                field("Term1 Details"; Rec."Term1 Details")
                {

                }
                field("Term2 Details"; Rec."Term2 Details")
                {

                }
                field("Term3 Details"; Rec."Term3 Details")
                {

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
        }
        area(FactBoxes)
        {
            part(Payslipinformation; "Payslip Summary")
            {
                SubPageLink = "Loan Number" = field("Loan Number");
            }
            part(AppraisalStatistics; "Appraisal Statistics")
            {
                SubPageLink = "Loan Number" = field("Loan Number");
            }
            part(BOStatistics; "BO Statistics")
            {
                SubPageLink = "No." = field("Member Number");
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
                enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;

                trigger OnAction()
                var
                    loanapprovalworkflow: Codeunit "Loan Approval Workflow";
                    recref: RecordRef;
                begin
                    recref.GetTable(rec);
                    if loanapprovalworkflow.CheckApprovalsWorkflowEnabled(recref) then
                        loanapprovalworkflow.OnSendWorkflowForApproval(recref);
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
                    loanapprovalworkflow: Codeunit "Loan Approval Workflow";
                    recref: RecordRef;
                begin
                    loanapprovalworkflow.OnCancelWorkflowForApproval(recref);
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
                    // DocumentType:=DocumentType::"Loan Application";
                    // ApprovalEntries.
                    // ApprovalEntries.SetRecordFilters();

                    ApprovalEntries.Run();
                end;
            }
            action(Appraise)
            {
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.Validate("Deposits Balance");
                    Rec.Validate("Net Pay");
                end;
            }
            action("Loan Appraisal Report")

            {
                ApplicationArea = All;
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    loans.Reset();
                    loans.SetRange(loans."Loan Number", Rec."Loan Number");
                    if loans.FindFirst() then begin
                        Report.RunModal(Report::LoanApraisalReport, true, false, loans);
                    end;
                end;


            }

        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        EditableData := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := true;
        if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;

        end;

        if ((Rec."Approval Status" = Rec."Approval Status"::"Pending Approval") or (rec."Approval Status" = rec."Approval Status"::Approved)) then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;

    end;

    var
        myInt: Integer;
        // DocumentType: Option;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RecordID: RecordId;
        EditableData: Boolean;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        loans: Record Loans;



}