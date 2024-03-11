page 50025 "Receipt Header Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Receipt Header";
    SourceTableView = where(Status = filter(New));
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                }
                field("Document Type"; Rec."Document Type")
                {

                }
                field(Date; Rec.Date)
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Bank Code"; Rec."Bank Code")
                {

                }
                field("Bank Name"; Rec."Bank Name")
                {

                }
                field("Bank Balance"; Rec."Bank Balance")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Currency Factor"; Rec."Currency Factor")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field("Amount Received"; Rec."Amount Received")
                {

                }
                field("Amount Received(LCY)"; Rec."Amount Received(LCY)")
                {

                }
                field("New Total Amount"; Rec."New Total Amount")
                {
                    Caption = 'Total Amount';
                }
                field(Status; Rec.Status)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Received From"; Rec."Received From")
                {

                }
                field("User ID"; Rec."User ID")
                {

                }
                field("New Total Amount (LCY)"; Rec."New Total Amount (LCY)")
                {
                    Caption = 'Total Amount(LCY)';
                }
            }
            group("Receipt Line")
            {
                part(Receiptline; "Receipt Line")
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
            action(Post)
            {
                ApplicationArea = All;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    // Check Post Dated
                    if CheckPostDated() then
                        Error('One of the Receipt Lines is Post Dated');
                    // Post the transaction into the database
                    PerformPost();
                end;
            }
            action("Post & Print")
            {
                ApplicationArea = all;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    // Check Post Dated
                    if CheckPostDated() then
                        Error('One of the Receipt Lines is Post Dated');
                    // Post the transaction into the database
                    PerformPost();
                end;
            }
        }
    }
    procedure CheckPostDated() Exists: Boolean
    begin
        Exists := false;
        BAmount := 0;
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine."Document No", Rec."No.");
        ReceiptLine.SetRange(ReceiptLine."Pay Mode", ReceiptLine."Pay Mode"::Cheque);
        if ReceiptLine.Find('-') then begin
            repeat
                if ReceiptLine.Date > Today then begin
                    Exists := true;
                    exit;
                end;
            until ReceiptLine.Next = 0;
        end;
    end;

    procedure PerformPost()
    begin
        // get all the invoices that have been paid for using the receipt
        USetup.Reset();
        USetup.SetRange(USetup."User ID", Rec."User ID");
        if USetup.FindFirst() then begin
            if USetup."Receipt Journal Template" = '' then begin
                Error('Please ensure that the Administrator sets you up as a cashier');
            end;
            if USetup."Receipt Journal Batch" = '' then begin
                Error('Please ensure that the Administrator sets you up as a cashier');
            end;
        end
        else begin
            Error('Please ensure that the Administrator sets you up as a cashier');
        end;
        rec.calcfields(Rec."New Total Amount");
        if Rec."New Total Amount" <> Rec."Amount Received" then begin
            Error('Please note that the Total Amount and the Amount Received Must be the same');
        end;
        Rec.TestField(Date);
        Rec.TestField("Bank Code");
        Rec.TestField("Received From");
        tAmount := 0;
        CheckBnkCurrency(Rec."Bank Code", Rec."Currency Code");
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine."Document No", Rec."No.");
        if ReceiptLine.Find('-') then begin
            repeat
                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::" " then
                    Error('Paymode is Mandatory on the Receipt Line');
                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::"Deposit Slip" then begin
                    if ReceiptLine."Cheque No" = '' then begin
                        Error('The Cheque/Deposit Slip No must be inserted');
                    end;
                    if ReceiptLine.Date = 0D then begin
                        Error('The Cheque/Deposit Date must be inserted');
                    end;
                end;
                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                    if ReceiptLine."Cheque No" = '' then begin
                        Error('The Cheque/Deposit Slip No must be inserted');
                    end;
                    if ReceiptLine.Date = 0D then begin
                        Error('The Cheque/Deposit Date must be inserted');
                    end;
                end;
                tAmount := tAmount + ReceiptLine.Amount;


            until ReceiptLine.Next = 0;
        end;
        if USetup.Get(UserId) then
            JTemplate := USetup."Receipt Journal Template";
        JBatch := USetup."Receipt Journal Batch";
        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DELETEALL;
        IF DefaultBatch.GET(JTemplate, JBatch) THEN
            DefaultBatch.DELETE;

        DefaultBatch.RESET;
        DefaultBatch."Journal Template Name" := JTemplate;
        DefaultBatch.Name := JBatch;
        DefaultBatch.INSERT;
        // Insert the bank transaction
        if BAmount < tAmount then begin
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := JTemplate;
            GenJnlLine."Journal Batch Name" := JBatch;
            GenJnlLine."Source Code" := 'CASHRECJNL';
            GenJnlLine."Line No." := 1;
            GenJnlLine."Posting Date" := Rec.Date;
            GenJnlLine."Document No." := Rec."No.";
            GenJnlLine."Document Date" := Rec."Posting Date";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := Rec."Bank Code";
            GenJnlLine.VALIDATE(GenJnlLine."Account No.");
            GenJnlLine."Currency Code" := rec."Currency Code";
            GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
            GenJnlLine.Amount := (tAmount);
            GenJnlLine.VALIDATE(GenJnlLine.Amount);
            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
            GenJnlLine."Currency Code" := Rec."Currency Code";
            GenJnlLine.Description := Rec.Description;
            GenJnlLine.VALIDATE(GenJnlLine.Description);
            IF GenJnlLine.Amount <> 0 THEN
                GenJnlLine.INSERT;
            // insert the transaction lines into the database
            ReceiptLine.RESET;
            ReceiptLine.SETRANGE(ReceiptLine."Document No", Rec."No.");
            ReceiptLine.SETRANGE(ReceiptLine.Posted, FALSE);
            if ReceiptLine.Find('-') then begin
                repeat
                    if ReceiptLine.Amount = 0 then
                        Error('Please enter amount.');
                    if ReceiptLine.Amount < 0 then
                        Error('Amount cannot be less than zero.');
                    GLine.Reset();
                    GLine.SetRange(GLine."Journal Template Name", JTemplate);
                    GLine.SETRANGE(GLine."Journal Batch Name", JBatch);
                    LineNo := 0;
                    IF GLine.FIND('+') THEN BEGIN LineNo := GLine."Line No."; END;
                    LineNo := LineNo + 1;
                    if ReceiptLine."Pay Mode" <> ReceiptLine."Pay Mode"::Cheque then begin
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine."Source Code" := 'CASHRECJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := rec.Date;
                        GenJnlLine."Document No." := ReceiptLine."Document No";
                        GenJnlLine."Document Date" := rec."Posting Date";
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."External Document No." := ReceiptLine."Cheque No";
                        GenJnlLine."Currency Code" := rec."Currency Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                        GenJnlLine.Amount := -ReceiptLine.Amount;
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                        GenJnlLine.Description := Rec.Description;
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Global Dimension 2 Code";
                        if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                    end
                    else
                        if
                   ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                            if ReceiptLine.Date <= Today then begin
                                GenJnlLine.INIT;
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := rec.Date;
                                GenJnlLine."Document No." := ReceiptLine."Document No";
                                GenJnlLine."Document Date" := rec.Date;
                                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                                GenJnlLine."Account No." := ReceiptLine."Account Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := ReceiptLine."Cheque No";
                                GenJnlLine."Currency Code" := rec."Currency Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                                GenJnlLine.Amount := -ReceiptLine.Amount;
                                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := rec.Description;
                                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                GenJnlLine."Currency Code" := rec."Currency Code";
                                IF GenJnlLine.Amount <> 0 THEN GenJnlLine.INSERT;
                            end;
                        end;
                until ReceiptLine.Next = 0;
            end;
            // Post the Transactions
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
            // Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.Run(GenJnlLine);
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLine);
            Commit();
            Rec.Posted := true;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            rec."Posted By" := UserId;
            rec.Modify();
            Commit();
            // Update Lines
            ReceiptLine.Reset();
            ReceiptLine.SetRange(ReceiptLine."Document No", Rec."No.");
            ReceiptLine.SetRange(ReceiptLine.Posted, false);
            if ReceiptLine.Find('-') then begin
                repeat
                    ReceiptLine.Posted := TRUE;
                    ReceiptLine."Date Posted" := TODAY;
                    ReceiptLine."Time Posted" := TIME;
                    ReceiptLine."Posted By" := USERID;
                    ReceiptLine.MODIFY;
                    COMMIT;
                UNTIL ReceiptLine.NEXT = 0;
            end;
            Message('Receipt Posted Successfully');
        end;
        ReceiptHeader.Reset();
        ReceiptHeader.SetRange(ReceiptHeader."No.", Rec."No.");
        // if ReceiptHeader.Find('-') then begin
        //     Report.Run();
        // end;
    end;

    procedure CheckBnkCurrency(BankAcc: Code[20]; CurrCode: Code[20])
    begin
        BankAcct.Reset();
        BankAcct.SetRange(BankAcct."No.", BankAcc);
        if BankAcct.Find('-') then begin
            if BankAcct."Currency Code" <> CurrCode then begin
                if BankAcct."Currency Code" = '' then
                    Error('This bank [%1:- %2] can only transact in LOCAL Currency', BankAcct."No.", BankAcct.Name)
                else
                    Error('This bank [%1:- %2] can only transact in %3', BankAcct."No.", BankAcct.Name, BankAcct."Currency Code");
            end;
        end;
    end;

    var
        myInt: Integer;
        BAmount: Decimal;
        ReceiptLine: Record "Receipt Line";
        USetup: Record "Funds User Setup";
        tAmount: Decimal;
        BankAcct: Record "Bank Account";
        JTemplate: Code[20];
        JBatch: Code[20];
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLine: Record "Gen. Journal Line";
        LineNo: Integer;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        ReceiptHeader: Record "Receipt Header";
}