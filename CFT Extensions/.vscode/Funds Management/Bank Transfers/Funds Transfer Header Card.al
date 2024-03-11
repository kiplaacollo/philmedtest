page 50031 "Funds Transfer Header"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Funds Transfer Header";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Enabled = (not OpenApprovalEntriesExist) and not RecordApproved;
                field("No.";
                Rec."No.")
                {

                }
                field("Pay Mode"; Rec."Pay Mode")
                {

                }
                field(Date; Rec.Date)
                {
                    Caption = 'Transaction Date';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    trigger OnValidate()
                    begin
                        Rec.TestField("Pay Mode");
                    end;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {

                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {

                }
                field("Bank Balance"; Rec."Bank Balance")
                {

                }
                field("Bank Balance(LCY)"; Rec."Bank Balance(LCY)")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    Visible = false;
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {

                }
                field("Amount to Transfer(LCY)"; Rec."Amount to Transfer(LCY)")
                {

                }
                // Total Line Amount
                field("Total Line Amount"; Rec."Total Line Amount")
                {

                }
                field("Total Line Amount(LCY)"; Rec."Total Line Amount(LCY)")
                {

                }
                field("Cheque/Doc. No"; Rec."Cheque/Doc. No")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                }
                field("Time Created"; Rec."Time Created")
                {

                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            group("Funds Transfer Lines")
            {
                part(FundsTransferLines; "Funds Transfer Lines")
                {
                    SubPageLink = "Document No" = field("No.");
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
                PromotedIsBig = true;
                Enabled = (not OpenApprovalEntriesExist) and not RecordApproved;

                trigger OnAction()
                var
                    fundstransferworkflow: Codeunit "Funds Transfer Workflow";
                    RecRef: RecordRef;
                begin
                    Rec.TestField(Date);
                    Rec.TestField("Paying Bank Account");
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.TestField("Pay Mode");
                    CheckRequiredFields();
                    RecRef.GetTable(Rec);
                    if fundstransferworkflow.CheckApprovalsWorkflowEnabled(RecRef) then
                        fundstransferworkflow.OnSendWorkflowForApproval(RecRef);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = all;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = CanCancelApprovalForRecord;
                trigger OnAction()
                var
                    fundstransferworkflow: Codeunit "Funds Transfer Workflow";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    fundstransferworkflow.OnSendWorkflowForApproval(RecRef);
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
                begin
                    DocumentType := DocumentType::"Funds Transfer";
                    ApprovalEntries.SetRecordFilters(Database::"Funds Transfer Header", DocumentType, Rec."No.");
                    ApprovalEntries.Run();
                end;
            }
            action(Post)
            {
                ApplicationArea = all;
                Promoted = true;
                Image = Post;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = RecordApproved;
                trigger OnAction()
                begin
                    // Check Required Fields
                    CheckRequiredFields;
                    Rec.TestField("Posting Date");
                    // Get Setups of the current UserID from Cash Office User Template
                    CashOfficeUserTemplate.Reset();
                    CashOfficeUserTemplate.SetRange(CashOfficeUserTemplate."User ID", UserId);
                    if CashOfficeUserTemplate.Find('-') then begin
                        "Inter Bank Template Name" := CashOfficeUserTemplate."FundsTransfer Template Name";
                        "Inter Bank Journal Batch" := CashOfficeUserTemplate."FundsTransfer Batch Name";
                    end;
                    // Check whether the "Line Amounts" to be Transfered is the same as "Amount to Transfer" in the header
                    Rec.CalcFields("Total Line Amount(LCY)");
                    if Rec."Total Line Amount(LCY)" <> Rec."Amount to Transfer(LCY)" then begin
                        Error(Text001, Rec."Amount to Transfer(LCY)", Rec."Total Line Amount(LCY)");
                    end;
                    // Check if the transaction will lead to a Negative Account Balance in the Paying Account Bank
                    BankAcc.Reset();
                    BankAcc.SetRange(BankAcc."No.", Rec."Bank Account No.");
                    if BankAcc.FindFirst then begin
                        BankAcc.CalcFields(BankAcc.Balance);
                        currBankBalance := BankAcc.Balance - Rec."Amount to Transfer";
                    end;
                    // Clear Users Batch
                    GenJnlLine.Reset();
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
                    GenJnlLine.DeleteAll();
                    // Inserting Amounts of Accounts to be Debited into the Journal (+)
                    IBTLines.Reset();
                    IBTLines.SetRange(IBTLines."Document No", Rec."No.");
                    if IBTLines.Find('-') then begin
                        repeat
                            Insert_IBTLines_to_Journal;
                        until IBTLines.Next() = 0;
                    end;
                    // Insert Amounts of Accounts to "Credit" (-) into the Journal
                    Insert_IBTHead_to_Journal;
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);
                    Rec.Posted := true;
                    Rec.Status := Rec.Status::Posted;
                    rec."Date Posted" := Today;
                    Rec."Time Posted" := Time;
                    Rec."Posted By" := UserId;
                    Rec.Modify(true);
                    // Message('The Journal Has Been Posted Successfully');
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
        Rec."Created By" := UserId;
        Rec."Date Created" := Today;
        Rec."Time Created" := Time;
        Rec.Date := Today;
    end;

    procedure CheckRequiredFields()
    begin
        //Check Lines if Cheque No has been specified
        IBTLines.Reset();
        IBTLines.SetRange(IBTLines."Document No", Rec."No.");
        if IBTLines.Find('-') then begin
            repeat
                IBTLines.TestField(IBTLines."Pay Mode");
                if IBTLines."Pay Mode" = IBTLines."Pay Mode"::Cheque then begin
                    IBTLines.TestField(IBTLines."External Doc No.");
                end;
            until IBTLines.Next = 0;
        end;
        //Check whether the "Line Amounts" to be Transfered is the same as "Amount to Transfer" in the header
        Rec.CalcFields("Total Line Amount");
        Rec.CalcFields("Total Line Amount(LCY)");
        if Rec."Total Line Amount(LCY)" <> Rec."Amount to Transfer(LCY)" then begin
            Error('The [Requested Amount to Transfer in LCY:%1] should be same as the[Total Line Amount in LCY:%2]', Rec."Amount to Transfer(LCY)", Rec."Total Line Amount(LCY)");
        end;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        RecordApproved := false;
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        if Rec.Status = Rec.Status::Approved then
            RecordApproved := true;
    end;

    procedure Insert_IBTLines_to_Journal()
    begin
        // Get Last Line No in Journal
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
        if GenJnlLine.Find('+') then begin
            LineNo := GenJnlLine."Line No." + 1;
        end else begin
            LineNo := 1000;
        end;
        // Insert Into Journal
        GenJnlLine.Init();
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Journal Template Name" := "Inter Bank Template Name";
        GenJnlLine."Journal Batch Name" := "Inter Bank Journal Batch";
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := IBTLines."Receiving Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format(Rec."No.");
        GenJnlLine."External Document No." := IBTLines."External Doc No.";
        if rec.Description = '' then begin
            GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format(Rec."No.");
        end else begin
            GenJnlLine.Description := Rec.Description;
        end;
        GenJnlLine."Currency Code" := IBTLines."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := IBTLines."Amount to Receive";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine.Insert();
    end;

    procedure Insert_IBTHead_to_Journal()
    begin
        // Get Last Line No in Journal
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Inter Bank Template Name");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Inter Bank Journal Batch");
        if GenJnlLine.Find('+') then begin
            LineNo := GenJnlLine."Line No." + 1;
        end else begin
            LineNo := 1000;
        end;
        GenJnlLine.Init();
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Journal Template Name" := "Inter Bank Template Name";
        GenJnlLine."Journal Batch Name" := "Inter Bank Journal Batch";
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := Rec."Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."External Document No." := Rec."Cheque/Doc. No";
        if rec.Description = '' then begin
            GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format(Rec."No.");

        end else begin
            GenJnlLine.Description := Rec.Description;
        end;
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        GenJnlLine.Amount := -Rec."Amount to Transfer";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine.Insert();

    end;

    var
        myInt: Integer;
        OpenApprovalEntriesExistCurrUser: Boolean;
        IBTLines: Record "Funds Transfer Line";
        CashOfficeUserTemplate: Record "Funds User Setup";
        "Inter Bank Template Name": Code[50];
        "Inter Bank Journal Batch": Code[50];
        Text001: TextConst ENU = 'The [Requested Amount to Transfer in LCY: %1] should be same as the [Total Line Amount in LCY: %2]';
        BankAcc: Record "Bank Account";
        currBankBalance: Decimal;
        RecordApproved: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RECORDID: RecordId;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentType: Option "Blanket Order","Credit Memo","Funds Transfer","Imprest Requisation","Imprest Surrender",Invoice,Order,"Payment Voucher";
        ApprovalEntries: Page "Approval Entries";
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;


}