report 50430 "BANK Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BANKSchedule.rdlc';

    dataset
    {
        dataitem(pr_transactions; pr_transactions)
        {
            DataItemTableView = WHERE (transaction_code = CONST ('NPAY'));
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
            column(amount_prtransactions; pr_transactions.amount)
            {
            }
            column(periodcode_prtransactions; pr_transactions.period_code)
            {
            }
            column(transactionname_prtransactions; pr_transactions.transaction_name)
            {
            }
            dataitem(pr_employees; pr_employees)
            {
                DataItemLink = st_no = FIELD (staff_no);
                column(bankcode_premployees; pr_employees.bank_code)
                {
                }
                column(bankaccountno_premployees; pr_employees.bank_account_no)
                {
                }
                column(branchcode_premployees; pr_employees.branch_code)
                {
                }
                column(bankname_premployees; pr_employees.bank_name)
                {
                }
            }
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
}

