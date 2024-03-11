report 50424 "Transactions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransactionsReport.rdlc';

    dataset
    {
        dataitem(pr_transactions; pr_transactions)
        {
            RequestFilterFields = period_code, transaction_code;
            column(staffno_prtransactions; pr_transactions.staff_no)
            {
            }
            column(Name_prtransactions; pr_transactions.Name)
            {
            }
            column(transactioncode_prtransactions; pr_transactions.transaction_code)
            {
            }
            column(amount_prtransactions; pr_transactions.amount)
            {
            }
            column(periodcode_prtransactions; pr_transactions.period_code)
            {
            }
            column(transactionname_prtransactions; pr_transactions.transaction_name)
            {
            }
            column(transactionname; transactionname)
            {
            }

            trigger OnAfterGetRecord()
            begin
                transactionname := pr_transactions.transaction_name;
                if transactionname <> pr_transactions.transaction_name then
                    transactionname := '';
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
        transactionname: Text;
        TransactionCode: Code[30];
}

