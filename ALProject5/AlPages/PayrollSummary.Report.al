report 50421 "Payroll Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollSummary.rdlc';

    dataset
    {
        dataitem(pr_employees; pr_employees)
        {
            RequestFilterFields = department_code;
            column(departmentcode_premployees; pr_employees.department_code)
            {
            }
            dataitem(pr_transactions; pr_transactions)
            {
                DataItemLink = staff_no = FIELD (st_no);
                DataItemTableView = SORTING (group_order, sub_group_order) ORDER(Ascending);
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

    var
        UserSetup: Record "User Setup";
}

