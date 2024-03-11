page 50040 "Imprest Surrender Header"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Surrender Header";
    Caption = 'Travel Imprest Surrender';
    SourceTableView = where(Posted = const(false));
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Enabled = (NOT OpenApprovalEntriesExist) AND NOT RecordApproved;
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                    Editable = "Surrender DateEditable";
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = "Account No.Editable";
                    trigger OnValidate()
                    begin
                        Cust.Reset();
                        if Cust.Get(Rec."Account No.") then
                            Rec."Account Name" := Cust.Name;
                    end;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Imprest Issue Doc. No"; Rec."Imprest Issue Doc. No")
                {
                    Editable = "Imprest Issue Doc. NoEditable";
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Imprest Issue Date"; Rec."Imprest Issue Date")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        DimName1 := GetDimensionName(Rec."Global Dimension 1 Code", 1);

                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = false;
                }
            }
            group("Imprest Surrender Lines")
            {
                part(ImprestLines; "Imprest Surrender Lines")
                {
                    Enabled = (NOT OpenApprovalEntriesExist) AND NOT RecordApproved;
                    SubPageLink = "Surrender Doc No" = field(No);
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
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Enabled = (NOT OpenApprovalEntriesExist) AND NOT RecordApproved;

                trigger OnAction()
                var
                    SurrenderWorkflow: Codeunit "Imprest Surrender Workflow";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    if SurrenderWorkflow.CheckApprovalsWorkflowEnabled(RecRef) then
                        SurrenderWorkflow.OnSendWorkflowForApproval(RecRef);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = CancelApprovalRequest;
                Enabled = CanCancelApprovalForRecord;
                trigger OnAction()
                var
                    SurrenderWorkflow: Codeunit "Imprest Surrender Workflow";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);

                    SurrenderWorkflow.OnCancelWorkflowForApproval(RecRef);
                end;
            }
            action(Approvals)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = Approvals;
                trigger OnAction()
                begin

                end;
            }
            action(Post)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = Post;
                Enabled = RecordApproved;
                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Rec.Posted then
                        Error('The transaction has already been posted.');
                    Rec.CalcFields("Actual Spent");
                    if Rec."Actual Spent" = 0 then
                        if Confirm(Text000, true) then
                            UpdateforNoActualSpent
                        else
                            Error(Text001);
                    if GenledSetup.Get(UserId) then begin
                        GenJnlLine.Reset();
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", GenledSetup."Imprest Template");
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", GenledSetup."Imprest Batch");
                        GenJnlLine.DELETEALL;
                    end;
                    IF DefaultBatch.GET(GenledSetup."Imprest Template", GenledSetup."Imprest Batch") THEN begin
                        DefaultBatch.DELETE;
                    end;
                    DefaultBatch.RESET;
                    DefaultBatch."Journal Template Name" := GenledSetup."Imprest Template";
                    DefaultBatch.Name := GenledSetup."Imprest Batch";
                    DefaultBatch.INSERT;
                    LineNo := 0;
                    ImprestDetails.RESET;
                    ImprestDetails.SETRANGE(ImprestDetails."Surrender Doc No", Rec.No);
                    IF ImprestDetails.FIND('-') THEN begin
                        repeat
                            IF (ImprestDetails."Cash Surrender Amt" + ImprestDetails."Actual Spent") <> ImprestDetails.Amount THEN
                                ERROR(Txt0001);
                            LineNo := LineNo + 1000;
                            GenJnlLine.Init();
                            GenJnlLine."Journal Template Name" := GenledSetup."Imprest Template";
                            GenJnlLine."Journal Batch Name" := GenledSetup."Imprest Batch";
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Source Code" := 'PAYMENTJNL';
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No." := ImprestDetails."Account No";
                            GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                            // Set these fields to blanks
                            GenJnlLine."Posting Date" := Rec."Surrender Date";
                            GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                            GenJnlLine.VALIDATE("Gen. Posting Type");
                            GenJnlLine."Gen. Bus. Posting Group" := '';
                            GenJnlLine.VALIDATE("Gen. Bus. Posting Group");
                            GenJnlLine."Gen. Prod. Posting Group" := '';
                            GenJnlLine.VALIDATE("Gen. Prod. Posting Group");
                            GenJnlLine."VAT Bus. Posting Group" := '';
                            GenJnlLine.VALIDATE("VAT Bus. Posting Group");
                            GenJnlLine."VAT Prod. Posting Group" := '';
                            GenJnlLine.VALIDATE("VAT Prod. Posting Group");
                            GenJnlLine."Document No." := Rec.No;
                            GenJnlLine.Amount := ImprestDetails."Actual Spent";
                            GenJnlLine.VALIDATE(GenJnlLine.Amount);
                            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Customer;
                            GenJnlLine."Bal. Account No." := ImprestDetails."Imprest Holder";
                            GenJnlLine.Description := 'Imprest Surrendered by staff';
                            GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                            GenJnlLine."Currency Code" := Rec."Currency Code";
                            GenJnlLine.VALIDATE("Currency Code");
                            // Take care of Currency Factor
                            GenJnlLine."Currency Factor" := Rec."Currency Factor";
                            GenJnlLine.VALIDATE("Currency Factor");
                            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                            GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                            // Application of Surrender entries
                            IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer THEN BEGIN
                                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                GenJnlLine."Applies-to Doc. No." := Rec."Imprest Issue Doc. No";
                                GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                                GenJnlLine."Applies-to ID" := Rec."Apply to ID";
                            END;
                            IF GenJnlLine.Amount <> 0 THEN
                                GenJnlLine.INSERT;
                            // Post Cash Surrender
                            IF ImprestDetails."Cash Surrender Amt" > 0 THEN begin
                                IF ImprestDetails."Bank/Petty Cash" = '' THEN
                                    ERROR('Select a Bank Code where the Cash Surrender will be posted');
                                LineNo := LineNo + 1000;
                                GenJnlLine.INIT;
                                GenJnlLine."Journal Template Name" := GenledSetup."Imprest Template";
                                GenJnlLine."Journal Batch Name" := GenledSetup."Imprest Batch";
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                GenJnlLine."Account No." := ImprestDetails."Imprest Holder";
                                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                                // Set these fields to blanks
                                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                                GenJnlLine.VALIDATE("Gen. Posting Type");
                                GenJnlLine."Gen. Bus. Posting Group" := '';
                                GenJnlLine.VALIDATE("Gen. Bus. Posting Group");
                                GenJnlLine."Gen. Prod. Posting Group" := '';
                                GenJnlLine.VALIDATE("Gen. Prod. Posting Group");
                                GenJnlLine."VAT Bus. Posting Group" := '';
                                GenJnlLine.VALIDATE("VAT Bus. Posting Group");
                                GenJnlLine."VAT Prod. Posting Group" := '';
                                GenJnlLine.VALIDATE("VAT Prod. Posting Group");
                                GenJnlLine."Posting Date" := Rec."Surrender Date";
                                GenJnlLine."Document No." := Rec.No;
                                GenJnlLine.Amount := -ImprestDetails."Cash Surrender Amt";
                                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.VALIDATE("Currency Code");
                                // Take care of Currency Factor
                                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                                GenJnlLine.VALIDATE("Currency Factor");
                                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                                GenJnlLine."Bal. Account No." := ImprestDetails."Bank/Petty Cash";
                                GenJnlLine.Description := 'Imprest Surrender by staff';
                                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                                GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                                GenJnlLine."Applies-to ID" := ImprestDetails."Imprest Holder";
                                IF GenJnlLine.Amount <> 0 THEN
                                    GenJnlLine.INSERT;

                            end;
                        UNTIL ImprestDetails.NEXT = 0;
                    end;
                    GenJnlLine.RESET;
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", GenledSetup."Imprest Template");
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", GenledSetup."Imprest Batch");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
                    Rec.Posted := true;
                    Rec."Date Posted" := Today;
                    Rec."Time Posted" := Time;
                    Rec."Posted By" := UserId;
                    Rec.Modify(true);
                    // Tag the Source Imprest Requisition as Surrendered
                    ImprestReq.RESET;
                    ImprestReq.SETRANGE(ImprestReq."No.", Rec."Imprest Issue Doc. No");
                    IF ImprestReq.FIND('-') THEN BEGIN
                        ImprestReq."Surrender Status" := ImprestReq."Surrender Status"::Full;
                        ImprestReq.MODIFY;
                    END;
                end;
            }
        }
    }
    trigger OnInit()
    begin
        ImprestLinesEditable := TRUE;
        "Responsibility CenterEditable" := TRUE;
        "Imprest Issue Doc. NoEditable" := TRUE;
        "Account No.Editable" := TRUE;
        "Surrender DateEditable" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        AccountName := GetCustName(Rec."Account No.");
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // check if the documenent has been added while another one is still pending
        TravAccHeader.Reset();
        TravAccHeader.SetRange(TravAccHeader.Cashier, UserId);
        TravAccHeader.SetRange(TravAccHeader.Status, Rec.Status::Open);
        Rec."User ID" := UserId;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RecordApproved := false;
        // ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        xRec := Rec;
        UpdateControl;
        DimName1 := GetDimensionName(Rec."Global Dimension 1 Code", 1);
        DimName2 := GetDimensionName(Rec."Shortcut Dimension 2 Code", 2);
        AccountName := GetCustName(Rec."Account No.");
        IF Rec.Status = Rec.Status::Approved THEN
            RecordApproved := TRUE;
    end;

    procedure GetCustName(No: Code[20]) Name: Text[100]
    begin
        Name := '';
        IF Cust.GET(No) THEN
            Name := Cust.Name;
        EXIT(Name);

    end;

    procedure UpdateControl()
    begin
        if Rec.Status <> Rec.Status::Open then begin
            "Surrender DateEditable" := FALSE;
            "Account No.Editable" := FALSE;
            "Imprest Issue Doc. NoEditable" := FALSE;
            "Responsibility CenterEditable" := FALSE;
            ImprestLinesEditable := FALSE;
        end else begin
            "Surrender DateEditable" := TRUE;
            "Account No.Editable" := TRUE;
            "Imprest Issue Doc. NoEditable" := TRUE;
            "Responsibility CenterEditable" := TRUE;
            ImprestLinesEditable := TRUE;


        end;
    end;

    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::Open then
            StatusEditable := true
        else
            StatusEditable := false;
    end;

    procedure GetDimensionName(VAR Code: Code[20]; DimNo: Integer) Name: Text[60]
    begin
        // Get the global dimension 1 and 2 from the database
        Name := '';
        GLSetup.RESET;
        GLSetup.GET();
        DimVal.RESET;
        DimVal.SETRANGE(DimVal.Code, Code);
        IF DimNo = 1 THEN BEGIN
            DimVal.SETRANGE(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code");
        END
        ELSE
            IF DimNo = 2 THEN BEGIN
                DimVal.SETRANGE(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
            END;
        IF DimVal.FIND('-') THEN BEGIN
            Name := DimVal.Name;
        END;
    end;

    procedure UpdateforNoActualSpent()
    begin
        Rec.Posted := true;
        Rec.Status := Rec.Status::Posted;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify(true);
        // Tag the Source Imprest Requisition as Surrendered
        ImprestReq.Reset();
        ImprestReq.SetRange(ImprestReq."No.", Rec."Imprest Issue Doc. No");
        if ImprestReq.Find('-') then begin
            ImprestReq."Surrender Status" := ImprestReq."Surrender Status"::Full;
            ImprestReq.Modify(true);
        end;
    end;

    var
        myInt: Integer;
        ImprestLinesEditable: Boolean;
        "Responsibility CenterEditable": Boolean;
        "Imprest Issue Doc. NoEditable": Boolean;
        "Account No.Editable": Boolean;
        "Surrender DateEditable": Boolean;
        AccountName: Text[100];
        Cust: Record Customer;
        StatusEditable: Boolean;
        TravAccHeader: Record "Imprest Surrender Header";
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        DimName1: Text[60];
        DimName2: Text[60];
        Text000: TextConst ENU = 'You have not specified the Actual Amount Spent. This document will only reverse the committment and you will have to receipt the total amount returned.';
        ImprestReq: Record "Imprest Header";
        Text001: TextConst ENU = 'Document Not Posted';
        GenledSetup: Record "Funds User Setup";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        ImprestDetails: Record "Imprest Surrender Lines";
        Txt0001: TextConst ENU = 'Actual Spent and the Cash Receipt Amount should be equal to the amount Issued';
        RecordApproved: Boolean;
        ShowWorkflowStatus: Boolean;
        RECORDID: RecordId;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
}