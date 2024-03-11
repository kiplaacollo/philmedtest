page 50226 "Accrual Header Card(Posted)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Accrual Header";
    SourceTableView = where(Status = const(true));

    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Entry Date"; Rec."Entry Date")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Loan Cutoff Date"; Rec."Loan Cutoff Date")
                {

                }
                field("Accrual Type"; Rec."Accrual Type")
                {

                }
                field("Employer Code"; Rec."Employer Code")
                {

                }
                field("Employer Description"; Rec."Employer Description")
                {
                    Editable = false;
                }
                field("Total Count"; Rec."Total Count")
                {
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {

                }
            }
            group("Accrual Lines")
            {
                part(AccrualLines; "Accrual Lines")
                {
                    SubPageLink = no = field(No);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Lines")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = List;
                Visible = false;

                trigger OnAction()
                begin
                    clearAcrualLines();
                    boAccounts.Reset();
                    boAccounts.SetRange(boAccounts."Membership Status", boAccounts."Membership Status"::Active);
                    if boAccounts.Find('-') then begin
                        repeat
                            fngenerateAccrualLines();
                        until boAccounts.Next = 0;
                    end;
                    Message('Accrual entries generated successfully.');
                end;
            }
            action("Post")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                begin
                    LineNo := 0;
                    LineNo := 1000;
                    JTemplate := 'GENERAL';
                    JBatch := 'INTEREST';

                    GenJournalLine.Reset();
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll();
                    if Confirm('Post Loan Interest Accrual Document No:' + Format(Rec.No)) then
                        // Debit Member Account
                        accrualLines.Reset();
                    accrualLines.SetRange(accrualLines.no, Rec.No);
                    if accrualLines.Find('-') then begin
                        repeat
                            LineNo := LineNo + 1000;
                            CFTFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, Rec.No, LineNo, GenJournalLine."Transaction Type"::"Interest Due", GenJournalLine."Account Type"::Customer,
                                                                      accrualLines."Client Code", Rec."Posting Date", accrualLines.Amount, '', 'Interest Accrual', GenJournalLine."Account Type"::"G/L Account", accrualLines."Gl Account", accrualLines."Loan Number", accrualLines."Loan Product");
                        until accrualLines.next = 0;
                    end;

                    //   End Credit Bank
                    // Post the GenJnLine
                    GenJournalLine.Reset();
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    if GenJournalLine.find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                    //Page.Run(Page::"General Journal", GenJournalLine);
                    Commit();
                    Rec.Status := true;
                    Rec.Modify();
                end;
            }
        }
    }

    procedure clearAcrualLines()
    begin
        accrualLines.Reset();
        accrualLines.SetRange(accrualLines."No", Rec.No);
        if accrualLines.FindSet() then begin
            accrualLines.DeleteAll();

        end;
    end;

    procedure fngenerateAccrualLines()
    var
    //Loop Member Loans
    begin

        memberLoans.Reset();
        memberLoans.SetRange(memberLoans."Member Number", boAccounts."No.");
        memberLoans.SetRange(memberLoans."Approval Status", memberLoans."Approval Status"::Approved);
        memberLoans.SetRange(memberLoans.Posted, true);
        //memberLoans.SetFilter("Repayment Debut Date", '<=%1', Rec."Loan Cutoff Date");
        //memberLoans.SetFilter(memberLoans."Outstanding Loan", '>%1', 0);

        if memberLoans.Find('-') then begin

            repeat
                memberLoans.CalcFields("New Outstanding Loan");
                memberLoans.CalcFields("New Outstanding Interest");
                memberLoans.CalcFields("New Outstanding Penalty");
                //Message('Loading Lines %1');
                accrualLines.Init();
                accrualLines.no := Rec.No;
                accrualLines."Client Code" := memberLoans."Member Number";
                accrualLines."Client Name" := memberLoans."Full Name";
                accrualLines."Loan Number" := memberLoans."Loan Number";
                accrualLines."Loan Product" := memberLoans."Loan Product";
                accrualLines."Outstanding Balance" := memberLoans."New Outstanding Loan";
                accrualLines."Interest Rate" := memberLoans."Interest Rate";
                accrualLines."Outstanding Interest" := memberLoans."New Outstanding Interest";
                accrualLines."Outstanding Penalty" := memberLoans."New Outstanding Penalty";
                accrualLines."Loan Calculation Method" := memberLoans."Interest Calculation Method";
                accrualLines."Payroll Number" := memberLoans."Payroll Number";
                loanproducts.Reset();
                loanproducts.SetRange(Code, accrualLines."Loan Product");
                if loanproducts.Find('-') then
                    //Message('Income Account is %1', loanproducts."Interest Income Account");
                accrualLines."Gl Account" := loanproducts."Interest Income Account";
                accrualLines."Entry No" := entryNo;
                //if Rec."Accrual Type"::"Intrest Due" then
                //if accrualLines."Outstanding Balance" > 0 then
                accrualLines.Amount := returnLoanMonthlyInterest(memberLoans."Loan Number", false);

                accrualLines.Insert(true);

            until memberLoans.Next = 0;
        end;

    end;

    procedure returnLoanMonthlyInterest(loanno: code[50]; Rescheduled: boolean) LInterest: Decimal
    begin
        memberLoans.RESET;
        memberLoans.SETRANGE(memberLoans."Loan Number", loanno);
        IF memberLoans.FIND('-') THEN BEGIN

            memberLoans.TESTFIELD(memberLoans."Disbursement Date");
            memberLoans.TESTFIELD(memberLoans."Repayment Debut Date");

            IF Rescheduled = FALSE THEN BEGIN
                LoanAmount := memberLoans."Approved Amount";
                InterestRate := memberLoans."Interest Rate";
                RepayPeriod := memberLoans.Installments;
                LBalance := memberLoans."Approved Amount";
                RunDate := memberLoans."Repayment Debut Date";
                memberLoans.TESTFIELD(memberLoans."Interest Rate");
                memberLoans.TESTFIELD(memberLoans.Installments);
            END;
            //Recheduled Loans
            IF Rescheduled = TRUE THEN BEGIN
                LoanAmount := memberLoans."Approved Amount";
                InterestRate := memberLoans."Interest Rate";
                RepayPeriod := memberLoans.Installments;
                LBalance := memberLoans."Approved Amount";
                RunDate := memberLoans."Repayment Debut Date";
            END;


            //Repayment Frequency
            IF memberLoans."Repayment Frequency" = memberLoans."Repayment Frequency"::Daily THEN
                RunDate := CALCDATE('-1D', RunDate)
            ELSE
                IF memberLoans."Repayment Frequency" = memberLoans."Repayment Frequency"::Weekly THEN
                    RunDate := CALCDATE('-1W', RunDate)
                ELSE
                    IF memberLoans."Repayment Frequency" = memberLoans."Repayment Frequency"::Monthly THEN
                        RunDate := CALCDATE('-1M', RunDate)
                    ELSE
                        IF memberLoans."Repayment Frequency" = memberLoans."Repayment Frequency"::Quarterly THEN
                            RunDate := CALCDATE('-1Q', RunDate);

            //Calculate Monthly Interest Based on Interest Calculation Method
            IF memberLoans."Interest Calculation Method" = memberLoans."Interest Calculation Method"::Amortized THEN BEGIN
                memberLoans.TESTFIELD(memberLoans."Interest Rate");
                memberLoans.TESTFIELD(memberLoans.Installments);
                LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
            END;

            IF memberLoans."Interest Calculation Method" = memberLoans."Interest Calculation Method"::"Straight Line" THEN BEGIN
                memberLoans.TESTFIELD(memberLoans."Interest Rate");
                memberLoans.TESTFIELD(memberLoans.Installments);
                LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
            END;

            IF memberLoans."Interest Calculation Method" = memberLoans."Interest Calculation Method"::"Reducing Balance" THEN BEGIN
                memberLoans.TESTFIELD(memberLoans."Interest Rate");
                memberLoans.TESTFIELD(memberLoans.Installments);
                LInterest := (InterestRate / 12 / 100) * LBalance;
            END;

            IF memberLoans."Interest Calculation Method" = memberLoans."Interest Calculation Method"::Discounted THEN BEGIN
                memberLoans.TESTFIELD(memberLoans."Interest Rate");
                memberLoans.TESTFIELD(memberLoans.Installments);
                LInterest := (InterestRate / 12 / 100) * LBalance;
            END;
            COMMIT;
        END;
    END;

    var
        myInt: Integer;
        boAccounts: Record Customer;
        accrualLines: Record "Accrual Lines";
        memberLoans: record Loans;
        entryNo: Integer;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        LInterest: Decimal;
        LBalance: Decimal;
        RepayPeriod: Integer;
        Interest: Decimal;
        RunDate: Date;
        cftFactory: Codeunit "CFT Factory";
        LineNo: Integer;

        JTemplate: Code[20];
        JBatch: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        loanproducts: Record "Loan Products";
}