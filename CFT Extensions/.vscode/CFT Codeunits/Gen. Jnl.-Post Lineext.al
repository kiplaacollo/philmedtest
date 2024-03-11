codeunit 50006 "Gen. Jnl.-Post Lineext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    procedure OnBeforePostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin



        with GenJnlLine do
            case "Account Type" of
                "Account Type"::Member:

                    PostMember(GenJnlLine, Balancing);
            end
        // CreateGLEntriesForTotalAmounts(GenJnlLine, TempInvPostBuf, DummyAdjAmount, SaveEntryNo, MemberPostingGr."Receivables Account", LedgEntryInserted);

    end;

    procedure PostMember(GenJnlLine: Record "Gen. Journal Line"; Balancing: Boolean)
    begin
        WITH GenJnlLine DO BEGIN
            ObjBOApplication.RESET;
            ObjBOApplication.SETRANGE("Member Number", "Account No.");
            IF ObjBOApplication.FIND('-') THEN BEGIN
                IF "Posting Group" = '' THEN BEGIN
                    ObjBOApplication.TESTFIELD("Member Posting Group");
                    "Posting Group" := ObjBOApplication."Member Posting Group";
                END;
                MemberPostingGr.GET("Posting Group");

                TransactionControlAccountExist := FALSE;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Deposit Contribution") THEN BEGIN
                    MemberPostingGr.TESTFIELD(MemberPostingGr."Deposit Contribution");
                    MemberPostingGr."Receivables Account" := '200199';//MemberPostingGr."Deposit Contribution";
                    TransactionControlAccountExist := TRUE;
                END;

                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Share Capital") THEN BEGIN
                    MemberPostingGr.TESTFIELD(MemberPostingGr."Share Capital");
                    MemberPostingGr."Receivables Account" := MemberPostingGr."Share Capital";
                    TransactionControlAccountExist := TRUE;
                END;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Benevolent Fund") THEN BEGIN
                    MemberPostingGr.TESTFIELD(MemberPostingGr."Benevolent Fund");
                    MemberPostingGr."Receivables Account" := MemberPostingGr."Benevolent Fund";
                    TransactionControlAccountExist := TRUE;
                END;

                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Fosa Transaction") THEN BEGIN
                    SavingsProductsSetup.GET("FOSA Product Code");
                    SavingsProductsSetup.TESTFIELD("Product Control GL");
                    MemberPostingGr."Receivables Account" := SavingsProductsSetup."Product Control GL";
                    TransactionControlAccountExist := TRUE;
                END;

                IF ((GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::Loan) OR (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Interest Due")
                  OR (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Interest Paid") OR (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Penalty Charged")
                  OR (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Penalty Paid") OR (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Principal Repayment"))
                  OR (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Interest Suspense Due") OR (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Interest Suspense Paid")
                  OR (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Write Off") THEN BEGIN
                    GenJnlLine.TESTFIELD("Loan Number");
                    LoanProductCode := CFTFactory.FnReturnProductType("Loan Number");
                    ObjLoanProduct.RESET;
                    ObjLoanProduct.GET(LoanProductCode);
                END;


                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::Loan) THEN BEGIN
                    ObjLoanProduct.TESTFIELD(ObjLoanProduct."Loan Book Account");
                    MemberPostingGr."Receivables Account" := ObjLoanProduct."Loan Book Account";
                    TransactionControlAccountExist := TRUE;
                END;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Principal Repayment") THEN BEGIN
                    ObjLoanProduct.TESTFIELD(ObjLoanProduct."Loan Book Account");
                    MemberPostingGr."Receivables Account" := ObjLoanProduct."Loan Book Account";
                    TransactionControlAccountExist := TRUE;
                END;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Interest Due") THEN BEGIN
                    ObjLoanProduct.TESTFIELD(ObjLoanProduct."Interest Receivable Account");
                    MemberPostingGr."Receivables Account" := ObjLoanProduct."Interest Receivable Account";
                    TransactionControlAccountExist := TRUE;
                END;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Interest Paid") THEN BEGIN
                    ObjLoanProduct.TESTFIELD(ObjLoanProduct."Interest Receivable Account");
                    MemberPostingGr."Receivables Account" := ObjLoanProduct."Interest Receivable Account";
                    TransactionControlAccountExist := TRUE;
                END;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Penalty Charged") THEN BEGIN
                    ObjLoanProduct.TESTFIELD(ObjLoanProduct."Penalty Receivable Account");
                    MemberPostingGr."Receivables Account" := ObjLoanProduct."Penalty Receivable Account";
                    TransactionControlAccountExist := TRUE;
                END;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Penalty Paid") THEN BEGIN
                    ObjLoanProduct.TESTFIELD(ObjLoanProduct."Penalty Receivable Account");
                    MemberPostingGr."Receivables Account" := ObjLoanProduct."Penalty Receivable Account";
                    TransactionControlAccountExist := TRUE;
                END;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Interest Suspense Due") THEN BEGIN
                    ObjLoanProduct.TESTFIELD(ObjLoanProduct."Interest Receivable Suspense");
                    MemberPostingGr."Receivables Account" := ObjLoanProduct."Interest Receivable Suspense";
                    TransactionControlAccountExist := TRUE;
                END;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Interest Suspense Paid") THEN BEGIN
                    ObjLoanProduct.TESTFIELD(ObjLoanProduct."Interest Receivable Suspense");
                    MemberPostingGr."Receivables Account" := ObjLoanProduct."Interest Receivable Suspense";
                    TransactionControlAccountExist := TRUE;
                END;
                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"Write Off") THEN BEGIN
                    ObjLoanProduct.TESTFIELD(ObjLoanProduct."Loan Book Account");
                    MemberPostingGr."Receivables Account" := ObjLoanProduct."Loan Book Account";
                    TransactionControlAccountExist := TRUE;
                END;

                IF (GenJnlLine."Transaction Type" = GenJnlLine."Transaction Type"::"UnAllocated Funds") THEN BEGIN
                    MemberPostingGr.TESTFIELD(MemberPostingGr."UnAllocated Funds");
                    MemberPostingGr."Receivables Account" := MemberPostingGr."UnAllocated Funds";
                    TransactionControlAccountExist := TRUE;
                END;

                IF NOT TransactionControlAccountExist THEN
                    ERROR('Missing a Control Account for %1', "Account No.");

                DtldBOLedgEntry.LOCKTABLE;
                BOLedgerEntry.LOCKTABLE;

                InitBOLedgerEntry(GenJnlLine, BOLedgerEntry);

                TempDtldCVLedgEntryBuf.DELETEALL;
                TempDtldCVLedgEntryBuf.INIT;
                TempDtldCVLedgEntryBuf.CopyFromGenJnlLine(GenJnlLine);
                TempDtldCVLedgEntryBuf."CV Ledger Entry No." := BOLedgerEntry."Entry No.";
                CVLedgEntryBuf.CopyFromBOLedgEntry(BOLedgerEntry);
                TempDtldCVLedgEntryBuf.InsertDtldCVLedgEntry(TempDtldCVLedgEntryBuf, CVLedgEntryBuf, TRUE);
                CVLedgEntryBuf.Open := CVLedgEntryBuf."Remaining Amount" <> 0;
                CVLedgEntryBuf.Positive := CVLedgEntryBuf."Remaining Amount" > 0;

                // Post application
                ApplyBOLedgEntry(CVLedgEntryBuf, TempDtldCVLedgEntryBuf, GenJnlLine, ObjBOApplication);

                // Post vendor entry
                BOLedgerEntry.CopyFromCVLedgEntryBuffer(CVLedgEntryBuf);
                BOLedgerEntry."Amount to Apply" := 0;
                BOLedgerEntry."Applies-to Doc. No" := '';
                BOLedgerEntry."Loan Number" := GenJnlLine."Loan Number";
                BOLedgerEntry."FOSA Product Code" := GenJnlLine."FOSA Product Code";
                BOLedgerEntry."Transaction Type" := GenJnlLine."Transaction Type";
                BOLedgerEntry.VALIDATE("Transaction Type");
                BOLedgerEntry.INSERT(TRUE);

                // Post detailed BO Ledger entries
                DtldLedgEntryInserted := PostDtldBOLedgEntries(GenJnlLine, TempDtldCVLedgEntryBuf, MemberPostingGr, TRUE);

                // Posting GL Entry
                IF DtldLedgEntryInserted THEN
                    IF IsTempGLEntryBufEmpty THEN
                        DtldBOLedgEntry.SetZeroTransNo(NextTransactionNo);

                OnMoveGenJournalLine(BOLedgerEntry.RECORDID);
            END;
        END;

    end;

    procedure InitBOLedgerEntry(GenJnlLine: Record "Gen. Journal Line"; VAR BOLedgerEntry: Record "BO Ledger Entry")
    begin
        BOLedgerEntry.INIT;
        BOLedgerEntry.CopyFromGenJnlLine(GenJnlLine);
        BOLedgerEntry."Entry No." := NextEntryNo;
        BOLedgerEntry."Transaction No." := NextTransactionNo;
    end;

    procedure ApplyBOLedgEntry(VAR NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; VAR DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line"; BOApplication: Record "BO Accounts")
    begin
        IF NewCVLedgEntryBuf."Amount to Apply" = 0 THEN
            EXIT;

        AllApplied := TRUE;
        IF (GenJnlLine."Applies-to Doc. No." = '') AND (GenJnlLine."Applies-to ID" = '') AND
           NOT
           ((BOApplication."Application Method" = BOApplication."Application Method"::Manual) AND
            GenJnlLine."Allow Application")
        THEN
            EXIT;

        PmtTolAmtToBeApplied := 0;
        NewCVLedgEntryBuf2 := NewCVLedgEntryBuf;

        ApplyingDate := GenJnlLine."Posting Date";

        IF NOT PrepareTempBOLedgEntry(GenJnlLine, NewCVLedgEntryBuf, TempOldBOLedgEntry, BOApplication, ApplyingDate) THEN
            EXIT;

        GenJnlLine."Posting Date" := ApplyingDate;

        // Apply the new entry (Payment) to the old entries one at a time
        REPEAT
            TempOldBOLedgEntry.CALCFIELDS(
              Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)",
              "Original Amount", "Original Amt. (LCY)");
            OldCVLedgEntryBuf.CopyFromBOLedgEntry(TempOldBOLedgEntry);
            TempOldBOLedgEntry.COPYFILTER(Positive, OldCVLedgEntryBuf.Positive);

            GenJnlPostLine.PostApply(
              GenJnlLine, DtldCVLedgEntryBuf, OldCVLedgEntryBuf, NewCVLedgEntryBuf, NewCVLedgEntryBuf2,
              TRUE, AllApplied, AppliedAmount, PmtTolAmtToBeApplied);

            // Update the Old Entry
            TempOldBOLedgEntry.CopyFromCVLedgEntryBuffer(OldCVLedgEntryBuf);
            OldBOLedgEntry := TempOldBOLedgEntry;
            OldBOLedgEntry."Applies-to ID" := '';
            OldBOLedgEntry."Amount to Apply" := 0;
            OldBOLedgEntry.MODIFY;

            TempOldBOLedgEntry.DELETE;

            // Find the next old entry to apply to the new entry
            IF GenJnlLine."Applies-to Doc. No." <> '' THEN
                Completed := TRUE
            ELSE
                IF TempOldBOLedgEntry.GETFILTER(Positive) <> '' THEN
                    IF TempOldBOLedgEntry.NEXT = 1 THEN
                        Completed := FALSE
                    ELSE BEGIN
                        TempOldBOLedgEntry.SETRANGE(Positive);
                        TempOldBOLedgEntry.FIND('-');
                        TempOldBOLedgEntry.CALCFIELDS("Remaining Amount");
                        Completed := TempOldBOLedgEntry."Remaining Amount" * NewCVLedgEntryBuf."Remaining Amount" >= 0;
                    END
                ELSE
                    IF NewCVLedgEntryBuf.Open THEN
                        Completed := TempOldBOLedgEntry.NEXT = 0
                    ELSE
                        Completed := TRUE;
        UNTIL Completed;

        DtldCVLedgEntryBuf.SETCURRENTKEY("CV Ledger Entry No.", "Entry Type");
        DtldCVLedgEntryBuf.SETRANGE("CV Ledger Entry No.", NewCVLedgEntryBuf."Entry No.");
        DtldCVLedgEntryBuf.SETRANGE(
          "Entry Type",
          DtldCVLedgEntryBuf."Entry Type"::Application);
        DtldCVLedgEntryBuf.CALCSUMS("Amount (LCY)", Amount);

        NewCVLedgEntryBuf."Applies-to ID" := '';
        NewCVLedgEntryBuf."Amount to Apply" := 0;
    end;

    procedure PrepareTempBOLedgEntry(GenJnlLine: Record "Gen. Journal Line"; VAR
                                                                                 NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";

    VAR
        TempOldBOLedgEntry: Record "BO Ledger Entry";
        BOApplication: Record "BO Accounts";

    VAR
        ApplyingDate: Date): Boolean
    begin
        if GenJnlLine."Applies-to Doc. No." <> '' then begin
            // Find The Entry to be applied to
            OldBOLedgEntry.Reset();
            OldBOLedgEntry.SetCurrentKey("Document No.");
            OldBOLedgEntry.SetRange("Document Type", GenJnlLine."Applies-to Doc. Type");
            OldBOLedgEntry.SetRange("Document No.", GenJnlLine."Applies-to Doc. No.");
            OldBOLedgEntry.SetRange("BO No", NewCVLedgEntryBuf."CV No.");
            OldBOLedgEntry.SetRange(Open, true);
            OldBOLedgEntry.FindFirst();
            OldBOLedgEntry.TestField(Positive, not NewCVLedgEntryBuf.Positive);
            if OldBOLedgEntry."Posting Date" > ApplyingDate then
                ApplyingDate := OldBOLedgEntry."Posting Date";
            TempOldBOLedgEntry := OldBOLedgEntry;
            TempOldBOLedgEntry.Insert();
        end else begin
            // Find the first old entry which the new entry (Payment) should apply to
            OldBOLedgEntry.Reset();
            OldBOLedgEntry.SetCurrentKey("BO No", "Applies-to ID", Open, Positive);
            TempOldBOLedgEntry.SetCurrentKey("BO No", "Applies-to ID", Open, Positive);
            OldBOLedgEntry.SetRange("BO No", NewCVLedgEntryBuf."CV No.");
            OldBOLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
            OldBOLedgEntry.SetRange(Open, true);
            OldBOLedgEntry.SetFilter("Entry No.", '<>%1', NewCVLedgEntryBuf."Entry No.");
            if not (BOApplication."Application Method" = BOApplication."Application Method"::Manual) then
                OldBOLedgEntry.SETFILTER("Amount to Apply", '<>%1', 0);
            IF BOApplication."Application Method" = BOApplication."Application Method"::Manual THEN
                OldBOLedgEntry.SETFILTER("Posting Date", '..%1', GenJnlLine."Posting Date");
            OldBOLedgEntry.SETRANGE("Currency Code", NewCVLedgEntryBuf."Currency Code");
            IF OldBOLedgEntry.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    IF (OldBOLedgEntry."Posting Date" > ApplyingDate) AND (OldBOLedgEntry."Applies-to ID" <> '') THEN
                        ApplyingDate := OldBOLedgEntry."Posting Date";
                    TempOldBOLedgEntry := OldBOLedgEntry;
                    TempOldBOLedgEntry.INSERT;
                UNTIL OldBOLedgEntry.NEXT = 0;
            TempOldBOLedgEntry.SETRANGE(Positive, NewCVLedgEntryBuf."Remaining Amount" > 0);

            IF TempOldBOLedgEntry.FIND('-') THEN BEGIN
                RemainingAmount := NewCVLedgEntryBuf."Remaining Amount";
                TempOldBOLedgEntry.SETRANGE(Positive);
                TempOldBOLedgEntry.FIND('-');
                REPEAT
                    TempOldBOLedgEntry.CALCFIELDS("Remaining Amount");
                    RemainingAmount += TempOldBOLedgEntry."Remaining Amount";
                UNTIL TempOldBOLedgEntry.NEXT = 0;
                TempOldBOLedgEntry.SETRANGE(Positive, RemainingAmount < 0);
            END else
                TempOldBOLedgEntry.SETRANGE(Positive);
            EXIT(TempOldBOLedgEntry.FIND('-'));
        end;
        exit(true);
    end;

    procedure PostDtldBOLedgEntries(GenJnlLine: Record "Gen. Journal Line"; VAR DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; MemberPostingGr: Record "Customer Posting Group"; LedgEntryInserted: Boolean) DtldLedgEntryInserted: Boolean
    begin
        if GenJnlLine."Account Type" <> GenJnlLine."Account Type"::Member then
            exit;
        if DtldBOLedgEntry.FindLast() then
            DtldBOLedgEntryNoOffset := DtldBOLedgEntry."Entry No."
        else
            DtldBOLedgEntryNoOffset := 0;
        DtldCVLedgEntryBuf.Reset();
        if DtldCVLedgEntryBuf.FindSet then begin
            if LedgEntryInserted then begin
                SaveEntryNo := NextEntryNo;
                NextEntryNo := NextEntryNo + 1;
            end;
            repeat
                InsertDtldBOLedgEntry(GenJnlLine, DtldCVLedgEntryBuf, DtldBOLedgEntry, DtldBOLedgEntryNoOffset);
                GenJnlPostLine.UpdateTotalAmounts(TempDimPostingBuffer, GenJnlLine."Dimension Set ID", DtldCVLedgEntryBuf);
            until DtldCVLedgEntryBuf.Next = 0;
        end;
        // CREATEGLENTRIESFORTOTALAMOUNTS
        CreateGLEntriesForTotalAmounts(GenJnlLine, TempInvPostBuf, DummyAdjAmount, SaveEntryNo, MemberPostingGr."Receivables Account", LedgEntryInserted);
        DtldLedgEntryInserted := not DtldCVLedgEntryBuf.IsEmpty;
        DtldCVLedgEntryBuf.DeleteAll();
    end;

    procedure InsertDtldBOLedgEntry(GenJnlLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; VAR DtldBOLedgEntry: Record "Detailed BO Ledger Entry"; Offset: Integer)
    begin
        WITH DtldBOLedgEntry DO BEGIN
            INIT;
            TRANSFERFIELDS(DtldCVLedgEntryBuf);
            "Entry No." := Offset + DtldCVLedgEntryBuf."Entry No.";
            "Journal Batch Name" := GenJnlLine."Journal Batch Name";
            "Reason Code" := GenJnlLine."Reason Code";
            "Source Code" := GenJnlLine."Source Code";
            "Transaction Type" := GenJnlLine."Transaction Type";
            VALIDATE("Transaction Type");
            "Loan Product Code" := GenJnlLine."Loan Product Code";
            "Loan Number" := GenJnlLine."Loan Number";
            "FOSA Product Code" := GenJnlLine."FOSA Product Code";
            "Transaction No." := NextTransactionNo;
            "UnAllocated Account No" := GenJnlLine."Unallocated Account No";
            UpdateDebitCredit(GenJnlLine.Correction);
            INSERT(TRUE);
        END;
    end;

    procedure CreateGLEntriesForTotalAmounts(GenJnlLine: Record "Gen. Journal Line"; VAR InvPostBuf: Record "Invoice Post. Buffer"; AdjAmountBuf: ARRAY[4] OF Decimal; SavedEntryNo: Integer; GLAccNo: Code[20]; LedgEntryInserted: Boolean)
    begin
        GLEntryInserted := false;
        with InvPostBuf do begin
            Reset();
            if FindSet() then
                repeat
                    IF (Amount <> 0) OR ("Amount (ACY)" <> 0) AND (AddCurrencyCode <> '') THEN BEGIN
                        DimMgt.UpdateGenJnlLineDim(GenJnlLine, "Dimension Set ID");
                        CreateGLEntryForTotalAmounts(GenJnlLine, Amount, "Amount (ACY)", AdjAmountBuf, SavedEntryNo, GLAccNo);
                        GLEntryInserted := TRUE;
                    END;
                UNTIL NEXT = 0;
        end;
        IF NOT GLEntryInserted AND LedgEntryInserted THEN
            CreateGLEntryForTotalAmounts(GenJnlLine, 0, 0, AdjAmountBuf, SavedEntryNo, GLAccNo);
    end;

    procedure CreateGLEntryForTotalAmounts(GenJnlLine: Record "Gen. Journal Line"; Amount: Decimal; AmountACY: Decimal; AdjAmountBuf: ARRAY[4] OF Decimal; VAR SavedEntryNo: Integer; GLAccNo: Code[20])
    begin
        HandleDtldAdjustment(GenJnlLine, GLEntry, AdjAmountBuf, Amount, AmountACY, GLAccNo);
        GLEntry."Bal. Account Type" := GenJnlLine."Bal. Account Type";
        GLEntry."Bal. Account No." := GenJnlLine."Bal. Account No.";
        UpdateGLEntryNo(GLEntry."Entry No.", SavedEntryNo);
        GenJnlPostLine.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    end;

    procedure HandleDtldAdjustment(GenJnlLine: Record "Gen. Journal Line"; VAR GLEntry: Record "G/L Entry"; AdjAmount: ARRAY[4] OF Decimal; TotalAmountLCY: Decimal; TotalAmountAddCurr: Decimal; GLAccNo: Code[20])
    begin
        IF NOT PostDtldAdjustment(
             GenJnlLine, GLEntry, AdjAmount,
             TotalAmountLCY, TotalAmountAddCurr, GLAccNo,
             GetAdjAmountOffset(TotalAmountLCY, TotalAmountAddCurr))
        THEN
            InitGLEntry(GenJnlLine, GLEntry, GLAccNo, TotalAmountLCY, TotalAmountAddCurr, TRUE, TRUE);
    end;

    procedure UpdateGLEntryNo(VAR GLEntryNo: Integer; VAR SavedEntryNo: Integer)
    begin
        IF SavedEntryNo <> 0 THEN BEGIN
            GLEntryNo := SavedEntryNo;
            NextEntryNo := NextEntryNo - 1;
            SavedEntryNo := 0;
        END;
    end;

    procedure PostDtldAdjustment(GenJnlLine: Record "Gen. Journal Line"; VAR GLEntry: Record "G/L Entry"; AdjAmount: ARRAY[4] OF Decimal; TotalAmountLCY: Decimal; TotalAmountAddCurr: Decimal; GLAcc: Code[20]; ArrayIndex: Integer): Boolean
    begin
        IF (GenJnlLine."Bal. Account No." <> '') AND
           ((AdjAmount[ArrayIndex] <> 0) OR (AdjAmount[ArrayIndex + 1] <> 0)) AND
           ((TotalAmountLCY + AdjAmount[ArrayIndex] <> 0) OR (TotalAmountAddCurr + AdjAmount[ArrayIndex + 1] <> 0))
        THEN BEGIN
            GenJnlPostLine.CreateGLEntryBalAcc(
              GenJnlLine, GLAcc, -AdjAmount[ArrayIndex], -AdjAmount[ArrayIndex + 1],
              GenJnlLine."Bal. Account Type", GenJnlLine."Bal. Account No.");
            InitGLEntry(GenJnlLine, GLEntry,
              GLAcc, TotalAmountLCY + AdjAmount[ArrayIndex],
              TotalAmountAddCurr + AdjAmount[ArrayIndex + 1], TRUE, TRUE);
            AdjAmount[ArrayIndex] := 0;
            AdjAmount[ArrayIndex + 1] := 0;
            EXIT(TRUE);
        END;

        EXIT(FALSE);
    end;

    procedure GetAdjAmountOffset(Amount: Decimal; AmountACY: Decimal): Integer
    begin
        IF (Amount > 0) OR (Amount = 0) AND (AmountACY > 0) THEN
            EXIT(1);
        EXIT(3);
    end;

    procedure InitGLEntry(GenJnlLine: Record "Gen. Journal Line"; VAR GLEntry: Record "G/L Entry"; GLAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmountAddCurr: Boolean; SystemCreatedEntry: Boolean)
    begin
        IF GLAccNo <> '' THEN BEGIN
            GLAcc.GET(GLAccNo);
            GLAcc.TESTFIELD(Blocked, FALSE);
            GLAcc.TESTFIELD("Account Type", GLAcc."Account Type"::Posting);

            // Check the Value Posting field on the G/L Account if it is not checked already in Codeunit 11
            IF (NOT
                ((GLAccNo = GenJnlLine."Account No.") AND
                 (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account")) OR
                ((GLAccNo = GenJnlLine."Bal. Account No.") AND
                 (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"G/L Account"))) AND
               NOT FADimAlreadyChecked
            THEN
                CheckGLAccDimError(GenJnlLine, GLAccNo);
        END;

        GLEntry.INIT;
        GLEntry.CopyFromGenJnlLine(GenJnlLine);
        GLEntry."Entry No." := NextEntryNo;
        GLEntry."Transaction No." := NextTransactionNo;
        GLEntry."G/L Account No." := GLAccNo;
        GLEntry."System-Created Entry" := SystemCreatedEntry;
        GLEntry.Amount := Amount;
        GLEntry."Additional-Currency Amount" :=
          GLCalcAddCurrency(Amount, AmountAddCurr, GLEntry."Additional-Currency Amount", UseAmountAddCurr, GenJnlLine);
    end;

    // procedure CreateGLEntryBalAcc(GenJnlLine: Record "Gen. Journal Line"; AccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; BalAccType: Option; BalAccNo: Code[20])
    // begin
    //     InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, AmountAddCurr, TRUE, TRUE);
    //     GLEntry."Bal. Account Type" := BalAccType;
    //     GLEntry."Bal. Account No." := BalAccNo;
    //     GenJnlPostLine.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    //     GenJnlLine.OnMoveGenJournalLine(GLEntry.RECORDID);

    // end;

    procedure CheckGLAccDimError(GenJnlLine: Record "Gen. Journal Line"; GLAccNo: Code[20])
    begin
        IF (GenJnlLine.Amount = 0) AND (GenJnlLine."Amount (LCY)" = 0) THEN
            EXIT;

        TableID[1] := DATABASE::"G/L Account";
        AccNo[1] := GLAccNo;
        IF DimMgt.CheckDimValuePosting(TableID, AccNo, GenJnlLine."Dimension Set ID") THEN
            EXIT;

        IF GenJnlLine."Line No." <> 0 THEN
            ERROR(
              DimensionUsedErr,
              GenJnlLine.TABLECAPTION, GenJnlLine."Journal Template Name",
              GenJnlLine."Journal Batch Name", GenJnlLine."Line No.",
              DimMgt.GetDimValuePostingErr);

        ERROR(DimMgt.GetDimValuePostingErr);

    end;

    procedure GLCalcAddCurrency(Amount: Decimal; AddCurrAmount: Decimal; OldAddCurrAmount: Decimal; UseAddCurrAmount: Boolean; GenJnlLine: Record "Gen. Journal Line"): Decimal
    begin
        IF (AddCurrencyCode <> '') AND
           (GenJnlLine."Additional-Currency Posting" = GenJnlLine."Additional-Currency Posting"::None)
        THEN BEGIN
            IF (GenJnlLine."Source Currency Code" = AddCurrencyCode) AND UseAddCurrAmount THEN
                EXIT(AddCurrAmount);

            EXIT(ExchangeAmtLCYToFCY2(Amount));
        END;
        EXIT(OldAddCurrAmount);
    end;

    procedure ExchangeAmtLCYToFCY2(Amount: Decimal): Decimal
    begin
        IF UseCurrFactorOnly THEN
            EXIT(
              ROUND(
                CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(Amount, CurrencyFactor),
                AddCurrency."Amount Rounding Precision"));
        EXIT(
          ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              CurrencyDate, AddCurrencyCode, Amount, CurrencyFactor),
            AddCurrency."Amount Rounding Precision"));
    end;

    var
        myInt: Integer;
        ObjBOApplication: Record "BO Accounts";
        MemberPostingGr: Record "Customer Posting Group";
        TransactionControlAccountExist: Boolean;
        SavingsProductsSetup: Record "Savings Products Setup";
        LoanProductCode: Code[100];
        CFTFactory: Codeunit "CFT Factory";
        ObjLoanProduct: Record "Loan Products";
        DtldBOLedgEntry: Record "Detailed BO Ledger Entry";
        BOLedgerEntry: Record "BO Ledger Entry";
        NextEntryNo: Integer;
        NextTransactionNo: Integer;
        TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer";
        CVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        AllApplied: Boolean;
        PmtTolAmtToBeApplied: Decimal;
        NewCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
        ApplyingDate: Date;
        OldBOLedgEntry: Record "BO Ledger Entry";
        RemainingAmount: Decimal;
        TempOldBOLedgEntry: Record "BO Ledger Entry";
        OldCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        AppliedAmount: Decimal;
        Completed: boolean;
        DtldLedgEntryInserted: Boolean;
        DtldBOLedgEntryNoOffset: Integer;
        SaveEntryNo: Integer;
        TempInvPostBuf: Record "Invoice Post. Buffer";
        TempDimPostingBuffer: Record "Dimension Posting Buffer";
        IsTempGLEntryBufEmpty: Boolean;
        Balancing: Boolean;
        DummyAdjAmount: ARRAY[4] OF Decimal;
        LedgEntryInserted: Boolean;
        GLEntryInserted: Boolean;
        AddCurrencyCode: Code[10];
        DimMgt: Codeunit DimensionManagement;
        GLEntry: Record "G/L Entry";
        GLAcc: Record "G/L Account";
        FADimAlreadyChecked: Boolean;
        DimensionUsedErr: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5.', Comment = '%1 - table caption, %2 - template name, %3 - batch name, %4 - line no., %5 - error message';
        // ExchangeAmtLCYToFCY2: Decimal;
        UseCurrFactorOnly: Boolean;
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyDate: Date;
        AddCurrency: Record Currency;
        CurrencyFactor: Decimal;
        TableID: array[10] of Integer;
        AccNo: array[10] of Code[20];
}