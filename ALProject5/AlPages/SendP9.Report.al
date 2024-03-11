report 59064 "Send P9"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SendP9.rdlc';

    dataset
    {
        dataitem(pr_employees; pr_employees)
        {
            DataItemTableView = WHERE (status = FILTER (active));

            trigger OnAfterGetRecord()
            begin
                if Year = 0 then
                    Error('You must specify the Year for which you want to Send P9 reports');




                SMTPSetup.Get;




                Employee.Reset;
                Employee.SetRange(Employee.st_no, pr_employees.st_no);
                if Employee.Find('-') then begin
                    if Employee.employee_email <> '' then begin
                        payrollP9.Reset;
                        payrollP9.SetRange(payrollP9."Employee Code", Employee.st_no);
                        payrollP9.SetRange(payrollP9."Period Year", Year);
                        if payrollP9.Find('-') then begin
                            //IF EXISTS(Filename) THEN
                            //ERASE(Filename);
                            Filename := '';
                            Filename := SMTPSetup."Path to Save Payslips" + (payrollP9."Employee Code") + ' p9report.pdf ';
                            REPORT.SaveAsPdf(REPORT::P9Reports, Filename, payrollP9);

                            CFTFactory.FnSendPayslipMail(Filename, 'Dear ' + Format(Employee.Name) + ',<br>Please find attached your P9 for the year ' + Format(Year) + ',<br>Regards',
                             Employee.employee_email, 'P9-' + Format(Year));
                        end;

                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Year; Year)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Year: Integer;
        SMTPSetup: Record "SMTP Mail Setup";
        payrollP9: Record "Payroll Employee P9.";
        Filename: Text;
        Employee: Record pr_employees;
        CFTFactory: Codeunit "CFT Factory";
}

