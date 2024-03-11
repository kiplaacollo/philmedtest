report 50451 "Loans Schedule Deductions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoansScheduleDeductions.rdlc';

    dataset
    {
        dataitem("Loan Repayment Schedule"; "Loan Repayment Schedule")
        {
            RequestFilterFields = "Loan Category", "Repayment Date", "Period Filter";
            column(MemberNo_LoanRepaymentSchedule; "Loan Repayment Schedule"."Member No.")
            {
            }
            column(MemberName_LoanRepaymentSchedule; "Loan Repayment Schedule"."Member Name")
            {
            }
            column(PrincipalRepayment_LoanRepaymentSchedule; "Loan Repayment Schedule"."Principal Repayment")
            {
            }
            column(LoanCategory_LoanRepaymentSchedule; "Loan Repayment Schedule"."Loan Category")
            {
            }
            column(RepaymentDate_LoanRepaymentSchedule; "Loan Repayment Schedule"."Repayment Date")
            {
            }
            column(MonthlyInterest_LoanRepaymentSchedule; "Loan Repayment Schedule"."Monthly Interest")
            {
            }
            column(Period; Period)
            {
            }
            column(Name; Name)
            {
            }
            column(totalrepayments; totalrepayments)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Period := "Loan Repayment Schedule".GetFilter("Period Filter");
                if Period <> '' then begin
                    if Format("Loan Repayment Schedule"."Repayment Date") <> Period then
                        CurrReport.Skip;
                end;
                if employees.Get("Loan Repayment Schedule"."Member No.") then
                    Name := employees.Name;
                //ERROR('pfilter is %1',Period)
                totalrepayments := 0;
                loanbalance := 0;
                membledger.Reset;
                membledger.SetRange(membledger."Loan No", "Loan Repayment Schedule"."Loan No.");
                membledger.SetRange(membledger."Transaction Type", membledger."Transaction Type"::Repayment);
                if membledger.Find('-') then begin
                    repeat
                        totalrepayments := totalrepayments + (membledger.Amount) * -1;
                    until membledger.Next = 0;
                    totalrepayments := totalrepayments + "Loan Repayment Schedule"."Principal Repayment";
                end;
                if loans.Get("Loan Repayment Schedule"."Loan No.") then begin
                    loans.CalcFields(loans."Outstanding loan");
                    loanbalance := loans."Outstanding loan" - totalrepayments;
                    if loanbalance < 0 then
                        loanbalance := 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        UserSetup: Record "User Setup";
        prTransactions: Record pr_transactions;
        TotalDeductions: Decimal;
        SumTotalDeductions: Decimal;
        Transactions: Record pr_transactions;
        Period: Code[30];
        Name: Text;
        employees: Record pr_employees;
        membledger: Record "Member Ledger Entry";
        totalrepayments: Decimal;
        loans: Record "Staff Loans";
        loanbalance: Decimal;
}

