codeunit 50001 "CFT Factory"
{
    procedure FnGetPAYEBudCharge(ChargeCode: Code[10]): Decimal
    begin
        ObjpayeCharges.Reset();
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges."Taxable Amount" * ObjpayeCharges.Percentage / 100);
    end;

    procedure FnPAYERate(ChargeCode: Code[10]): Decimal

    begin
        ObjpayeCharges.Reset();
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges.Percentage / 100);
    end;

    procedure FnCalculatePaye(Chargeable: Decimal) PAYE: Decimal
    begin
        PAYE := 0;
        BAND1 := 0;
        BAND2 := 0;
        BAND3 := 0;
        BAND4 := 0;
        BAND5 := 0;
        if TAXABLEPAY.Find('-') then begin
            repeat
                if Chargeable > 0 then begin
                    case TAXABLEPAY."Tax Band" of
                        '01':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND1 := FnGetPAYEBudCharge('01');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND1 := FnGetPAYEBudCharge('01');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND1 := Chargeable * FnPAYERate('01');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '02':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND2 := FnGetPAYEBudCharge('02');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND2 := FnGetPAYEBudCharge('02');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND2 := Chargeable * FnPAYERate('02');
                                        Chargeable := 0;
                                    end;
                                end;

                            end;
                        '03':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND3 := FnGetPAYEBudCharge('03');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND3 := FnGetPAYEBudCharge('03');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND3 := Chargeable * FnPAYERate('03');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '04':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND4 := FnGetPAYEBudCharge('04');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND4 := FnGetPAYEBudCharge('04');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND4 := Chargeable * FnPAYERate('04');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '05':
                            begin
                                BAND5 := Chargeable * FnPAYERate('05');
                            end;

                    end;

                end;
            until TAXABLEPAY.Next = 0;



        end;
        if (band1 + BAND2 + BAND3 + BAND4 + BAND5 - 1408) > 0 then
            exit(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 - 1408);


    end;

    procedure FnGenerateGeneralJournalLine(JTemplate: Code[20]; JBatch: Code[20]; LineNo: Integer; SourceCode: Code[20]; PostingDate: Date; DocumentNo: Code[20]; ExternalDocNo: Code[20]; AccountType: Option; AccountNo: Code[20]; Amount: Decimal; Description: Text[250]; TransactionType: Option; LoanNo: Code[20]; ActivityCode: Code[50]; BranchCode: Code[50]; loanproduct: Code[20])
    begin
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PostingDate;
        GenJnlLine."Document No." := DocumentNo;
        GenJnlLine."External Document No." := ExternalDocNo;
        GenJnlLine."Account Type" := AccountType;
        GenJnlLine."Account No." := AccountNo;
        // Debit Amount
        GenJnlLine.Amount := Amount;
        // GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        // GenJnlLine."Bal. Account No." := loandisbursement."Paying Bank";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine.Description := Description;
        GenJnlLine.Validate(GenJnlLine.Description);
        GenJnlLine."Transaction Type" := TransactionType;
        GenJnlLine."Loan Number" := LoanNo;
        GenJnlLine."Shortcut Dimension 1 Code" := ActivityCode;
        GenJnlLine."Shortcut Dimension 2 Code" := BranchCode;
        GenJnlLine."Loan Product Code" := loanproduct;
        if Amount <> 0 then
            GenJnlLine.Insert();
    end;

    procedure FnReturnProductType(LoanNo: Code[20]) ProductType: Code[20]
    begin
        Loans.Reset();
        Loans.SetRange(Loans."Loan Number", LoanNo);
        if Loans.Find('-') then begin
            Product := Loans."Loan Product";
        end;
        exit(Product);
    end;

    procedure FnGenerateUnAllocatedGeneralJournalLine(JTemplate: Code[20]; JBatch: Code[20]; LineNo: Integer; SourceCode: Code[20]; PostingDate: Date; DocumentNo: Code[20]; ExternalDocNo: Code[20]; AccountType: Option; AccountNo: Code[20]; Amount: Decimal; Description: Text[250]; TransactionType: Option; LoanNo: Code[20]; ActivityCode: Code[50]; BranchCode: Code[50]; UnAllocatedAccount: Code[50]; loanproduct: Code[20])
    begin
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PostingDate;
        GenJnlLine."Document No." := DocumentNo;
        GenJnlLine."External Document No." := ExternalDocNo;
        GenJnlLine."Account Type" := AccountType;
        GenJnlLine."Account No." := AccountNo;
        GenJnlLine.Amount := Amount;
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine.Description := Description;
        GenJnlLine.Validate(GenJnlLine.Description);
        GenJnlLine."Transaction Type" := TransactionType;
        GenJnlLine."Loan Number" := LoanNo;
        GenJnlLine."Shortcut Dimension 1 Code" := ActivityCode;
        GenJnlLine."Shortcut Dimension 2 Code" := BranchCode;
        GenJnlLine."Unallocated Account No" := UnAllocatedAccount;
        GenJnlLine."Loan Product Code" := loanproduct;
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert();
    end;

    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option ,"Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loans,"Interest Due"; AccountType: Option; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; ExternalDocumentNo: Code[20]; TransactionDescription: Text; BalancingAccountType: Option; BalancingAccountNo: Code[40]; LoanNumber: code[50]; loanProduct: code[50])
    var

    begin
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan Number" := LoanNumber;
        GenJournalLine."Loan Product Code" := loanProduct;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        // GenJournalLine."Shortcut Dimension 1 Code":=DimensionActivity;
        // GenJournalLine."Shortcut Dimension 2 Code":=FnGetUserBranch();
        // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.INSERT;
    end;

    procedure fnsendmessage(DocNo: Code[20]; CellNo: Code[20]; Source: Text; SMS: Text[250])
    begin
        Messages.RESET;
        IF Messages.FIND('+') THEN BEGIN
            iEntryNo := Messages."Entry No";
            iEntryNo := iEntryNo + 1;
        END
        ELSE BEGIN
            iEntryNo := 1;
        END;

        Messages.INIT;
        Messages."Entry No" := iEntryNo;
        Messages."Document No" := DocNo;
        Messages."Date of Entry" := TODAY;
        Messages."Time of Entry" := TIME;
        Messages."Message Source" := Source;
        Messages."Entered By" := USERID;
        Messages.Message := SMS;
        Messages."Mobile Number" := CellNo;
        IF Messages."Mobile Number" <> '' THEN
            Messages.INSERT;
    end;

    procedure CreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: option ,"Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40])
    begin
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        //GenJournalLine."Loan Number":=LoanNumber;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        //GenJournalLine."Shortcut Dimension 2 Code":=FnGetUserBranch();
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.INSERT;
    end;

    procedure FnPostJournals(JTemplate: Code[50]; JBatch: Code[50])
    begin
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", JTemplate);
        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", JBatch);
        IF GenJournalLine.FIND('-') THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);
        COMMIT;
    end;

    var
        myInt: Integer;
        ObjpayeCharges: Record "Tax Bracket Setup";
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        TAXABLEPAY: Record "Tax Bracket Setup";
        GenJnlLine: Record "Gen. Journal Line";
        TransactionType: Option;
        LoanNo: Code[20];
        ActivityCode: Code[50];
        BranchCode: Code[50];
        loandisbursement: Record "Loan Disbursement";
        Loans: Record Loans;
        Product: Code[20];
        UnAllocatedAccount: Code[50];
        GenJournalLine: Record "Gen. Journal Line";
        Messages: Record "SMS Messages";
        iEntryNo: Integer;
}