page 50167 "Disbursement Card(Approved)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Disbursement";
    // Editable = false;
    SourceTableView = where(Posted = const(false), Status = const(Approved));
    // InsertAllowed = false;
    // ModifyAllowed = false;
    // DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                }
                field("Client No"; Rec."Client No")
                {

                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Loan No"; Rec."Loan No")
                {

                }
                field("ED Loan Account No"; Rec."ED Loan Account No")
                {

                }
                field("Disbursement Type"; Rec."Disbursement Type")
                {

                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Editable = false;
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    Editable = false;
                }
                field("Balance Outstanding"; Rec."Balance Outstanding")
                {
                    Editable = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {

                }
                field("Amount to Disburse"; Rec."Amount to Disburse")
                {

                }
                field("Total Upfront Deductions"; Rec."Total Upfront Deductions")
                {

                }
                field("Loan Perfection Charges"; Rec."Loan Perfection Charges")
                {

                }
                field("Loan Prepayments"; Rec."Loan Prepayments")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {

                }
                field("Approval Date"; Rec."Approval Date")
                {

                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {

                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Paying Bank"; Rec."Paying Bank")
                {

                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {

                }
                field("Cheque No/Reference No"; Rec."Cheque No/Reference No")
                {

                }
                field("Booked By"; Rec."Booked By")
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post Disbursement")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    LineNo := 0;
                    LineNo := 1000;
                    JTemplate := 'GENERAL';
                    JBatch := 'LOANS';

                    GenJournalLine.Reset();
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll();
                    if Confirm('Post Loan Disbursement Document No:' + Format(Rec."No.")) then
                        // Debit Member Account
                        LineNo := LineNo + 1000;
                    CFTFactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', Rec."Posting Date", Rec."Loan No", Rec."Cheque No/Reference No", GenJournalLine."Account Type"::customer, Rec."Client No", (Rec."Amount to Disburse"), 'Disbursement -' + Format(Rec."Client Name") + '' + Format(Rec."No."), GenJournalLine."Transaction Type"::Loan, Rec."Loan No", '', '', Rec."Loan Product Type");
                    // End Debit Member Account
                    // Credit Charges
                    RunBal := Round(Rec."Amount to Disburse", 0.01, '=');
                    if Rec."Disbursed Amount" = 0 then begin
                        RunBal := FnCalcLoanCharges(Rec."Amount to Disburse");
                    end;
                    // Credit Bank
                    LineNo := LineNo + 1000;
                    CFTFactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."Loan No", rec."Cheque No/Reference No", GenJournalLine."Account Type"::"Bank Account", rec."Paying Bank",
              (RunBal) * -1, 'Disbursement - ' + FORMAT(rec."Client Name") + ' ' + FORMAT(rec."No."), GenJournalLine."Transaction Type"::Loan, rec."Loan No", '', '', Rec."Loan Product Type");
                    //   End Credit Bank
                    // Post the GenJnLine
                    GenJournalLine.Reset();
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    if GenJournalLine.find('-') then
                        //     genjnlpostlineext.PostGenJnlLine(GenJournalLine, Balancing);
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                    Commit();

                    // Page.Run(Page::"General Journal", GenJournalLine);
                    rec.Status := Rec.Status::Posted;
                    Rec.Posted := true;
                    Rec.Modify();
                    if (Rec.Posted = true) then begin
                        // Mark Collateral Details as Posted
                        LoanCollateralDetails.Reset();
                        LoanCollateralDetails.SetRange(LoanCollateralDetails."Loan No", Rec."Loan No");
                        if LoanCollateralDetails.Find('-') then begin
                            repeat
                                if LoanCollateralDetails."Amount To Commit" > 0 then begin
                                    LoanCollateralDetails.Posted := true;
                                    LoanCollateralDetails.Modify();
                                end;
                            until LoanCollateralDetails.Next = 0;
                        end;
                        // Mark Loans as Posted
                        ObjLoans.Reset();
                        ObjLoans.SetRange(ObjLoans."Loan Number", Rec."Loan No");
                        if ObjLoans.Find('-') then begin
                            // ObjLoans.CalcFields(ObjLoans."New Amount Disbursed")
                            if ObjLoans."Amount Disbursed" = ObjLoans."Approved Amount" then
                                ObjLoans."Fully Disbursed" := true;
                            if ObjLoans.Posted = false then
                                ObjLoans.Posted := true;
                            if ObjLoans."Initial Disbursement Created" = false then
                                ObjLoans."Initial Disbursement Created" := true;
                            ObjLoans.Modify();
                        end;
                    end;
                end;
            }
        }
    }
    procedure FnCalcLoanCharges(RunningBal: Decimal) RunBal: Decimal
    var
        VarAmount: Decimal;
    begin
        VarRunBal := RunningBal;
        TotalCharges := 0;
        if RunningBal > 0 then begin
            LCharges.Reset();
            LCharges.SetRange(LCharges.Code);
            if LCharges.Find('-') then begin
                repeat
                    if LCharges."Use Percentage" = true then
                        VarAmount := (LCharges.Percentage * Rec."Approved Amount") / 100
                    else
                        VarAmount := LCharges.Amount;
                    if RunningBal > VarAmount then
                        VarAmount := VarAmount
                    else
                        VarAmount := RunningBal;
                    LineNo := LineNo + 1000;
                    CFTFactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."Loan No", rec."Cheque No/Reference No", GenJournalLine."Account Type"::"G/L Account", LCharges."Account No",
                      (VarAmount) * -1, FORMAT(rec."Client Name") + '-' + FORMAT(rec."Loan No") + '-' + FORMAT(rec."No."), GenJournalLine."Transaction Type"::Loan, rec."Loan No", '', '', Rec."Loan Product Type");
                    RunningBal := RunningBal - VarAmount;
                until LCharges.next = 0;
            end;
        end;
        exit(RunningBal);
    end;

    // procedure FnDeductLoanPrepayment() RunningBal: Decimal
    // begin
    //     Rec.CalcFields(Rec."Loan Prepayments");
    //     if Rec."Loan Prepayments" > 0 then begin
    //         LineNo := LineNo + 1000;
    //         CFTFactory.FnGenerateUnAllocatedGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."Loan No", rec."Cheque No/Reference No", GenJournalLine."Account Type"::Customer, Rec."Client No",
    //             (rec."Loan Prepayments") * -1, FORMAT(rec."Client Name") + '-' + FORMAT(rec."Loan No") + '-' + FORMAT(rec."No.") + '-' + 'Loan Prepayment', GenJournalLine."Transaction Type"::"UnAllocated Funds", rec."Loan No", '', '', rec."Client No");
    //     end;
    // end;

    var
        myInt: Integer;
        LineNo: Integer;
        JTemplate: Code[20];
        JBatch: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        CFTFactory: Codeunit "CFT Factory";
        RunBal: Decimal;
        VarRunBal: Decimal;
        TotalCharges: Decimal;
        LCharges: Record "Loan Charge Setup";
        LoanCollateralDetails: Record "Loan Collateral Details";
        ObjLoans: Record Loans;
        genjnlpostlineext: Codeunit "Gen. Jnl.-Post Lineext";
        Balancing: Boolean;
}