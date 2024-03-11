report 50136 "Generate and Post MPESA Entry"
{
    ApplicationArea = All;
    Caption = 'Generate and Post MPESA Entry';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(MPESATransactions; "MPESA Transaction")
        {
            DataItemTableView = sorting(ID) where(ID = filter(>= 1303489));

            trigger OnAfterGetRecord()
            begin
                InsertJournalLines(MPESATransactions);
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }



    var
        SalesSetup: Record "Sales & Receivables Setup";
        JnlTemplate: Code[20];
        JnlBatch: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CustomerLedgerEntry: Record "Cust. Ledger Entry";

    trigger OnPreReport()
    var
        SQLConnection: Codeunit "MPESA SQLConnection";
    begin
        SalesSetup.GET;
        JnlTemplate := SalesSetup."MPESA Auto Journal Template";
        JnlBatch := SalesSetup."MPESA Auto Journal Batch";

        SQLConnection.Run();
        GetMPESAEntries;
        Commit();
    end;

    trigger OnPostReport()
    begin
        //Post the Generated Lines
        PostJournalLine;

    end;

    local Procedure GetMPESAEntries()
    var
        lvMPESASQL: Record "MPESA Transactions SQL";
        lvMPESATransaction: Record "MPESA Transaction";
        lvMPESATransaction2: Record "MPESA Transaction";
    begin
        lvMPESASQL.RESET;
        lvMPESASQL.SETFILTER(Posted, '%1', 0);
        lvMPESASQL.SetFilter(ID, '1303489..');
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

    Local procedure InsertJournalLines(recMPESATransaction: Record "MPESA Transaction")
    var
        lvJnlLine: Record "Gen. Journal Line";
        lvJournalBatches: Record "Gen. Journal Batch";
        lvLineNo: Integer;
        lvMPESATransaction: Record "MPESA Transaction";
        DimensionValue: Record "Dimension Value";
        lvMPESATransaction2: Record "MPESA Transaction";
    Begin
        with recMPESATransaction do begin
            IF (JnlBatch <> '') AND (JnlTemplate <> '') THEN BEGIN
                lvJnlLine.SETRANGE("Journal Batch Name", JnlBatch);
                lvJnlLine.SETRANGE("Journal Template Name", JnlTemplate);
                IF lvJnlLine.FINDLAST THEN
                    lvLineNo := lvJnlLine."Line No." + 10000
                ELSE
                    lvLineNo := 10000;
                lvJournalBatches.GET(JnlTemplate, JnlBatch);
                lvJournalBatches.TESTFIELD("No. Series");

                //Check If The Entry is Already Inserted
                lvMPESATransaction2.RESET;
                lvMPESATransaction2.GET(ID);
                IF (lvMPESATransaction2.DocumentNo = '') AND (GetCustomerNo(ID) <> '') AND (GetBankAccountNo(ID) <> '') THEN BEGIN //THE Entry Is not Inserted by Another User
                    lvJnlLine.INIT;
                    lvJnlLine.VALIDATE("Journal Template Name", JnlTemplate);
                    lvJnlLine.VALIDATE("Journal Batch Name", JnlBatch);
                    lvJnlLine."Line No." := lvLineNo;
                    lvJnlLine."Document Type" := lvJnlLine."Document Type"::Payment;
                    IF lvJournalBatches."No. Series" <> '' THEN
                        lvJnlLine."Document No." := NoSeriesMgt.GetNextNo(lvJournalBatches."No. Series", TODAY, FALSE);

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
                    lvMPESATransaction.Posted := 1;
                    lvMPESATransaction.MODIFY;

                END;//Free Entry for selection

            END;

        end;
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
                IF lvCustomer.FINDFIRST then begin
                    lvExitCustomerNo := lvCustomer."No.";
                    //Unblock for posting if blocked for all
                    if lvCustomer.Blocked = lvCustomer.Blocked::All then begin
                        lvCustomer.Blocked := lvCustomer.Blocked::Invoice;
                        lvCustomer.Modify();
                    end;
                    //Fill in the Customer Posting Group if Blank
                    if lvCustomer."Customer Posting Group" = '' then begin
                        lvCustomer."Customer Posting Group" := 'TRADE';
                        lvCustomer.Modify();
                    end;
                end;
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

    LOCAL Procedure PostJournalLine()
    var
        lvJnlLine: Record "Gen. Journal Line";
        GeneralJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
    begin
        //post automatically
        lvJnlLine.SETRANGE("Journal Template Name", JnlTemplate);
        lvJnlLine.SETRANGE("Journal Batch Name", JnlBatch);
        IF lvJnlLine.FINDSET THEN
            GeneralJnlPostBatch.RUN(lvJnlLine);
    end;
}