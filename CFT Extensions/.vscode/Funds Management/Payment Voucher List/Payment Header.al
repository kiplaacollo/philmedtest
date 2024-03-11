page 50001 "Payment Header"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payments Header";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {

                }
                field("Payment Type"; Rec."Payment Type")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Payment "; Rec."Payment ")
                {
                    Editable = true;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Apply to Document"; Rec."Apply to Document")
                {
                    Visible = false;
                }
                field("Apply to Document No"; Rec."Apply to Document No")
                {
                    Visible = false;
                }
                field("Bank Account"; Rec."Bank Account")
                {

                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {

                }
                field("Bank Account Balance"; Rec."Bank Account Balance")
                {

                }
                field("Credit Life Admin Fee"; Rec."Credit Life Admin Fee")
                {
                    Caption = 'Include Credit Fees Admin Fees';
                    trigger OnValidate()
                    begin
                        if Rec."Credit Life Admin Fee" = true then begin
                            AdminVisible := true;
                            Rec."Admin Fees Account" := '';
                            rec."Admin Fees Amount" := 0;
                        end else begin
                            AdminVisible := false;
                            Rec."Admin Fees Account" := '';
                            Rec."Admin Fees Amount" := 0;
                        end;
                    end;
                }
                group("Credit Life Admin Fees")
                {
                    Visible = AdminVisible;
                    field("Admin Fees Account"; Rec."Admin Fees Account")
                    {

                    }
                    field("Admin Fees Amount"; Rec."Admin Fees Amount")
                    {

                    }
                }

                field("Cheque Type"; Rec."Cheque Type")
                {

                }
                field("Cheque No"; Rec."Cheque No")
                {

                }
                field(Payee; Rec.Payee)
                {

                }
                field("Payment Description"; Rec."Payment Description")
                {

                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {

                }
                field("New Amount"; Rec."New Amount")
                {
                    Caption = 'Amount';
                }
                field("New Amount(LCY)"; Rec."New Amount(LCY)")
                {
                    Caption = 'Amount(LCY)';
                    Visible = false;
                }
                field("New VAT Amount"; Rec."New VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("New VAT Amount(LCY)"; Rec."New VAT Amount(LCY)")
                {
                    Caption = 'VAT Amount(LCY)';
                    Visible = false;
                }
                field("New Withholding Tax Amount"; Rec."New Withholding Tax Amount")
                {
                    Caption = 'Withholding Tax Amount';
                }
                field("W/Tax Amount(LCY)"; Rec."W/Tax Amount(LCY)")
                {
                    Caption = 'Withholding Tax Amount(LCY)';
                    Visible = false;
                }
                field("New Net Amount"; Rec."New Net Amount")
                {
                    Caption = 'Net Amount';
                }
                field("New Net Amount(LCY)"; Rec."New Net Amount(LCY)")
                {
                    Caption = 'Net Amount(LCY)';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Branch Code';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {

                }
                field(Cashier; Rec.Cashier)
                {

                }
            }

            group("Payment Line")
            {
                part(PaymentLine; "Payment Line")
                {
                    SubPageLink = "Document No" = field("No.");
                }
            }
        }
        area(FactBoxes)
        {
            part(WorkflowStatus; "Workflow Status FactBox")

            {
                Visible = ShowWorkflowStatus;
                Enabled = false;
                Editable = false;
                ApplicationArea = suite;
                ShowFilter = false;

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
                Enabled = (not OpenApprovalEntriesExist) and not RecordApproved;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    paymentsapprovalworkflow: Codeunit "Payments Approval Workflow";
                    RecRef: RecordRef;
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    CheckRequiredFields();
                    RecRef.GetTable(Rec);
                    IF paymentsapprovalworkflow.CheckApprovalsWorkflowEnabled(RecRef) then
                        paymentsapprovalworkflow.OnSendWorkflowForApproval(RecRef);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = all;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = CanCancelApprovalForRecord;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    paymentsapprovalworkflow: Codeunit "Payments Approval Workflow";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    paymentsapprovalworkflow.OnCancelWorkflowForApproval(RecRef);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = all;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ApprovalEntries: Page 658;
                begin
                    DocumentType := DocumentType::"Payment Voucher";
                    ApprovalEntries.SetRecordFilters(Database::"Payments Header", DocumentType, Rec."No.");
                    ApprovalEntries.Run();
                end;
            }
            action("Post Payment")
            {
                ApplicationArea = all;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    FnDeleteEmptyLines(Rec."No.");
                    CheckRequiredItems();
                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Payment Journal Template");
                        FundsUser.TestField(FundsUser."Payment Journal Batch");
                        JTemplate := FundsUser."Payment Journal Template";
                        JBatch := FundsUser."Payment Journal Batch";
                        FundsManager.PostPayment(Rec, JTemplate, JBatch);

                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end;
                end;
            }
        }
    }
    trigger OnInit()
    begin
        OpenApprovalEntriesExistCurrUser := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::Normal;
        Rec."Payment " := Rec."Payment "::Cheque;
        Rec."Cheque Type" := Rec."Cheque Type"::"Manual Cheque";
        Rec.Payee := 'EPA';
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ShowWorkflowStatus := CurrPage.WorkflowStatus.Page.SetFilterOnWorkflowRecord(RECORDID);
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        // EventFilter := WorkflowEventHandling.RunWorkflowOnSendPaymentsHeaderForApprovalCode;
        // EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::"Payments Header", EventFilter);
        IF Rec.Status = Rec.Status::Approved THEN
            RecordApproved := TRUE;
        if Rec."Credit Life Admin Fee" = true then begin
            AdminVisible := true;
        end else begin
            AdminVisible := false;
        end;
    end;

    procedure CheckRequiredFields()
    begin
        Rec.TestField("Posting Date");
        Rec.TestField(Payee);
        Rec.TestField("Bank Account");
        Rec.TestField("Payment Description");
        Rec.TestField("Cheque Type");
        Rec.TestField("Cheque No");
        Rec.TestField("Global Dimension 2 Code");
        Rec.TestField("Responsibility Center");
        ObjPaymentLine.Reset();
        ObjPaymentLine.SetRange(ObjPaymentLine."Document No", Rec."No.");
        ObjPaymentLine.SETFILTER(ObjPaymentLine."Transaction Type", '<>%1', '');
        ObjPaymentLine.SETFILTER(ObjPaymentLine."Account No.", '<>%1', '');
        if ObjPaymentLine.Find('-') then begin
            ObjPaymentLine.CalcSums(ObjPaymentLine.Amount);
            if ObjPaymentLine.Amount = 0 then
                Error('The Payment Lines Must have Payment Entries!!');
        end else
            Error('The Payment Lines Must have fully filled Payment Entries!!');
    end;

    procedure FnDeleteEmptyLines(DocNo: Code[50])
    var
        PLine: Record "Payment Line Table";
    begin
        PLine.Reset();
        PLine.SetRange(PLine."Document No", DocNo);
        PLine.SetRange(PLine.Amount, 0);
        if PLine.FindSet then
            PLine.DeleteAll;
    end;

    procedure CheckRequiredItems()
    begin
        Rec.TestField("Posting Date");
        Rec.TestField(Payee);
        Rec.TestField("Bank Account");
        Rec.TestField("Payment Description");
        Rec.TestField("Cheque Type");
        Rec.TestField("Cheque No");
        Rec.TestField("Global Dimension 2 Code");
        Rec.TestField("Responsibility Center");
        if Rec.Status <> Rec.Status::Approved then Error('Document must first be approved!');
        if Rec.Status = Rec.Status::Posted then Error('Document already posted');
        if (Rec."Payment " = Rec."Payment "::Cheque) and (Rec."Cheque Type" = Rec."Cheque Type"::"Manual Cheque") then
            Rec.TestField("Cheque No");
        PaymentLine.Reset();
        PaymentLine.SetRange(PaymentLine."Document No", Rec."No.");
        if PaymentLine.FindSet then begin
            repeat
                PaymentLine.TestField(PaymentLine."Payment Description");
                PaymentLine.TestField(PaymentLine.Amount);
            until PaymentLine.Next = 0;
        end;
        if Rec."Currency Code" = '' then begin
            if BankAcc.Get(Rec."Bank Account") then
                BankAcc.TestField(BankAcc."Currency Code", '');

        end;
    end;

    var
        myInt: Integer;
        OpenApprovalEntriesExistCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        RECORDID: RecordId;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        RecordApproved: Boolean;
        AdminVisible: Boolean;
        ObjPaymentLine: Record "Payment Line Table";
        DocumentType: Option "Blanket Order","BO Application","Credit Memo","Funds Transfer","Imprest Requisation","Imprest Surrender",Invoice,"Loan Application","Loan Disbursement",Order,"Payment Voucher","Petty Cash",Quote,"Return Order";
        PaymentLine: Record "Payment Line Table";
        BankAcc: Record "Bank Account";
        FundsUser: Record "Funds User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        FundsManager: Codeunit "Funds Management";
}