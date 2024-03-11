report 50449 "Leave Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LeaveBalances.rdlc';

    dataset
    {
        dataitem(pr_employees; pr_employees)
        {
            RequestFilterFields = department_code;
            column(departmentcode_premployees; pr_employees.department_code)
            {
            }
            column(stno_premployees; pr_employees.st_no)
            {
            }
            column(Name_premployees; pr_employees.Name)
            {
            }
            column(LeaveBalance_premployees; pr_employees."Annual Leave Account")
            {
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

