report 50445 "Sacco Schedule Deductions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SaccoScheduleDeductions.rdlc';

    dataset
    {
        dataitem(pr_transactions; pr_transactions)
        {
            DataItemTableView = SORTING ("Loan No") ORDER(Ascending) WHERE ("Sacco Deduction" = FILTER (true));
            RequestFilterFields = period_code;
            column(staffno_prtransactions; pr_transactions.staff_no)
            {
            }
            column(Name_prtransactions; pr_transactions.Name)
            {
            }
            column(transactioncode_prtransactions; pr_transactions.transaction_code)
            {
            }
            column(grouptitle_prtransactions; pr_transactions.group_title)
            {
            }
            column(transactionreference_prtransactions; pr_transactions.transaction_reference)
            {
            }
            column(transactionname_prtransactions; pr_transactions.transaction_name)
            {
            }
            column(amount_prtransactions; pr_transactions.amount)
            {
            }
            column(grouporder_prtransactions; pr_transactions.group_order)
            {
            }
            column(subgrouporder_prtransactions; pr_transactions.sub_group_order)
            {
            }
            column(periodmonth_prtransactions; pr_transactions.period_month)
            {
            }
            column(periodyear_prtransactions; pr_transactions.period_year)
            {
            }
            column(periodcode_prtransactions; pr_transactions.period_code)
            {
            }
            column(glaccountno_prtransactions; pr_transactions.gl_account_no)
            {
            }
            column(status_prtransactions; pr_transactions.status)
            {
            }
            column(groupno_prtransactions; pr_transactions.group_no)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(LoanNo_prtransactions; pr_transactions."Loan No")
            {
            }
            column(LoanProductType_prtransactions; pr_transactions."Loan Product Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalDeductions := 0;
                prTransactions.Reset;
                prTransactions.SetRange(prTransactions.staff_no, pr_transactions.staff_no);
                prTransactions.SetRange(prTransactions."Sacco Deduction", true);
                if prTransactions.Find('-') then begin
                    repeat
                        TotalDeductions := TotalDeductions + prTransactions.amount;
                    until prTransactions.Next = 0;
                end;


                SumTotalDeductions := 0;
                Transactions.Reset;
                Transactions.SetRange(Transactions."Sacco Deduction", true);
                if Transactions.Find('-') then begin
                    repeat
                        SumTotalDeductions := SumTotalDeductions + Transactions.amount;
                    until prTransactions.Next = 0;
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
}

