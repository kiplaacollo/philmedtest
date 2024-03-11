report 50453 "NSSF contributions report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NSSFcontributionsreport.rdlc';

    dataset
    {
        dataitem(pr_transactions; pr_transactions)
        {
            DataItemTableView = WHERE (transaction_code = CONST ('NSSF'));
            RequestFilterFields = period_code;
            column(staffno_prtransactions; pr_transactions.staff_no)
            {
            }
            column(Name_prtransactions; pr_transactions.Name)
            {
            }
            column(NSSFNO; NSSFNO)
            {
            }
            column(amount_prtransactions; pr_transactions.amount)
            {
            }
            column(IDNO; IDNO)
            {
            }
            column(periodcode_prtransactions; pr_transactions.period_code)
            {
            }
            column(Amount; amount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Employees.Get(pr_transactions.staff_no) then begin
                    IDNO := Employees.id_no;
                    NSSFNO := Employees.nssf_no
                end;
                amount := (pr_transactions.amount * 2);
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
        Amount: Decimal;
        PERIOD: Record pr_periods;
        NSSFNO: Code[30];
        IDNO: Code[30];
        Employees: Record pr_employees;
}

