report 50438 "Save All Payslips"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SaveAllPayslips.rdlc';

    dataset
    {
        dataitem(pr_periods; pr_periods)
        {
            RequestFilterFields = period_code;
        }
        dataitem(pr_employees; pr_employees)
        {

            trigger OnAfterGetRecord()
            begin
                Objpremployees.Reset;
                Objpremployees.SetRange(Objpremployees.st_no, pr_employees.st_no);
                Objpremployees.SetRange(Objpremployees."Period Filter", pr_periods.period_code);
                if Objpremployees.Find('-') then begin
                    Filename := '';
                    Filename := 'C:\Users\Edwin\Pictures\All payslips' + Objpremployees.st_no + '.pdf';//E:\payslips\
                    REPORT.SaveAsPdf(REPORT::Payslip, Filename, Objpremployees);
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
        Objpremployees: Record pr_employees;
        Filename: Text;
}

