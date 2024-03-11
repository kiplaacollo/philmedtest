report 50441 "Update P9Rports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UpdateP9Rports.rdlc';

    dataset
    {
        dataitem(pr_transactions; pr_transactions)
        {

            trigger OnAfterGetRecord()
            begin

                ObjP9Periods.Reset;
                ObjP9Periods.SetRange(ObjP9Periods."Employee Code", pr_transactions.staff_no);
                ObjP9Periods.SetRange(ObjP9Periods.period_code, pr_transactions.period_code);
                //ObjP9Periods.SETRANGE(ObjP9Periods."Period Year","Period Year");
                if ObjP9Periods.Find('-') then begin
                    if group_title = 'ALLOWANCE' then
                        ObjP9Periods.Allowances := amount;
                    if group_title = 'BENEFIT' then
                        ObjP9Periods.Benefits := amount;

                    case transaction_code of
                        'BPAY':
                            ObjP9Periods."Basic Pay" := amount;
                        'GPAY':
                            ObjP9Periods."Gross Pay" := amount;
                        'INSURELIEF':
                            ObjP9Periods."Insurance Relief" := amount;
                        'TXCHRG':
                            ObjP9Periods."Tax Charged" := amount;
                        'PAYE':
                            ObjP9Periods.PAYE := amount;
                        'PERR':
                            ObjP9Periods."Tax Relief" := amount;
                        'NPAY':
                            ObjP9Periods."Net Pay" := amount;
                        'PSNR':
                            ObjP9Periods."Tax Relief" := amount;
                        'HALLOWANCE':
                            ObjP9Periods."Basic Pay" := ObjP9Periods."Basic Pay" + amount;
                        else
                    end;

                    //      IF pr_transactions.is
                    // IF ObjP9Periods."Employee Code"='010' THEN
                    //   ERROR('bpay %1',ObjP9Periods."Basic Pay");
                    ObjP9Periods.Modify;
                end

            end;

            trigger OnPreDataItem()
            begin
                //pr_transactions.transaction_code
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
        ObjPayrollTransactions.Reset;
        if ObjPayrollTransactions.Find('-') then begin
            repeat

                ObjP9Periods.Reset;
                ObjP9Periods.SetRange(ObjP9Periods."Employee Code", ObjPayrollTransactions.staff_no);
                ObjP9Periods.SetRange(ObjP9Periods.period_code, ObjPayrollTransactions.period_code);
                if not ObjP9Periods.Find('-') then begin
                    ObjP9Periods.Init;
                    ObjP9Periods."Employee Code" := ObjPayrollTransactions.staff_no;
                    ObjP9Periods.period_code := ObjPayrollTransactions.period_code;
                    ObjP9Periods."Period Month" := ObjPayrollTransactions.period_month;
                    ObjP9Periods."Period Year" := ObjPayrollTransactions.period_year;
                    ObjP9Periods.Insert;
                end;
            until ObjPayrollTransactions.Next = 0;
        end
    end;

    var
        ObjP9Periods: Record "Payroll Employee P9.";
        ObjPayrollTransactions: Record pr_transactions;
}

