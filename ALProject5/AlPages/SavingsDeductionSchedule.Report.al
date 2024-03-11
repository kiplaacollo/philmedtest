report 50444 "Savings Deduction Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SavingsDeductionSchedule.rdlc';

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
            column(LoanNo_prtransactions; pr_transactions."Loan No")
            {
            }
            column(amt; amt)
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
                column(FirstName_premployees; pr_employees."First Name")
                {
                }
                column(MiddleName_premployees; pr_employees."Middle Name")
                {
                }
                column(LastName_premployees; pr_employees."Last Name")
                {
                }
                column(idno_premployees; pr_employees.id_no)
                {
                }
                column(Name_premployees; pr_employees.Name)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if ((pr_transactions.transaction_code <> 'D007')) then
                    CurrReport.Skip;
                amt := 0;
                if prperiods.Get(period_code) then
                    if pr_transactions.transaction_code = 'D007' then begin
                        membledger.Reset;
                        membledger.SetRange(membledger."Customer No.", pr_transactions.staff_no);
                        membledger.SetFilter(membledger."Posting Date", '<=%1', prperiods.end_date);
                        if membledger.Find('-') then begin
                            repeat
                                if membledger."Transaction Type" = membledger."Transaction Type"::"Savings to Savings" then
                                    amt := amt + (membledger.Amount) * -1;

                            until membledger.Next = 0;
                        end;
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

    trigger OnPreReport()
    begin
        // IF UserSetup.GET(USERID) THEN
        // BEGIN
        // IF UserSetup."View Payroll"=FALSE THEN ERROR ('You dont have permissions for payroll, Contact your system administrator! ')
        // END;
    end;

    var
        UserSetup: Record "User Setup";
        membledger: Record "Member Ledger Entry";
        prperiods: Record pr_periods;
        amt: Decimal;
}

