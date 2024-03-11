report 50437 "NSSF contributions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NSSFcontributions.rdlc';

    dataset
    {
        dataitem(pr_employees; pr_employees)
        {
            column(stno_premployees; pr_employees.st_no)
            {
            }
            column(Name_premployees; pr_employees.Name)
            {
            }
            column(nssfno_premployees; pr_employees.nssf_no)
            {
            }
            column(Amount; Amount)
            {
            }
            column(idno_premployees; pr_employees.id_no)
            {
            }
            dataitem(pr_periods; pr_periods)
            {
                RequestFilterFields = period_code;
                column(periodcode_prperiods; pr_periods.period_code)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Amount := 400;

                if pr_employees.status <> pr_employees.status::active then
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

    var
        Amount: Decimal;
        PERIOD: Record pr_periods;
}

