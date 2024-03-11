codeunit 50000 "Funds Management"
{
    trigger OnRun()
    begin

    end;

    procedure PostPayment("Payment Header": Record "Payments Header"; "Journal Template": Code[20]; "Journal Batch": Code[20])
    begin
        PaymentHeader.TransferFields("Payment Header", true);
        SourceCode := 'PAYMENTJNL';
        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", "Journal Batch");
        if GenJnlLine.FindSet then begin
            GenJnlLine.DeleteAll;
        end;
        // End Delete
        if "Payment Header"."Credit Life Admin Fee" = true then
            FnPostAdminFees("Payment Header", "Journal Template", "Journal Batch");
        LineNo := 1000;
        // Add to Bank(Payment Header)
        PaymentHeader.CalcFields(PaymentHeader."New Net Amount");
        GenJnlLine.Init();
        // Change to journal template name
        GenJnlLine."Journal Template Name" := "Journal Template";
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := "Journal Batch";
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := SourceCode;
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        if CustomerLinesExist(PaymentHeader) then
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
        else
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := PaymentHeader."No.";
        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := PaymentHeader."Bank Account";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");
        GenJnlLine.Amount := -(PaymentHeader."New Net Amount");
        // Credit Amount
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
        GenJnlLine.Description := COPYSTR(PaymentHeader.Payee, 1, 50) + ':' + ' ' + COPYSTR(PaymentHeader."Payment Description", 1, 50);
        GenJnlLine.Validate(GenJnlLine.Description);
        if PaymentHeader."Payment " <> PaymentHeader."Payment "::Cheque then begin
            GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "
        end else begin
            if PaymentHeader."Cheque Type" = PaymentHeader."Cheque Type"::" " then
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check"
            else
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "
        end;
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;
        // End Add to Bank
        // Add Payment Lines
        PaymentLine.Reset();
        PaymentLine.SetRange(PaymentLine."Document No", PaymentHeader."No.");
        PaymentLine.SETFILTER(PaymentLine.Amount, '<>%1', 0);
        if PaymentLine.FindSet() then begin
            repeat
                // Add Line NetAmounts
                LineNo := LineNo + 1;
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := "Journal Template";
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := "Journal Batch";
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := SourceCode;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentLine."Document No";
                if CustomerLinesExist(PaymentHeader) then
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Account Type" := PaymentLine."Account Type";
                GenJnlLine."Account No." := PaymentLine."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");
                GenJnlLine.Amount := PaymentLine."Net Amount";
                // Debit Amount
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Gen. Bus. Posting Group" := PaymentLine."Gen. Bus. Posting Group";
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := PaymentLine."Gen. Prod. Posting Group";
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := PaymentLine."VAT Bus. Posting Group";
                GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := PaymentLine."VAT Prod. Posting Group";
                GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                GenJnlLine.Description := PaymentHeader."Payment Description";
                GenJnlLine.VALIDATE(GenJnlLine.Description);
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;
                // End add Line NetAmounts
                // Add VAT Amounts
                if PaymentLine."VAT Code" <> '' then begin
                    TaxCodes.Reset();
                    TaxCodes.SETRANGE(TaxCodes."Tax Code", PaymentLine."VAT Code");
                    if TaxCodes.FindFirst then begin
                        TaxCodes.TestField(TaxCodes."Account No");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init();
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        if CustomerLinesExist(PaymentHeader) then
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                        else
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Document No." := PaymentLine."Document No";
                        GenJnlLine."Posting Group" := PaymentLine."Default Grouping";
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.VALIDATE("Currency Factor");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -(PaymentLine."VAT Amount");
                        // Credit Amount
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := COPYSTR('VAT:' + FORMAT(PaymentLine."Account Type") + '::' + FORMAT(PaymentLine."Account Name"), 1, 50);
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;
                        // VAT Balancing goes to Vendor
                        LineNo := LineNo + 1;
                        GenJnlLine.Init();
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        IF CustomerLinesExist(PaymentHeader) THEN
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                        else
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Document No." := PaymentLine."Document No";
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.VALIDATE("Currency Factor");
                        GenJnlLine.Amount := PaymentLine."VAT Amount";
                        // Debit Amount
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := COPYSTR('VAT:' + FORMAT(PaymentLine."Account Type") + '::' + FORMAT(PaymentLine."Account Name"), 1, 50);
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;
                    end;

                end;
                // End Add VAT Amounts
                // Add W/TAX Amounts
                if PaymentLine."W/TAX Code" <> '' then begin
                    TaxCodes.Reset();
                    TaxCodes.SetRange(TaxCodes."Tax Code", PaymentLine."W/TAX Code");
                    if TaxCodes.FindFirst() then begin
                        TaxCodes.TestField(TaxCodes."Account No");
                        LineNo := LineNo + 1;
                        GenJnlLine.Init();
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        if CustomerLinesExist(PaymentHeader) then
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                        else
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Document No." := PaymentLine."Document No";
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                        GenJnlLine."Account Type" := TaxCodes."Account Type";
                        GenJnlLine."Account No." := TaxCodes."Account No";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.VALIDATE("Currency Factor");
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine.Amount := -(PaymentLine."W/TAX Amount");
                        // Credit Amount
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := COPYSTR('W/TAX:' + FORMAT(PaymentLine."Account Type") + '::' + FORMAT(PaymentLine."Account Name"), 1, 50);
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;
                        // W/TAX Balancing goes to Vendor
                        LineNo := LineNo + 1;
                        GenJnlLine.Init();
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Source Code" := SourceCode;
                        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                        if CustomerLinesExist(PaymentHeader) then
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                        else
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Document No." := PaymentLine."Document No";
                        GenJnlLine."External Document No." := PaymentHeader."Cheque No";
                        GenJnlLine."Account Type" := PaymentLine."Account Type";
                        GenJnlLine."Account No." := PaymentLine."Account No.";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := PaymentHeader."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        GenJnlLine."Currency Factor" := PaymentHeader."Currency Factor";
                        GenJnlLine.VALIDATE("Currency Factor");
                        // Debit Amount
                        GenJnlLine.Amount := PaymentLine."W/TAX Amount";
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.ValidateShortcutDimCode(3, PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5, PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6, PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7, PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8, PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description := COPYSTR('W/TAX:' + FORMAT(PaymentLine."Account Type") + '::' + FORMAT(PaymentLine."Account Name"), 1, 50);
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                        GenJnlLine."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID" := PaymentLine."Applies-to ID";
                        IF GenJnlLine.Amount <> 0 THEN
                            GenJnlLine.INSERT;
                    end;
                end;
            // End Add W/TAX Amounts
            // Add Retention Amounts
            // End Add Retention Amounts
            until PaymentLine.Next() = 0;
        end;
        // End Add Payment Lines

        Commit();
        // Post the Journal Lines
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", "Journal Template");
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", "Journal Batch");
        // Adjust GenJnlLine Exchange Rate Rounding Balances
        AdjustGenJnl.Run(GenJnlLine);
        // End Adjust GenJnlLine Exchange Rate Rounding Balances
        // Before posting if its computer cheque,print the cheque
        if (PaymentHeader."Payment " = PaymentHeader."Payment "::Cheque) AND
        (PaymentHeader."Cheque Type" = PaymentHeader."Cheque Type"::" ") then begin
            DocPrint.PrintCheck(GenJnlLine);
            CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance", GenJnlLine);
        end;
        // Now Post the Journal Lines
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
        // End Posting
        // Update Document
        BankLedgers.Reset();
        BankLedgers.SetRange(BankLedgers."Document No.", PaymentHeader."No.");
        if BankLedgers.FindFirst() then begin
            PaymentHeader2.Reset();
            PaymentHeader2.SetRange(PaymentHeader2."No.", PaymentHeader."No.");
            if PaymentHeader2.FindFirst() then begin
                PaymentHeader2.Status := PaymentHeader2.Status::Posted;
                PaymentHeader2.Posted := true;
                PaymentHeader2."Posted By" := UserId;
                PaymentHeader2."Date Posted" := Today;
                PaymentHeader2."Time Posted" := Time;
                PaymentHeader2.Modify();
                PaymentLine2.Reset();
                PaymentLine2.SetRange(PaymentLine2."Document No", PaymentHeader2."No.");
                if PaymentLine2.FindSet() then begin
                    repeat
                        PaymentLine2.Status := PaymentLine2.Status::Posted;
                        PaymentLine2.Posted := true;
                        PaymentLine2."Posted By" := UserId;
                        PaymentLine2."Date Posted" := Today;
                        PaymentLine2."Time Posted" := Time;
                        PaymentLine2.Modify();
                    until PaymentLine2.Next() = 0;
                end;
            end;
        end;
    end;

    procedure FnPostAdminFees(PHead: Record "Payments Header"; JTemplate: Code[20]; JBatch: Code[20])
    begin
        ObjGenSetup.Get();
        if PHead."Admin Fees Amount" > 0 then begin
            LineNo := LineNo + 100;
            CFTFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, PHead."No.", LineNo, GenJournalLine."Transaction Type", GenJournalLine."Account Type"::"G/L Account",
    PHead."Admin Fees Account", PHead."Posting Date", PHead."Admin Fees Amount" * -1, PHead."Cheque No", 'Credit Life Admin Fees', GenJournalLine."Account Type"::"G/L Account", ObjGenSetup."Credit Life Account", '', '');
        end;
    end;

    procedure CustomerLinesExist("Payment Header": Record "Payments Header"): Boolean
    begin
        "Payment Line".Reset();
        "Payment Line".SetRange("Payment Line"."Document No", "Payment Header"."No.");
        if "Payment Line".FindFirst() then begin
            if "Payment Line"."Account Type" = "Payment Line"."Account Type"::Customer then begin
                exit(true);
            end else begin
                "Payment Line2".Reset();
                "Payment Line2".SetRange("Payment Line2"."Document No", "Payment Header"."No.");
                "Payment Line2".SetFilter("Payment Line2"."Net Amount", '<%1', 0);
                if "Payment Line2".FindFirst() then
                    exit(true)
                else
                    exit(false)
            end;
        end;
    end;



    var
        myInt: Integer;
        PaymentHeader: Record "Payments Header";
        SourceCode: Code[20];
        GenJnlLine: Record "Gen. Journal Line";
        ObjGenSetup: Record "BO General Setup";
        LineNo: Integer;
        CFTFactory: Codeunit "CFT Factory";
        GenJournalLine: Record "Gen. Journal Line";
        "Payment Line": Record "Payment Line Table";
        "Payment Line2": Record "Payment Line Table";
        PaymentLine: Record "Payment Line Table";
        TaxCodes: Record "Fund Tax Codes";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        DocPrint: Codeunit "Document-Print";
        BankLedgers: Record "Bank Account Ledger Entry";
        PaymentHeader2: Record "Payments Header";
        PaymentLine2: Record "Payment Line Table";
        messages: Record "SMS Messages";

}