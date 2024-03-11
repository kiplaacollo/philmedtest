page 50013 "Petty Cash Payment Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payments Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                // Editable = (not OpenApprovalEntriesExist) and RecordApproved;
                field("No."; Rec."No.")
                {

                }
                field("Document Type"; Rec."Document Type")
                {

                }
                field("Payment "; Rec."Payment ")
                {
                    Caption = 'Payment Mode';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    Visible = false;
                }
                field("Refund Type"; Rec."Refund Type")
                {
                    Visible = false;
                }
                field("Bank Account"; Rec."Bank Account")
                {

                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {

                }
                field("New Bank Account Balance"; Rec."New Bank Account Balance")
                {
                    Caption = 'Bank Account Balance';
                }
                field("Cheque Type"; Rec."Cheque Type")
                {

                }
                field("Cheque No"; Rec."Cheque No")
                {

                }
                field(Payee; Rec.Payee)
                {
                    Visible = false;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {

                }
                field("Payment Description"; Rec."Payment Description")
                {

                }
                field("New Amount"; Rec."New Amount")
                {
                    Caption = 'Amount';
                }
                field("New Amount(LCY)"; Rec."New Amount(LCY)")
                {
                    Caption = 'Amount(LCY)';
                }
                field("New VAT Amount"; Rec."New VAT Amount")
                {
                    Caption = 'VAT Amount';
                }
                field("New VAT Amount(LCY)"; Rec."New VAT Amount(LCY)")
                {
                    Caption = 'VAT Amount(LCY)';
                }
                field("New Withholding Tax Amount"; Rec."New Withholding Tax Amount")
                {
                    Caption = 'Withholding Tax Amount';
                }
                field("W/Tax Amount(LCY)"; Rec."W/Tax Amount(LCY)")
                {
                    Caption = 'Withholding Tax Amount(LCY)';
                }
                field("New Net Amount"; Rec."New Net Amount")
                {
                    Caption = 'Net Amount';
                }
                field("New Net Amount(LCY)"; Rec."New Net Amount(LCY)")
                {
                    Caption = 'Net Amount(LCY)';
                }
                field("Document Date"; Rec."Document Date")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(Posted; Rec.Posted)
                {

                }
                field("Posted By"; Rec."Posted By")
                {

                }
                field("Date Posted"; Rec."Date Posted")
                {

                }
                field("Time Posted"; Rec."Time Posted")
                {

                }
                field(Cashier; Rec.Cashier)
                {

                }
            }
            group("Payment Line")
            {
                // Editable = (not OpenApprovalEntriesExist) and RecordApproved;
                part(Payment; "Payment Line")
                {
                    SubPageLink = "Document No" = field("No.");
                }
            }
        }
        area(FactBoxes)
        {
            part("Active Workflows"; "Workflow Status FactBox")
            {
                Enabled = false;
                Editable = false;
                ApplicationArea = suite;
                ShowFilter = false;
                // Visible = ShowWorkflowStatus;
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
                PromotedIsBig = true;
                Enabled = (not OpenApprovalEntriesExist) and not RecordApproved;
                trigger OnAction()
                var
                    paymentsapprovalworkflow: Codeunit "Payments Approval Workflow";
                    RecRef: RecordRef;
                begin
                    CheckRequiredFields();
                    Rec.TestField(Status, Rec.Status::Open);
                    RecRef.GetTable(Rec);
                    IF paymentsapprovalworkflow.CheckApprovalsWorkflowEnabled(RecRef) then
                        paymentsapprovalworkflow.OnSendWorkflowForApproval(RecRef);
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = CanCancelApprovalForRecord;
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
                Promoted = true;
                Image = Approvals;
                PromotedCategory = Process;
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
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    FundsUser: Record "Funds User Setup";
                begin
                    CheckRequiredItems;
                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Petty Cash Template");
                        FundsUser.TestField(FundsUser."Petty Cash Batch");
                        JTemplate := FundsUser."Petty Cash Template";
                        JBatch := FundsUser."Petty Cash Batch";
                        // JTemplate := 'GENERAL';
                        // JBatch := 'DEFAULT';
                        // Message('The Journal Template is/:%1, Journal Batch is %2', FundsUser."Petty Cash Template", FundsUser."Petty Cash Batch");
                        FundsManager.PostPayment(Rec, JTemplate, JBatch);
                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end;
                end;
            }
            action("Post and Print")
            {
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    CheckRequiredItems;
                    DocNo := Rec."No.";
                    if FundsUser.get(UserId) then begin
                        FundsUser.TestField(FundsUser."Payment Journal Template");
                        FundsUser.TestField(FundsUser."Payment Journal Batch");
                        JTemplate := FundsUser."Payment Journal Template";
                        JBatch := FundsUser."Payment Journal Batch";
                        FundsManager.PostPayment(Rec, JTemplate, JBatch);
                        Commit;
                        PHeader.reset;
                        PHeader.SetRange(PHeader."No.", DocNo);
                        if PHeader.FindFirst then begin

                        end;
                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end;
                end;
            }
            action("Petty Cash Voucher")
            {
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    pettycash: Record "Payments Header";
                begin
                    pettycash.Reset();
                    pettycash.SetRange(pettycash."No.", Rec."No.");
                    if pettycash.FindFirst() then begin
                        Report.RunModal(Report::"Petty Cash Voucher", true, false, pettycash);
                    end;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Petty Cash";
        Rec."Payment " := Rec."Payment "::Cash;
        Rec."Document Type" := Rec."Document Type"::"Petty Cash";
        Rec."Cheque Type" := Rec."Cheque Type"::"Manual Cheque";
        Rec."On Behalf Of" := 'EPA';
        Rec."Bank Account" := 'BANK_0004';
        Rec.Validate("Bank Account");
    end;

    procedure CheckRequiredFields()
    begin
        Rec.TestField("Posting Date");
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

    trigger OnAfterGetCurrRecord()
    var

    begin
        RecordApproved := false;
        ShowWorkflowStatus := CurrPage."Active Workflows".Page.SetFilterOnWorkflowRecord(RECORDID);
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        // EventFilter :=
        // EnabledApprovalWorkflowsExist:=
        IF Rec.Status = Rec.Status::Approved THEN
            RecordApproved := TRUE;
    end;

    procedure CheckRequiredItems()
    begin
        Rec.TestField("Posting Date");
        Rec.TestField(Status, Rec.Status::Approved);
        Rec.TestField("Bank Account");
        Rec.TestField("Payment Description");
        if Rec.Status = Rec.Status::Posted then
            Error('Document Already Posted');
        if (Rec."Payment " = Rec."Payment "::Cheque) and (Rec."Cheque Type" = Rec."Cheque Type"::"Manual Cheque") then
            Rec.TestField("Cheque No");
        PaymentLine.Reset();
        PaymentLine.SetRange(PaymentLine."Document No", Rec."No.");
        if PaymentLine.FindSet then begin
            repeat
                PaymentLine.TestField(PaymentLine."Payment Description");
                PaymentLine.TESTFIELD(PaymentLine.Amount);
            until PaymentLine.Next = 0;
        end;
        if Rec."Currency Code" = '' then begin
            if BankAcc.Get(Rec."Bank Account") then
                BankAcc.TestField(BankAcc."Currency Code", '');
        end;
    end;

    var
        myInt: Integer;
        ObjPaymentLine: Record "Payment Line Table";
        DocumentType: Option "Blanket Order","Credit Memo","Imprest Requisation","Imprest Surrender",Invoice,Order,"Payment Voucher",Quote,"Return Order";
        RecordApproved: Boolean;
        ShowWorkflowStatus: Boolean;
        RECORDID: RecordId;
        OpenApprovalEntriesExistCurrUser: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnabledApprovalWorkflowsExist: Boolean;
        PaymentLine: Record "Payment Line Table";
        BankAcc: Record "Bank Account";
        JTemplate: Code[20];
        JBatch: Code[20];
        FundsManager: Codeunit "Funds Management";
        DocNo: Code[20];
        FundsUser: Record "Funds User Setup";
        PHeader: Record "Payments Header";

}