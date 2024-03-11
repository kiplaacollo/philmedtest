report 50429 "Send Payslips"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(pr_employees; pr_employees)
        {
            RequestFilterFields = "Period Filter";
            column(stno_premployees; pr_employees.st_no)
            {
            }
            column(Name_premployees; pr_employees.Name)
            {
            }
            column(employeeemail_premployees; pr_employees.employee_email)
            {
            }

            trigger OnAfterGetRecord()
            begin


                Objpremployees.Reset;
                Objpremployees.SetRange(Objpremployees.st_no, pr_employees.st_no);
                Objpremployees.SetRange(Objpremployees."Period Filter", Period);
                if Objpremployees.Find('-') then begin
                    if Objpremployees.employee_email <> '' then begin
                        Filename := '';
                        Filename := SMTPSetup."Path to Save Payslips" + 'PAYSLIP-' + Objpremployees.st_no + '.pdf';
                        REPORT.SaveAsPdf(REPORT::Payslip, Filename, Objpremployees);

                        CFTFactory.FnSendPayslipMail(Filename, 'Dear ' + Format(Objpremployees.Name) + ',<br>Please find attached your Payslip for the period ' + Period + ',<br>Regards',
                        Objpremployees.employee_email, 'PAYSLIP-' + Period);

                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Payslip for period ' + Period + ' successfully sent.');
            end;

            trigger OnPreDataItem()
            begin
                Period := pr_employees.GetFilter("Period Filter");
                if Period = '' then
                    Error('Kindly set the Period to Continue');
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
        SMTPSetup.Get;
    end;

    var
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        Filename: Text;
        Period: Code[50];
        Objpremployees: Record pr_employees;
        CFTFactory: Codeunit "CFT Factory";
}

