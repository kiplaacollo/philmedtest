report 50467 "Equity Bank  Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './EquityBankReport.rdlc';

    dataset
    {
        dataitem(pr_transactions; pr_transactions)
        {
            DataItemTableView = SORTING (group_order, sub_group_order) ORDER(Ascending) WHERE (transaction_code = CONST ('NPAY'));
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
            column(NetPay; NetPay)
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
                column(Name_premployees; pr_employees.Name)
                {
                }
                column(FirstName_premployees; pr_employees."First Name")
                {
                }
                column(LastName_premployees; pr_employees."Last Name")
                {
                }
                column(bankaccountno_premployees; pr_employees.bank_account_no)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                //IF pr_employees.bank_code<>'068' THEN
                // CurrReport.SKIP;

                NetPay := 0;
                ptrans.Reset;
                ptrans.SetRange(ptrans.staff_no, pr_transactions.staff_no);
                ptrans.SetRange(ptrans.period_code, pr_transactions.period_code);
                ptrans.SetFilter(ptrans.transaction_code, 'NPAY');
                if ptrans.Find('-') then
                    NetPay := ptrans.amount;


                if Employee.Get(pr_transactions.staff_no) then begin
                    if Employee.bank_code <> '068' then
                        CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //IF ((pr_transactions.transaction_code<>'NPAY'))  THEN
                //CurrReport.SKIP;

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
        if UserSetup.Get(UserId) then begin
            if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
    end;

    var
        UserSetup: Record "User Setup";
        NetPay: Decimal;
        ptrans: Record pr_transactions;
        Employee: Record pr_employees;
}

