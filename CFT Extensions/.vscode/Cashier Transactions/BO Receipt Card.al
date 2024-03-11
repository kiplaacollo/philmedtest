page 50062 "BO Receipt Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "BO Receipt Header.al";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                }
                field("Client Code"; Rec."Client Code")
                {
                    trigger OnValidate()
                    begin
                        FnClearLines();
                    end;
                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Captured By"; Rec."Captured By")
                {

                }
                field("Transaction Date"; Rec."Transaction Date")
                {

                }
                field("Cutoff Date"; Rec."Cutoff Date")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Pay Mode"; Rec."Pay Mode")
                {

                }
                field("Cheque No"; Rec."Cheque No")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field(Prepayments; Rec.Prepayments)
                {

                }
                field("Paying Bank"; Rec."Paying Bank")
                {

                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {

                }
                field(Remarks; Rec.Remarks)
                {

                }
                field("Recover All time Balances"; Rec."Recover All time Balances")
                {

                }
                field("Clear Specific Loan"; Rec."Clear Specific Loan")
                {
                    trigger OnValidate()
                    begin
                        FnClearLines();
                        if Rec."Clear Specific Loan" = true then
                            ActionSpecific := true
                        else
                            ActionSpecific := false;
                    end;
                }
                field(Payoff; Rec.Payoff)
                {
                    trigger OnValidate()
                    begin
                        FnClearLines();
                        if Rec.Payoff = true then
                            ActionPayoff := true
                        else
                            ActionPayoff := false;
                    end;
                }
                group(control29)
                {
                    Visible = ActionSpecific;
                    field("Loan Number"; Rec."Loan Number")
                    {

                    }

                }
                group(control21)
                {
                    Visible = ActionPayoff;
                    field("Payoff Loan No"; Rec."Payoff Loan No")
                    {

                    }
                }
            }
            group("BO Receipt Line")
            {
                part(boreceiptline; "BO Receipt Line")
                {
                    SubPageLink = "No." = field("No.");
                }
            }

        }

    }

    actions
    {
        area(Processing)
        {
            action("AutoPopulate Payments")
            {
                ApplicationArea = All;
                Image = PlanningWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                begin
                    rec.validate(Rec.Amount);
                    ClearReceiptLines(Rec."No.");
                    Rec.TestField("Cutoff Date");
                    Rec.CalcFields(Prepayments);
                    VarPrepayments := Rec.Prepayments;
                    if (Rec.Amount > 0) or (VarPrepayments > 0) then begin
                        RunBal := Rec.Amount;
                        if RunBal > 0 then
                            RunBal := FnGenerateSuspensePenalties(Rec."Client Code", RunBal);
                        if RunBal > 0 then
                            RunBal := FnGenerateSuspenseInterest(Rec."Client Code", RunBal);
                        if RunBal > 0 then
                            RunBal := FnGeneratePenalties(Rec."Client Code", RunBal);
                        if (RunBal > 0) or (VarPrepayments > 0) then
                            RunBal := FnGenerateInterest(Rec."Client Code", RunBal);
                        if (RunBal > 0) or (VarPrepayments > 0) then
                            RunBal := FnGeneratePrinciple(Rec."Client Code", RunBal);
                        // Payoff
                        if ((RunBal > 0) or (VarPrepayments > 0)) and (Rec.Payoff = true) then begin
                            RunBal := FnGeneratePrinciplePayoff(rec."Client Code", RunBal, VarPrepayments);
                        end;
                        // Payoff
                        if RunBal > 0 then
                            FnGenerateUnAllocatedFunds(rec."Client Code", RunBal);
                    end;
                end;
            }
            action("Post Receipt")
            {
                ApplicationArea = all;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    LineNo := 0;
                    Rec.CalcFields(Prepayments);
                    BOReceiptLine.Reset();
                    BOReceiptLine.SetRange(BOReceiptLine."No.", Rec."No.");
                    if BOReceiptLine.FindSet() then
                        BOReceiptLine.CalcSums(BOReceiptLine.Amount);
                    if Rec.Prepayments > 0 then begin
                        if BOReceiptLine.Amount > (Rec.Amount + Rec.Prepayments) then
                            Error('The Totals on the Receipt Lines must Not be Greater than the Summation of the Header Amount and Prepayments Amount');
                    end else
                        if BOReceiptLine.Amount <> (Rec.Amount) then
                            Error('The Totals on the Receipt Lines must equal to the Header Amount');
                    // if FundSetup.Get(UserId) then begin
                    JTemplate := 'PAYMENT';
                    JBatch := 'ADMIN';
                    // end;
                    GenJournalLine.Reset();
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    IF GenJournalLine.FIND('-') THEN
                        GenJournalLine.DELETEALL;
                    Desc := 'Customer Receipt - ';
                    if Rec.Payoff then
                        Desc := 'Customer PayOff - ';
                    IF CONFIRM('Post Receipt No:' + FORMAT(Rec."No.")) THEN
                        // ........................................Debit Bank Account............................................................................................
                        LineNo := LineNo + 1000;
                    CFTFactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", Rec."No.", Rec."Cheque No", GenJournalLine."Account Type"::"Bank Account", rec."Paying Bank",
          rec.Amount, Desc + COPYSTR(FORMAT(rec."Client Name"), 1, 10) + ' ' + FORMAT(rec."No."), GenJournalLine."Transaction Type", '', '', '', Rec."Loan Product");
                    //   ..........................................End Debit Bank Account.............................................................
                    //............................... Credit Member Loan........................................................................................................
                    BOReceiptLine.Reset();
                    BOReceiptLine.SetRange(BOReceiptLine."No.", Rec."No.");
                    if BOReceiptLine.Find('-') then begin
                        repeat
                            Desc := 'Customer Receipt - ';
                            UnAllocatedClientAccount := '';
                            if BOReceiptLine.Payoff then
                                Desc := 'Customer PayOff - ';
                            //............................... To Keep Track of the Amount Collected and that recovered from the unallocated Account.......................................................
                            IF (BOReceiptLine."Recovery From UnAllocated") OR (BOReceiptLine."Transaction Type" = BOReceiptLine."Transaction Type"::"UnAllocated Funds") THEN
                                UnAllocatedClientAccount := rec."Client Code";
                            //............................ To Keep Track of the Amount Collected and that recovered from the unallocated Account.........................................
                            LineNo := LineNo + 1000;
                            CFTFactory.FnGenerateUnAllocatedGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."No.", rec."Cheque No", GenJournalLine."Account Type"::Customer, rec."Client Code",
              BOReceiptLine.Amount * -1, Desc + COPYSTR(FORMAT(rec."Client Name"), 1, 10) + ' ' + FORMAT(rec."No."), BOReceiptLine."Transaction Type", BOReceiptLine."Loan No", '', '', UnAllocatedClientAccount, Rec."Loan Product");
                            //   ...........................................For Suspended Interest/Penalty Recognise the income once Paid.................................................................
                            IF (BOReceiptLine."Transaction Type" = BOReceiptLine."Transaction Type"::"Interest Suspense Paid") OR (BOReceiptLine."Transaction Type" = BOReceiptLine."Transaction Type"::"Penalty Suspense Paid") THEN begin
                                IF ObjLoanProducts.GET(BOReceiptLine."Loan Product") THEN begin
                                    IF BOReceiptLine."Transaction Type" = BOReceiptLine."Transaction Type"::"Interest Suspense Paid" THEN begin
                                        IncomeAccount := ObjLoanProducts."Interest Income Account";
                                        LiabilityAccount := ObjLoanProducts."Interest Suspense Liability Ac";

                                        LineNo := LineNo + 1000;
                                        CFTFactory.FnGenerateUnAllocatedGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."No.", rec."Cheque No", GenJournalLine."Account Type"::"G/L Account", LiabilityAccount,
                                            BOReceiptLine.Amount, Desc + COPYSTR(FORMAT(rec."Client Name"), 1, 10) + ' ' + FORMAT(rec."No."), GenJournalLine."Transaction Type"::"Interest Suspense Paid", BOReceiptLine."Loan No", '', '', rec."Client Code", Rec."Loan Product");

                                        LineNo := LineNo + 1000;
                                        CFTFactory.FnGenerateUnAllocatedGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."No.", rec."Cheque No", GenJournalLine."Account Type"::"G/L Account", IncomeAccount,
                                          BOReceiptLine.Amount * -1, Desc + COPYSTR(FORMAT(rec."Client Name"), 1, 10) + ' ' + FORMAT(rec."No."), GenJournalLine."Transaction Type", BOReceiptLine."Loan No", '', '', rec."Client Code", Rec."Loan Product");
                                    end else begin
                                        IncomeAccount := ObjLoanProducts."Penalty Income Account";
                                        LiabilityAccount := ObjLoanProducts."Penalty Suspense Liability Ac";

                                        LineNo := LineNo + 1000;
                                        CFTFactory.FnGenerateUnAllocatedGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."No.", rec."Cheque No", GenJournalLine."Account Type"::"G/L Account", LiabilityAccount,
                                            BOReceiptLine.Amount, Desc + COPYSTR(FORMAT(rec."Client Name"), 1, 10) + ' ' + FORMAT(rec."No."), GenJournalLine."Transaction Type"::"Penalty Suspense Paid", BOReceiptLine."Loan No", '', '', rec."Client Code", Rec."Loan Product");

                                        LineNo := LineNo + 1000;
                                        CFTFactory.FnGenerateUnAllocatedGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."No.", rec."Cheque No", GenJournalLine."Account Type"::"G/L Account", IncomeAccount,
                                          BOReceiptLine.Amount * -1, Desc + COPYSTR(FORMAT(rec."Client Name"), 1, 10) + ' ' + FORMAT(rec."No."), GenJournalLine."Transaction Type"::"Penalty Paid", BOReceiptLine."Loan No", '', '', rec."Client Code", Rec."Loan Product");
                                    end;
                                end;
                            end;
                        // ..............................END. For Suspended Interest/Penalty Recognise the income once Paid.....................................................
                        until BOReceiptLine.NEXT = 0;
                    end;
                    // .....................................................END Credit Member Loan...............................................................................
                    // ............................................................Post the GenJnlLine..........................................................................
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", JBatch);
                    IF GenJournalLine.FIND('-') THEN
                        // Page.Run(Page::"General Journal", GenJournalLine);
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);
                    COMMIT;
                    rec."Posted By" := USERID;
                    rec.Posted := TRUE;
                    rec.MODIFY;
                    // BOReceiptHeader.Reset();
                    // BOReceiptHeader.SetRange(BOReceiptHeader."No.", Rec."No.");
                    // if BOReceiptHeader.FindFirst() then begin
                    // Report.RunModal(Report::DepositSlip, true, false, Rec);
                    // end;
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    BOReceiptHeader.Reset();
                    BOReceiptHeader.SetRange(BOReceiptHeader."No.", Rec."No.");
                    if BOReceiptHeader.FindFirst() then begin
                        Report.RunModal(Report::"Receipt Report", true, false, BOReceiptHeader);
                    end;
                end;
            }
            action("Mark Posted")
            {
                Enabled = Enablepost;
                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        BOReceiptLine.Reset();
        BOReceiptLine.SetRange(BOReceiptLine."No.", Rec."No.");
        BOReceiptLine.SetRange(BOReceiptLine.Amount, 0);
        if BOReceiptLine.Find('-') then begin
            BOReceiptLine.DeleteAll();
        end;
        if Rec.Payoff = true
        then
            ActionPayoff := true
        else
            ActionPayoff := false;
        if Rec."Clear Specific Loan" = true
        then
            ActionSpecific := true
        else
            ActionSpecific := false;
        ObjDetailedBOLedgerEntry.Reset();
        ObjDetailedBOLedgerEntry.SetRange(ObjDetailedBOLedgerEntry."Document No.", Rec."No.");
        if ObjDetailedBOLedgerEntry.Find('-') then begin
            Enablepost := true;
            BOReceiptHeader.Reset();
            BOReceiptHeader.SetRange(BOReceiptHeader."No.", Rec."No.");
            if BOReceiptHeader.Find('-') then begin
                BOReceiptHeader.Posted := true;
                BOReceiptHeader."Posted By" := UserId;
                BOReceiptHeader.Modify();
            end;
        end else begin
            Enablepost := false;
        end;

    end;

    procedure FnClearLines()
    begin
        BOReceiptLine.Reset();
        BOReceiptLine.SetRange(BOReceiptLine."No.", Rec."No.");
        if BOReceiptLine.Find('-') then begin
            BOReceiptLine.DeleteAll();
        end;
        Rec."Payoff Loan No" := '';
        Rec."Loan Number" := '';
    end;

    procedure ClearReceiptLines(No: Code[20])
    begin
        ObjBOReceiptLine.Reset();
        ObjBOReceiptLine.SetRange(ObjBOReceiptLine."No.", No);
        if ObjBOReceiptLine.FindSet() then begin
            ObjBOReceiptLine.DeleteAll();
        end;
    end;

    procedure FnGenerateSuspensePenalties(Code: Code[20]; RunningBal: Decimal) RunBalance: Decimal
    begin
        ObjLoans.Reset();
        ObjLoans.SetRange(ObjLoans."Member Number", Code);
        ObjLoans.SetRange(ObjLoans."Approval Status", ObjLoans."Approval Status"::Approved);
        if (Rec."Clear Specific Loan" = true) and (Rec."Loan Number" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Loan Number");
        if (Rec.Payoff = true) and (Rec."Payoff Loan No" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Payoff Loan No");
        ObjLoans.SetRange(ObjLoans.Posted, true);
        if ObjLoans.Find('-') then begin
            repeat
                if RunningBal > 0 then begin
                    VarPenaltyPaid := 0;
                    ObjLoans.CalcFields(ObjLoans."New OutstandinSuspense Penalty", ObjLoans."New Amount Disbursed");
                    if (ObjLoans."New OutstandinSuspense Penalty" > 0) then begin
                        VarPenaltyPaid := ObjLoans."New OutstandinSuspense Penalty";
                        if RunningBal > VarPenaltyPaid then
                            VarPenaltyPaid := VarPenaltyPaid
                        else
                            VarPenaltyPaid := RunningBal;
                        if VarPenaltyPaid > 0 then begin
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"Penalty Suspense Paid", rec."Client Code", ObjLoans."Loan Number", VarPenaltyPaid, FALSE, FALSE);
                            RunningBal := RunningBal - VarPenaltyPaid;
                        end;
                    end;
                end;
            until ObjLoans.Next() = 0;
        end;
        exit(RunningBal);
    end;

    procedure FnGeneralReceiptLines(DocNo: Code[20]; TransactionType: Option; ClientCode: Code[20]; LoanNo: Code[20]; Amount: Decimal; Paidoff: Boolean; RecoveryFromUnAllocated: Boolean)
    begin
        BOReceiptLine.Init();
        BOReceiptLine."Entry No" := EntryNo;
        BOReceiptLine."No." := DocNo;
        BOReceiptLine."Transaction Type" := TransactionType;
        BOReceiptLine."Client Code" := ClientCode;
        BOReceiptLine."Client Name" := Rec."Client Name";
        BOReceiptLine."Loan No" := LoanNo;
        BOReceiptLine.Validate(BOReceiptLine."Loan No");
        BOReceiptLine.Payoff := Paidoff;
        BOReceiptLine."Recovery From UnAllocated" := RecoveryFromUnAllocated;
        BOReceiptLine.Amount := Amount;
        BOReceiptLine.Insert(true);
    end;

    procedure FnGenerateSuspenseInterest(Code: Code[20]; RunningBal: Decimal) RunBalance: Decimal
    begin
        ObjLoans.Reset();
        ObjLoans.SetRange(ObjLoans."Member Number", Code);
        ObjLoans.SetRange(ObjLoans."Approval Status", ObjLoans."Approval Status"::Approved);
        if (Rec."Clear Specific Loan" = true) and (Rec."Loan Number" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Loan Number");
        if (Rec.Payoff = true) and (Rec."Payoff Loan No" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Payoff Loan No");
        ObjLoans.SetRange(ObjLoans.Posted, true);
        if ObjLoans.Find('-') then begin
            repeat
                if RunningBal > 0 then begin
                    VarInterestPaid := 0;
                    ObjLoans.CalcFields(ObjLoans."Outstanding Suspense Interest", ObjLoans."New Amount Disbursed", ObjLoans."New Outstanding Loan");
                    if (ObjLoans."Outstanding Suspense Interest" > 0) then begin
                        VarInterestPaid := ObjLoans."Outstanding Suspense Interest";
                        if RunningBal > VarInterestPaid then
                            VarInterestPaid := VarInterestPaid
                        else
                            VarInterestPaid := RunningBal;
                        if VarInterestPaid > 0 then begin
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"Interest Suspense Paid", rec."Client Code", ObjLoans."Loan Number", VarInterestPaid, FALSE, FALSE);
                            RunningBal := RunningBal - VarInterestPaid;
                        end;
                    end;
                end;
            until ObjLoans.Next() = 0;
        end;
        exit(RunningBal);
    end;

    procedure FnGeneratePenalties(Code: Code[20]; RunningBal: Decimal) RunBalance: Decimal
    begin
        ObjLoans.Reset();
        ObjLoans.SetRange(ObjLoans."Member Number", Code);
        ObjLoans.SetRange(ObjLoans."Approval Status", ObjLoans."Approval Status"::Approved);
        if (Rec."Clear Specific Loan" = true) and (Rec."Loan Number" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Loan Number");
        if (Rec.Payoff = true) and (Rec."Payoff Loan No" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", rec."Payoff Loan No");
        ObjLoans.SetRange(ObjLoans.Posted, true);
        if ObjLoans.Find('-') then begin
            repeat
                if RunningBal > 0 then begin
                    VarPenaltyPaid := 0;
                    ObjLoans.CalcFields(ObjLoans."New Outstanding Penalty", ObjLoans."New Amount Disbursed");
                    if (ObjLoans."New Outstanding Penalty" > 0) then begin
                        VarPenaltyPaid := ObjLoans."New Outstanding Penalty";
                        if RunningBal > VarPenaltyPaid then
                            VarPenaltyPaid := VarPenaltyPaid
                        else
                            VarPenaltyPaid := RunningBal;
                        if VarPenaltyPaid > 0 then begin
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"Penalty Paid", rec."Client Code", ObjLoans."Loan Number", VarPenaltyPaid, FALSE, FALSE);
                            RunningBal := RunningBal - VarPenaltyPaid;
                        end;
                    end;
                end;
            until ObjLoans.Next() = 0;
        end;
        exit(RunningBal);
    end;

    procedure FnGenerateInterest(Code: Code[20]; RunningBal: Decimal) RunBalance: Decimal
    begin
        ObjLoans.Reset();
        ObjLoans.SetRange(ObjLoans."Member Number", Code);
        ObjLoans.SetRange(ObjLoans."Approval Status", ObjLoans."Approval Status"::Approved);
        if (Rec."Clear Specific Loan" = true) and (Rec."Loan Number" <> '0') then
            ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Loan Number");
        if (Rec.Payoff = true) and (rec."Payoff Loan No" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Payoff Loan No");
        ObjLoans.SetRange(ObjLoans.Posted, true);
        if ObjLoans.Find('-') then begin
            repeat
                LastDueDate := FnGetLastDueDate(ObjLoans."Loan Number");
                if (RunningBal > 0) or (VarPrepayments > 0) then begin
                    VarInterestPaid := 0;
                    VarInterestArrears := 0;
                    if Rec."Recover All time Balances" = false then
                        ObjLoans.SetFilter(ObjLoans."Date Filter", '..%1', LastDueDate);
                    ObjLoans.CalcFields(ObjLoans."New Outstanding Interest", ObjLoans."New Interest Due", ObjLoans."New Interest Paid", ObjLoans."New Amount Disbursed", ObjLoans."New Outstanding Loan");
                    // Handle eith Month
                    ObjRepaymentHolidaysSetup.Reset();
                    ObjRepaymentHolidaysSetup.SetRange(ObjRepaymentHolidaysSetup."Loan Number", ObjLoans."Loan Number");
                    ObjRepaymentHolidaysSetup.SETFILTER(ObjRepaymentHolidaysSetup."Installment Month", '<>%1', 0D);
                    if ObjRepaymentHolidaysSetup.Find('-') then begin
                        ObjLoanRepaymentschedule.Reset();
                        ObjLoanRepaymentschedule.SetRange("Loan No.", ObjLoans."Loan Number");
                        ObjLoanRepaymentschedule.SETFILTER("Repayment Date", '..%1', LastDueDate);
                        IF ObjLoanRepaymentschedule.FIND('+') THEN begin
                            ObjLoanRepaymentschedule.CalcSums(ObjLoanRepaymentschedule."Monthly Interest");
                            if (ObjLoans."New Interest Due" > ObjLoanRepaymentschedule."Monthly Interest") then
                                OutstandingInterest := ObjLoanRepaymentschedule."Monthly Interest" - ObjLoans."New Interest Paid"
                            else
                                OutstandingInterest := ObjLoans."New Outstanding Interest";

                        end;
                    end
                    else begin
                        OutstandingInterest := ObjLoans."New Outstanding Interest";
                    end;
                    // End Handle eith month below changed LoanApp."Outstanding Interest" TO OutstandingInterest
                    if (OutstandingInterest > 0) then begin
                        VarInterestPaid := OutstandingInterest;
                        if RunningBal > VarInterestPaid then
                            VarInterestPaid := VarInterestPaid
                        else begin
                            VarInterestPaid := RunningBal;
                            // From Recover From UnAllocated
                            if (VarPrepayments > 0) then begin
                                VarInterestArrears := OutstandingInterest - VarInterestPaid;
                                if VarPrepayments > VarInterestArrears then
                                    VarInterestArrears := VarInterestArrears
                                else
                                    VarInterestArrears := VarPrepayments;
                            end;
                            // From Recover From UnAllocated
                        end;
                        if VarInterestPaid > 0 then begin
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"Interest Paid", rec."Client Code", ObjLoans."Loan Number", VarInterestPaid, FALSE, FALSE);
                            RunningBal := RunningBal - VarInterestPaid;
                        end;
                        // Insert the UnAllocated Recoveries to lines 
                        if VarInterestArrears > 0 then begin
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"UnAllocated Funds", rec."Client Code", ObjLoans."Loan Number", (VarInterestArrears) * -1, FALSE, TRUE);
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"Interest Paid", rec."Client Code", ObjLoans."Loan Number", VarInterestArrears, FALSE, TRUE);

                            VarPrepayments := VarPrepayments - VarInterestArrears;
                        end;
                        // Insert the UnAllocated Recoveries to lines 
                    end;
                end;
            until ObjLoans.Next() = 0;
        end;
        exit(RunningBal);
    end;

    procedure FnGetLastDueDate(LoanNo: Code[20]) RDate: Date
    begin
        ObjRSchedule.Reset();
        ObjRSchedule.SetRange(ObjRSchedule."Loan No.", LoanNo);
        ObjRSchedule.SetFilter(ObjRSchedule."Repayment Date", '..%1', rec."Cutoff Date");
        if ObjRSchedule.Find('+') then begin
            exit(ObjRSchedule."Repayment Date");
        end else begin
            ObjRSchedule.Reset();
            ObjRSchedule.SetRange(ObjRSchedule."Loan No.", LoanNo);
            if ObjRSchedule.Find('-') then
                exit(ObjRSchedule."Repayment Date")
        end;
    end;

    procedure FnGeneratePrinciple(Code: Code[20]; RunningBal: Decimal) RunBalance: Decimal
    begin
        ObjLoans.Reset();
        ObjLoans.SetRange(ObjLoans."Member Number", Code);
        ObjLoans.SetRange(ObjLoans."Approval Status", ObjLoans."Approval Status"::Approved);
        if (rec."Clear Specific Loan" = true) and (Rec."Loan Number" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", rec."Loan Number");
        if (rec.Payoff = true) and (Rec."Payoff Loan No" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Payoff Loan No");
        ObjLoans.SetRange(ObjLoans.Posted, true);
        if ObjLoans.Find('-') then begin
            repeat
                VarPaidInterest := 0;
                VarPrincipalArrears := 0;
                if (RunningBal > 0) or (VarPrepayments > 0) then begin
                    VarPrinciplePaid := 0;
                    ObjLoans.CalcFields(ObjLoans."New Outstanding Loan", ObjLoans."New Amount Disbursed");
                    if (ObjLoans."New Outstanding Loan" > 0) then begin
                        // Get Total Due
                        VarPrincipalDue := FnGetMonthlyPrinciple(ObjLoans."Loan Number", ObjLoans."New Outstanding Loan") + FnGetPrincipalDue(ObjLoans."Loan Number");
                        VarPaidInterest := FnGetInterestPaid(ObjLoans."Loan Number", ObjLoans."Member Number");
                        // Get Principal Payable for current Month
                        if ObjLoans."New Outstanding Loan" < ObjLoans."Principal Repayment" then
                            VarPrinciplePaid := ObjLoans."New Outstanding Loan"
                        else begin
                            if Rec."Recover All time Balances" = false then begin
                                LastDueDate := FnGetLastDueDate(ObjLoans."Loan Number");
                                if Rec."Cutoff Date" < LastDueDate then
                                    VarPrinciplePaid := 0
                                else
                                    VarPrinciplePaid := VarPrincipalDue;

                            end else
                                VarPrinciplePaid := ObjLoans."Total Monthly Repayment" - VarPaidInterest;

                            IF VarPrincipalDue > VarPrinciplePaid THEN
                                VarPrinciplePaid := VarPrincipalDue;
                        end;
                        // Get Principal Payable for current Month
                        IF RunningBal > VarPrinciplePaid THEN
                            VarPrinciplePaid := VarPrinciplePaid
                        else begin
                            VarPrinciplePaid := RunningBal;
                            // From Recover From UnAllocated

                            IF (VarPrepayments > 0) THEN begin
                                VarPrincipalArrears := (ObjLoans."Total Monthly Repayment" - VarPaidInterest) - VarPrinciplePaid;
                                IF VarPrepayments > VarPrincipalArrears THEN
                                    VarPrincipalArrears := VarPrincipalArrears
                                else
                                    VarPrincipalArrears := VarPrepayments;
                            end;
                            // From Recover From UnAllocated
                        end;
                        IF VarPrinciplePaid > 0 THEN begin
                            if (Rec.Payoff = true) and (rec."Payoff Loan No" <> '') then
                                VarLessPrincipalPaidonPayoff := VarPrinciplePaid;
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"Principal Repayment", rec."Client Code", ObjLoans."Loan Number", VarPrinciplePaid, FALSE, FALSE);
                            RunningBal := RunningBal - VarPrinciplePaid;
                        end;
                        // Insert the UnAllocated Recoveries to lines 
                        IF VarPrincipalArrears > 0 THEN begin
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"UnAllocated Funds", rec."Client Code", ObjLoans."Loan Number", (VarPrincipalArrears) * -1, FALSE, TRUE);
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"Principal Repayment", rec."Client Code", ObjLoans."Loan Number", VarPrincipalArrears, FALSE, TRUE);

                            VarPrepayments := VarPrepayments - VarPrincipalArrears;
                        end;
                        // Insert the UnAllocated Recoveries to lines 
                    end;
                end;
            until ObjLoans.Next() = 0;
        end;
        exit(RunningBal);
    end;

    procedure FnGetMonthlyPrinciple(LoanNo: Code[50]; OutstandingBal: Decimal) Principal: Decimal
    begin
        ObjRepaymentSchedule.Reset();
        ObjRepaymentSchedule.SetRange(ObjRepaymentSchedule."Loan No.", LoanNo);
        ObjRepaymentSchedule.SETFILTER(ObjRepaymentSchedule."Repayment Date", '..%1', rec."Cutoff Date");
        IF ObjRepaymentSchedule.FIND('+') THEN begin
            PrincipleRepayment := ObjRepaymentSchedule."Principal Repayment";
            PrincipalDue := PrincipleRepayment;
            PrevCutoff := CalcDate('-1M', Rec."Cutoff Date");
            ObjShedule.Reset();
            ObjShedule.SetRange(ObjShedule."Loan No.", LoanNo);
            ObjShedule.SetRange(ObjShedule."Repayment Date", PrevCutoff);
            if ObjShedule.Find('-') then begin
                if ObjShedule."Loan Balance" > OutstandingBal then begin
                    OverPaidAmt := ObjRSchedule."Loan Balance" - OutstandingBal;
                    if OverPaidAmt < PrincipleRepayment then
                        PrincipalDue := PrincipleRepayment - OverPaidAmt
                    else
                        if OverPaidAmt > PrincipleRepayment then
                            PrincipalDue := 0
                        else
                            PrincipalDue := PrincipleRepayment;
                end;
            end else
                PrincipalDue := 0;
            // Added to handle first Installment on 05022020;
            if ObjRepaymentSchedule."Instalment No" = 1 then
                PrincipalDue := PrincipleRepayment;
            IF ROUND(ObjRepaymentSchedule."Loan Balance", 1, '=') >= ROUND(OutstandingBal, 1, '=') THEN
                EXIT(0)
            ELSE
                EXIT(PrincipalDue);
        end;
    end;

    procedure FnGetPrincipalDue(LoanNo: Code[50]) PDue: Decimal
    begin
        TotalPrincipalPaid := 0;
        PrevRepaymentDate := CALCDATE('-1M', rec."Cutoff Date");
        PrevRepaymentDate := CALCDATE('CM', PrevRepaymentDate);
        ObjLoans.RESET;
        ObjLoans.SETRANGE(ObjLoans."Loan Number", LoanNo);
        ObjLoans.SETFILTER(ObjLoans."Date Filter", '..%1', CALCDATE('1M-1D', PrevRepaymentDate));
        IF ObjLoans.FIND('-') THEN begin
            ObjLoans.CalcFields(ObjLoans."New Principal Paid", ObjLoans."New PrincipalPaid as at Cutoff", ObjLoans."New Last Payment Date");
            TotalPrincipalPaid := ObjLoans."New Principal Paid" + ObjLoans."New PrincipalPaid as at Cutoff";
        end;
        ObjRepaymentSchedule.Reset();
        ObjRepaymentSchedule.SetRange(ObjRepaymentSchedule."Loan No.", LoanNo);
        ObjRepaymentSchedule.SetFilter(ObjRepaymentSchedule."Repayment Date", '..%1', PrevRepaymentDate);
        if ObjRepaymentSchedule.Find('-') then begin
            ObjRepaymentSchedule.CALCSUMS(ObjRepaymentSchedule."Principal Repayment");
            PrincipalArrears := ObjRepaymentSchedule."Principal Repayment" - TotalPrincipalPaid;
            if PrincipalArrears <= 0 then
                PrincipalArrears := 0;
            exit(PrincipalArrears);
        end;
    end;

    procedure FnGetInterestPaid(LoanNo: Code[50]; ClientCode: Code[50]) PrincipleRepayment: Decimal
    begin
        BOReceiptLine.Reset();
        BOReceiptLine.SetRange(BOReceiptLine."No.", Rec."No.");
        BOReceiptLine.SetRange(BOReceiptLine."Transaction Type", BOReceiptLine."Transaction Type"::"Interest Paid");
        BOReceiptLine.SETRANGE(BOReceiptLine."Loan No", LoanNo);
        BOReceiptLine.SETRANGE(BOReceiptLine."Client Code", rec."Client Code");
        IF BOReceiptLine.FIND('-') THEN begin
            exit(BOReceiptLine.Amount)
        end;
    end;

    procedure FnGenerateUnAllocatedFunds(Code: Code[20]; RunningBal: Decimal)
    begin
        Receiptline.Reset();
        Receiptline.SetRange(Receiptline."No.", Rec."No.");
        Receiptline.SETFILTER(Receiptline."Loan No", '<>%1', '');
        IF Receiptline.FIND('+') THEN
            UnAllocatedLoan := Receiptline."Loan No";
        IF UnAllocatedLoan = '' THEN begin
            ObjLoans.Reset();
            ObjLoans.SetRange("Member Number", Rec."Client Code");
            ObjLoans.SetRange(Posted, true);
            if ObjLoans.Find('+') then
                UnAllocatedLoan := ObjLoans."Loan Number";

        end;
        FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"UnAllocated Funds", rec."Client Code", UnAllocatedLoan, RunningBal, FALSE, FALSE);
    end;

    procedure FnGeneratePrinciplePayoff(Code: Code[20]; RunningBal: Decimal; PrepaymentsRunBal: Decimal) RunBalance: Decimal
    begin
        ObjLoans.Reset();
        ObjLoans.SetRange(ObjLoans."Member Number", Code);
        ObjLoans.SetRange(ObjLoans."Approval Status", ObjLoans."Approval Status"::Approved);
        if (Rec.Payoff = true) and (Rec."Payoff Loan No" <> '') then
            ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Payoff Loan No");
        ObjLoans.SetRange(ObjLoans.Posted, true);
        IF ObjLoans.FIND('-') THEN begin
            repeat
                VarPrincipalPayoff := 0;
                if (RunningBal > 0) or (VarPrepayments > 0) then begin
                    ObjLoans.CalcFields(ObjLoans."New Outstanding Loan", ObjLoans."New Amount Disbursed");
                    if (ObjLoans."New Outstanding Loan" > 0) then begin
                        VarPrincipalPayoff := ObjLoans."New Outstanding Loan" - VarLessPrincipalPaidonPayoff;
                        IF RunningBal > VarPrincipalPayoff THEN
                            VarPrincipalPayoff := VarPrincipalPayoff
                        else begin
                            VarPrincipalPayoff := RunningBal;
                            // From Recover From UnAllocated
                            IF (VarPrepayments > 0) THEN begin
                                VarPrincipalArrears := (ObjLoans."New Outstanding Loan" - VarLessPrincipalPaidonPayoff) - VarPrincipalPayoff;
                                IF VarPrepayments > VarPrincipalArrears THEN
                                    VarPrincipalArrears := VarPrincipalArrears
                                ELSE
                                    VarPrincipalArrears := VarPrepayments;
                            end;
                            // From Recover From UnAllocated
                        end;
                        IF VarPrincipalPayoff <> 0 THEN begin
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"Principal Repayment", rec."Client Code", ObjLoans."Loan Number", VarPrincipalPayoff, TRUE, FALSE);
                            RunningBal := RunningBal - VarPrincipalPayoff;
                        end;
                        // Insert the UnAllocated Recoveries to lines 
                        IF VarPrincipalArrears > 0 THEN begin
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"UnAllocated Funds", rec."Client Code", ObjLoans."Loan Number", (VarPrincipalArrears) * -1, FALSE, TRUE);
                            FnGeneralReceiptLines(rec."No.", BOReceiptLine."Transaction Type"::"Principal Repayment", rec."Client Code", ObjLoans."Loan Number", VarPrincipalArrears, FALSE, TRUE);

                            VarPrepayments := VarPrepayments - VarPrincipalArrears;
                        end;
                        // Insert the UnAllocated Recoveries to lines
                    end;
                end;
            UNTIL ObjLoans.NEXT = 0;
        end;
        exit(RunningBal);
    end;

    var
        myInt: Integer;
        BOReceiptLine: Record "BO Receipt Line";
        ActionPayoff: Boolean;
        ActionSpecific: Boolean;
        ObjDetailedBOLedgerEntry: Record "Detailed BO Ledger Entry";
        Enablepost: Boolean;
        BOReceiptHeader: Record "BO Receipt Header.al";
        LineNo: Integer;
        FundSetup: Record "Funds User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        Desc: Text;
        CFTFactory: Codeunit "CFT Factory";
        UnAllocatedClientAccount: Code[5];
        ObjLoanProducts: Record "Loan Products";
        IncomeAccount: Code[50];
        LiabilityAccount: Code[50];
        ObjBOReceiptLine: Record "BO Receipt Line";
        VarPrepayments: Decimal;
        RunBal: Decimal;
        ObjLoans: Record Loans;
        VarPenaltyPaid: Decimal;
        EntryNo: Integer;
        VarInterestPaid: Decimal;
        ObjRSchedule: Record "Loan Repayment Shedule";
        LastDueDate: Date;
        VarInterestArrears: Decimal;
        ObjRepaymentHolidaysSetup: Record "Repayment Holidays Setup";
        ObjLoanRepaymentschedule: Record "Loan Repayment Shedule";
        OutstandingInterest: Decimal;
        VarPaidInterest: Decimal;
        VarPrincipalArrears: Decimal;
        VarPrinciplePaid: Decimal;
        VarPrincipalDue: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Shedule";
        PrincipleRepayment: Decimal;
        PrincipalDue: Decimal;
        PrevCutoff: Date;
        ObjShedule: Record "Loan Repayment Shedule";
        OverPaidAmt: Decimal;
        TotalPrincipalPaid: Decimal;
        PrevRepaymentDate: Date;
        PrincipalArrears: Decimal;
        VarLessPrincipalPaidonPayoff: Decimal;
        Receiptline: Record "BO Receipt Line";
        UnAllocatedLoan: Code[50];
        VarPrincipalPayoff: Decimal;

}