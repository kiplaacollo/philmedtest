report 50448 Periods
{
    DefaultLayout = RDLC;
    RDLCLayout = './Periods.rdlc';

    dataset
    {
        dataitem(pr_periods; pr_periods)
        {
            DataItemTableView = WHERE (Closed = CONST (true));
            column(periodcode_prperiods; pr_periods.period_code)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SelectedPeriod := pr_periods.period_code;



                SMTPSetup.Get;
                CompInfo.Get();
                Emps.Reset;
                Emps.SetRange(Emps.status, Emps.status::active);
                if Emps.Find('-') then begin
                    if Emps.employee_email <> '' then
                        repeat
                            SalCard.Reset;
                            ;
                            SalCard.SetRange(SalCard."Period Filter", SelectedPeriod);
                            if SalCard.Find('-') then begin
                                Filename := SMTPSetup."Path to Save Payslips" + 'Payslips.pdf';
                                REPORT.SaveAsPdf(REPORT::"Payslip-Printing", Filename, SalCard);
                            end;
                        until Emps.Next = 0;
                end;
                Message('Payslips Saved Successfully,you can get them at %1', SMTPSetup."Path to Save Payslips");
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
        Emps: Record pr_employees;
        SalCard: Record pr_employees;
        SelectedPeriod: Code[20];
        SMTPSetup: Record "SMTP Mail Setup";
        CompInfo: Record "Company Information";
        Filename: Text;
}

