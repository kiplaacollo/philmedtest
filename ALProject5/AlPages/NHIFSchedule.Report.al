report 50427 "NHIF Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NHIFSchedule.rdlc';

    dataset
    {
        dataitem(pr_transactions; pr_transactions)
        {
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
            dataitem(pr_employees; pr_employees)
            {
                DataItemLink = st_no = FIELD (staff_no);
                column(nssfno_premployees; pr_employees.nssf_no)
                {
                }
                column(nhifno_premployees; pr_employees.nhif_no)
                {
                }
                column(pinno_premployees; pr_employees.pin_no)
                {
                }
                column(idno_premployees; pr_employees.id_no)
                {
                }
                column(FirstName_premployees; pr_employees."First Name")
                {
                }
                column(MiddleName_premployees; pr_employees."Middle Name")
                {
                }
                column(LastName_premployees; pr_employees."Last Name")
                {
                }
                column(name; Name)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Name := '';
                    Name := pr_employees."First Name" + ' ' + pr_employees."Middle Name";
                end;
            }

            trigger OnPreDataItem()
            begin
                if ((pr_transactions.transaction_code <> 'PAYE') or (pr_transactions.transaction_code <> 'TXBP')) then
                    CurrReport.Skip;
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

    trigger OnPreReport()
    begin
        // IF UserSetup.GET(USERID) THEN
        // BEGIN
        // IF UserSetup."View Payroll"=FALSE THEN ERROR ('You dont have permissions for payroll, Contact your system administrator! ')
        // END;
    end;

    var
        UserSetup: Record "User Setup";
        name: Code[30];
}

