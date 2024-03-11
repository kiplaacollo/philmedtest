page 50123 "MPESA Transactions"
{
    //ApplicationArea = All;
    Caption = 'MPESA Transactions';
    PageType = List;
    SourceTable = "MPESA Transaction";
    SourceTableView = SORTING(ID) ORDER(Descending);
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TransTime; Rec.TransTime)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TransID; Rec.TransID)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(BusinessShortCode; Rec.BusinessShortCode)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TransAmount; Rec.TransAmount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("TransactionType"; Rec."TransactionType")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Select Line"; Rec."Select Line")
                {
                    ApplicationArea = All;
                }
                field(MSISDN; Rec.MSISDN)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(FirstName; Rec.FirstName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(MiddleName; Rec.MiddleName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(LastName; Rec.LastName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(DocumentNo; Rec.DocumentNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                /*field("Posted Document No."; "Posted Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }*/
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SelectAll)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Select All Entries';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false; //Temp turn off

                trigger OnAction()
                begin
                    if Rec.FindFirst() then
                        repeat
                            Rec."Select Line" := true;
                            Rec.Modify();
                        until Rec.Next() = 0;
                end;
            }
            action(ClearSelection)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Clear Selection';
                Image = ClearLog;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Rec.FindFirst() then
                        repeat
                            Rec."Select Line" := False;
                            Rec.Modify();
                        until Rec.Next() = 0;
                end;
            }
            action(ConfirmSelection)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Confirm Selection';
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    InsertJournalLines;
                end;
            }

        }
    }
    var
        JnlTemplate: Code[10];
        JnlBatch: Code[10];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        recMPESATransaction: Record "MPESA Transaction";

    trigger OnInit()
    var
        SQLConnection: Codeunit "MPESA SQLConnection";
    begin
        //SQLConnection.Run();
        //GetMPESAEntries;
    end;

    trigger OnOpenPage()
    var
        lvJournalBatches: Record "Gen. Journal Batch";
    begin
        recMPESATransaction.RESET;
        recMPESATransaction.SETRANGE(Posted, 0);
        recMPESATransaction.SETFILTER(DocumentNo, '%1', '');
        recMPESATransaction.SetFilter(ID, '>=%1', 200000);
        IF (JnlBatch <> '') AND (JnlTemplate <> '') THEN BEGIN
            lvJournalBatches.GET(JnlTemplate, JnlBatch);
            if lvJournalBatches."MPESA Shortcode" <> '' then begin
                recMPESATransaction.SetRange(BusinessShortCode, lvJournalBatches."MPESA Shortcode");
            end else begin
                Error('This Batch is not setup for MPESA Integration!');
            end;
        end;
        IF recMPESATransaction.FINDFIRST THEN
            REPEAT
                Rec.Init();
                Rec := recMPESATransaction;
                Rec.INSERT(TRUE);
            UNTIL recMPESATransaction.NEXT = 0;
    end;


    local Procedure GetMPESAEntries()
    var
        lvMPESASQL: Record "MPESA Transactions SQL";
        lvMPESATransaction: Record "MPESA Transaction";
        lvMPESATransaction2: Record "MPESA Transaction";
    begin
        lvMPESASQL.RESET;
        //lvMPESASQL.SETFILTER(Posted, '<>%1', 1);
        lvMPESASQL.SetFilter(ID, '>=%1', 130750);
        IF lvMPESASQL.FINDFIRST THEN
            REPEAT
                lvMPESATransaction2.SETRANGE(TransID, lvMPESASQL.TransID);
                IF NOT lvMPESATransaction2.FINDFIRST THEN BEGIN
                    lvMPESATransaction.INIT;
                    lvMPESATransaction.TRANSFERFIELDS(lvMPESASQL);
                    lvMPESATransaction.TransTime := lvMPESASQL.TransTime - (10800000);
                    lvMPESATransaction.Posted := 0;
                    lvMPESATransaction.DocumentNo := '';
                    lvMPESATransaction.INSERT(TRUE);

                    //Update the Entries
                    lvMPESASQL.Posted := 1;
                    lvMPESASQL.MODIFY;
                END;
            UNTIL lvMPESASQL.NEXT = 0;
    end;

    Procedure SetTemplate(JournalTemplate: Code[10]; JournalBatch: Code[10])
    begin
        JnlBatch := JournalBatch;
        JnlTemplate := JournalTemplate;
    end;

    Local procedure InsertJournalLines()
    var
        lvJnlLine: Record "Gen. Journal Line";
        lvJournalBatches: Record "Gen. Journal Batch";
        lvLineNo: Integer;
        lvMPESATransaction: Record "MPESA Transaction";
        DimensionValue: Record "Dimension Value";
        lvMPESATransaction2: Record "MPESA Transaction";
    Begin
        IF (JnlBatch <> '') AND (JnlTemplate <> '') THEN BEGIN
            lvJnlLine.SETRANGE("Journal Batch Name", JnlBatch);
            lvJnlLine.SETRANGE("Journal Template Name", JnlTemplate);
            IF lvJnlLine.FINDLAST THEN
                lvLineNo := lvJnlLine."Line No." + 10000
            ELSE
                lvLineNo := 10000;
            lvJournalBatches.GET(JnlTemplate, JnlBatch);
            lvJournalBatches.TESTFIELD("No. Series");

            SETRANGE("Select Line", TRUE);
            IF FINDSET THEN
                REPEAT
                    //Check If The Entry is Already Inserted
                    lvMPESATransaction2.RESET;
                    lvMPESATransaction2.GET(ID);
                    IF lvMPESATransaction2.DocumentNo = '' THEN BEGIN //THE Entry Is not Inserted by Another User
                        lvJnlLine.INIT;
                        lvJnlLine.VALIDATE("Journal Template Name", JnlTemplate);
                        lvJnlLine.VALIDATE("Journal Batch Name", JnlBatch);
                        lvJnlLine."Line No." := lvLineNo;
                        lvJnlLine."Document Type" := lvJnlLine."Document Type"::Payment;
                        IF lvJournalBatches."No. Series" <> '' THEN
                            lvJnlLine."Document No." := NoSeriesMgt.GetNextNo(lvJournalBatches."No. Series", TODAY, TRUE);

                        lvJnlLine."Document Date" := DT2DATE(TransTime);
                        lvJnlLine."Posting Date" := DT2DATE(TransTime);
                        lvJnlLine.VALIDATE("Account Type", lvJnlLine."Account Type"::Customer);
                        lvJnlLine.VALIDATE("Account No.", GetCustomerNo(ID));
                        lvJnlLine."Bal. Account Type" := lvJnlLine."Bal. Account Type"::"Bank Account";
                        lvJnlLine.VALIDATE("Bal. Account No.", GetBankAccountNo(ID));
                        lvJnlLine.Description := DELCHR(PADSTR(FirstName + ' ' + MiddleName + ' ' + LastName, 50), '<>');
                        lvJnlLine."External Document No." := TransID;
                        lvJnlLine.VALIDATE(Amount, -TransAmount);
                        lvJnlLine."MPESA Entry" := TRUE;
                        lvJnlLine.INSERT(TRUE);

                        lvLineNo += 10000;
                        lvMPESATransaction.RESET;
                        lvMPESATransaction.GET(ID);
                        lvMPESATransaction.DocumentNo := lvJnlLine."Document No.";
                        lvMPESATransaction.PostingDate := lvJnlLine."Posting Date";
                        lvMPESATransaction.MODIFY;

                    END;//Free Entry for selection
                UNTIL NEXT = 0;
        END;

        CurrPage.CLOSE;
    End;

    LOCAL Procedure GetCustomerNo(TransactioID: Integer): Code[20]
    var

        lvCustomer: Record Customer;
        lvExitCustomerNo: Code[20];
        lvMPESATransaction: Record "MPESA Transaction";
    begin
        lvExitCustomerNo := '';
        lvMPESATransaction.SETRANGE(ID, TransactioID);
        IF lvMPESATransaction.FINDFIRST THEN BEGIN
            IF lvMPESATransaction.MSISDN <> '' THEN BEGIN
                lvCustomer.SETRANGE("MPESA Phone No.", lvMPESATransaction.MSISDN);
                IF lvCustomer.FINDFIRST THEN
                    lvExitCustomerNo := lvCustomer."No.";
            END;

        END;

        EXIT(lvExitCustomerNo);
    end;

    LOCAL Procedure GetBankAccountNo(TransactioID: Integer): Code[20]
    var
        lvCustomer: Record Customer;
        lvExitBankAccountNo: Code[20];
        lvBankAccount: Record "Bank Account";
        lvMPESATransaction: Record "MPESA Transaction";
    begin
        lvExitBankAccountNo := '';
        lvMPESATransaction.SETRANGE(ID, TransactioID);
        IF lvMPESATransaction.FINDFIRST THEN BEGIN
            lvBankAccount.SETRANGE("MPESA Shortcode", lvMPESATransaction.BusinessShortCode);
            IF lvBankAccount.FINDFIRST THEN
                lvExitBankAccountNo := lvBankAccount."No.";
        END;

        EXIT(lvExitBankAccountNo);
    end;
}
