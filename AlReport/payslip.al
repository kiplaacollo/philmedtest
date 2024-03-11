report 50420 Payslip
{
    // version Payroll Management v1.0.0

    DefaultLayout = RDLC;
    RDLCLayout = './Payslip.rdl';

    dataset
    {
        dataitem("Company Information";"Company Information")
        {
            CalcFields = Picture;
            column(Name_CompanyInformation;"Company Information".Name)
            {
            }
            column(Address_CompanyInformation;"Company Information".Address)
            {
            }
            column(Address2_CompanyInformation;"Company Information"."Address 2")
            {
            }
            column(City_CompanyInformation;"Company Information".City)
            {
            }
            column(PhoneNo_CompanyInformation;"Company Information"."Phone No.")
            {
            }
            column(Picture_CompanyInformation;"Company Information".Picture)
            {
            }
            dataitem(pr_employees;pr_employees)
            {
                RequestFilterFields = st_no,"Period Filter";
                column(No;pr_employees.st_no)
                {
                }
                column(Name;pr_employees.Name)
                {
                }
                column(BankName;pr_employees.bank_name)
                {
                }
                column(BranchName;pr_employees.branch_name)
                {
                }
                column(BankAccNo;pr_employees.bank_account_no)
                {
                }
                column(NSSFNo;pr_employees.nssf_no)
                {
                }
                column(NHIFNo;pr_employees.nhif_no)
                {
                }
                column(PINNo;pr_employees.pin_no)
                {
                }
                column(UserId;UserId)
                {
                }
                column(Department;pr_employees.department_code)
                {
                }
                column(Period;Period)
                {
                }
                dataitem(pr_transactions;pr_transactions)
                {
                    DataItemLink = staff_no=FIELD(st_no),period_code=FIELD("Period Filter");
                    column(TCode;pr_transactions.transaction_code)
                    {
                    }
                    column(TName;pr_transactions.transaction_name)
                    {
                    }
                    column(Amount;pr_transactions.amount)
                    {
                    }
                    column(Grouping;pr_transactions.group_title)
                    {
                    }
                    column(SubGroupOrder;pr_transactions.sub_group_order)
                    {
                    }
                }

                trigger OnPreDataItem()
                begin
                    Period:=pr_employees.GetFilter("Period Filter");
                end;
            }
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
        Period: Code[100];
}

