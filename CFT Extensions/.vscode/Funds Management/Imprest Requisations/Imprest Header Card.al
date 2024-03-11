page 50037 "Imprest Header"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Header";
    Caption = 'Travel Imprest Request';
    SourceTableView = where(Posted = const(false));
    DeleteAllowed = false;
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = (not OpenApprovalEntriesExist) and not RecordApproved;
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Function Name"; Rec."Function Name")
                {
                    Visible = false;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = ShortcutDimension2CodeEditable;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                    Editable = ShortcutDimension3CodeEditable;
                }
                field(Dim3; Rec.Dim3)
                {
                    Visible = false;
                    Editable = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Visible = false;
                    Editable = ShortcutDimension4CodeEditable;
                }
                field(Dim4; Rec.Dim4)
                {
                    Visible = false;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {

                }
                field(Requisition; Rec.Requisition)
                {
                    Visible = false;
                }
                field(Payee; Rec.Payee)
                {
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    Editable = "Currency CodeEditable";
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {

                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {

                }
                field(Cashier; Rec.Cashier)
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {

                }
                field("Total Net Amount lCY"; Rec."Total Net Amount lCY")
                {

                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {

                }
                field("Pay Mode"; Rec."Pay Mode")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field("Cheque No."; Rec."Cheque No.")
                {

                }

            }
            group("Imprest Lines")
            {
                Editable = (not OpenApprovalEntriesExist) and not RecordApproved;
                part(PVLines; "Imprest Lines")
                {
                    SubPageLink = No = field("No.");
                }
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
                trigger OnAction()
                var
                    ImprestWorkflow: Codeunit "Imprest Requisition Workflow";
                    RecRef: RecordRef;
                begin
                    Rec.TestField("Payment Release Date");
                    Rec.TestField("Paying Bank Account");
                    Rec.TestField("Account No.");
                    Rec.TestField("Cheque No.");
                    Rec.TestField("Account Type", Rec."Account Type"::Customer);
                    if not LinesExists then
                        Error('There are no Lines created for this Document');
                    if not AllFieldsEntered then
                        Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                    Rec.TestField(Status, Rec.Status::Open);
                    RecRef.GetTable(Rec);
                    if ImprestWorkflow.CheckApprovalsWorkflowEnabled(RecRef) then
                        ImprestWorkflow.OnSendWorkflowForApproval(RecRef);
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
                    ImprestWorkflow: Codeunit "Imprest Requisition Workflow";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);

                    ImprestWorkflow.OnCancelWorkflowForApproval(RecRef);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = all;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    DocumentType := DocumentType::"Imprest Requisation";
                    ApprovalEntries.SetRecordFilters(Database::"Imprest Header", DocumentType, Rec."No.");
                    ApprovalEntries.Run();
                end;
            }
            action("Post Payment")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    CheckImprestRequiredItems(Rec);
                    PostImprest(Rec);
                end;
            }
        }
    }
    trigger OnInit()
    begin
        "Currency CodeEditable" := true;
        DateEditable := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
        "Cheque No.Editable" := true;
        "Pay ModeEditable" := true;
        "Paying Bank AccountEditable" := true;
        "Payment Release DateEditable" := true;
        OpenApprovalEntriesExistCurrUser := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // check if the document has been added while another one is still pending
        TravReqHeader.Reset();
        TravReqHeader.SetRange(TravReqHeader.Cashier, UserId);
        TravReqHeader.SetRange(TravReqHeader.Status, Rec.Status::Open);
        if TravReqHeader.Count > 0 then begin
            Message('There are still some pending document(s) on your account. Ensure that they are Posted! Continue...');
        end;
        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    procedure LinesExists(): Boolean
    begin
        HasLines := false;
        PayLines.Reset();
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    procedure AllFieldsEntered(): Boolean
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset();
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Account No" = '') or (PayLines.Amount <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next() = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RecordApproved := false;
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        IF Rec.Status = Rec.Status::Approved THEN
            RecordApproved := TRUE;

    end;

    procedure CheckImprestRequiredItems(Rec: Record "Imprest Header")
    begin
        Rec.TestField("Payment Release Date");
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Account No.");
        Rec.TestField("Cheque No.");
        Rec.TestField("Account Type", Rec."Account Type"::Customer);
        if Rec.posted then begin
            Error('The Document has already been posted');
        end;
        rec.TestField(Status, Rec.Status::Approved);
        Temp.Get(UserId);
        JTemplate := Temp."Imprest Template";
        JBatch := Temp."Imprest Batch";

        IF JTemplate = '' THEN BEGIN
            ERROR('Ensure the Imprest Template is set up in Cash Office Setup');
        END;

        IF JBatch = '' THEN BEGIN
            ERROR('Ensure the Imprest Batch is set up in the Cash Office Setup')
        END;

        IF NOT LinesExists THEN
            ERROR('There are no Lines created for this Document');
    end;

    procedure PostImprest(Rec: Record "Imprest Header")
    begin
        if Temp.Get(UserId) then begin
            GenJnlLine.Reset();
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DeleteAll();
        end;
        LineNo := LineNo + 1000;
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Payment Release Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := Rec."Account No.";
        GenJnlLine.Description := 'Travel Advance: ' + rec."Account No." + ':' + Rec.Payee;
        Rec.CalcFields("Total Net Amount");
        GenJnlLine.Amount := Rec."Total Net Amount";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := Rec."Paying Bank Account";
        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        // Added for Currency Codes
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine.VALIDATE("Currency Code");
        GenJnlLine."Currency Factor" := Rec."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        GenJnlLine.ValidateShortcutDimCode(3, rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Line", GenJnlLine);
        MESSAGE('Successfully Posted');
        Rec.Posted := true;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify(true);


    end;

    var
        myInt: Integer;
        "Currency CodeEditable": Boolean;
        DateEditable: Boolean;
        ShortcutDimension2CodeEditable: Boolean;
        GlobalDimension1CodeEditable: Boolean;
        "Cheque No.Editable": Boolean;
        "Pay ModeEditable": Boolean;
        "Paying Bank AccountEditable": Boolean;
        "Payment Release DateEditable": Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        ShortcutDimension3CodeEditable: Boolean;
        ShortcutDimension4CodeEditable: Boolean;
        TravReqHeader: Record "Imprest Header";
        HasLines: Boolean;
        PayLines: Record "Imprest Lines";
        AllKeyFieldsEntered: Boolean;
        DocumentType: Option "Blanket Order","Credit Memo","Funds Transfer","Imprest Requisation","Imprest Surrender",Invoice,Order,"Payment Voucher";
        ApprovalEntries: Page 658;
        RecordApproved: Boolean;
        ShowWorkflowStatus: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RECORDID: RecordId;
        CanCancelApprovalForRecord: Boolean;
        Temp: Record "Funds User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;

}