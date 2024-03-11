report 50446 "Payslip-Printing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayslipPrinting.rdlc';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            CalcFields = Picture;
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(Address2_CompanyInformation; "Company Information"."Address 2")
            {
            }
            column(City_CompanyInformation; "Company Information".City)
            {
            }
            column(PhoneNo_CompanyInformation; "Company Information"."Phone No.")
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
            dataitem(pr_employees; pr_employees)
            {
                DataItemTableView = WHERE (status = CONST (active));
                RequestFilterFields = "Period Filter", st_no;
                column(No; pr_employees.st_no)
                {
                }
                column(Name; pr_employees.Name)
                {
                }
                column(BankName; pr_employees.bank_name)
                {
                }
                column(BranchName; pr_employees.branch_name)
                {
                }
                column(BankAccNo; pr_employees.bank_account_no)
                {
                }
                column(NSSFNo; pr_employees.nssf_no)
                {
                }
                column(NHIFNo; pr_employees.nhif_no)
                {
                }
                column(PINNo; pr_employees.pin_no)
                {
                }
                column(UserId; UserId)
                {
                }
                column(Department; pr_employees.department_code)
                {
                }
                column(Period; Period)
                {
                }
                dataitem(pr_transactions; pr_transactions)
                {
                    DataItemLink = staff_no = FIELD (st_no), period_code = FIELD ("Period Filter");
                    column(TCode; pr_transactions.transaction_code)
                    {
                    }
                    column(TName; pr_transactions.transaction_name)
                    {
                    }
                    column(Amount; pr_transactions.amount)
                    {
                    }
                    column(Grouping; pr_transactions.group_title)
                    {
                    }
                    column(SubGroupOrder; pr_transactions.sub_group_order)
                    {
                    }
                    column(amount_prTransactions; amt)
                    {
                    }
                    column(SubtotalSalaries; SubtotalSalaries)
                    {
                    }
                    column(grouptitle_prtransactions; pr_transactions.group_title)
                    {
                    }
                    column(benefitstotal; benefitstotal)
                    {
                    }
                    column(Totalbenefitscaption; Totalbenefitscaption)
                    {
                    }
                    column(BenefitsTitle; BenefitsTitle)
                    {
                    }
                    column(balancescaption; Balances)
                    {
                    }
                    column(NSSF; NSSF)
                    {
                    }
                    column(NHIF; NHIF)
                    {
                    }
                    column(BANKNAME1; BANKNAME)
                    {
                    }
                    column(BANKBRANCH; BANKBRANCH)
                    {
                    }
                    column(ACCOUNTNO; ACCOUNTNO)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        amt := 0;
                        SubtotalSalaries := 0;
                        Totalbenefitscaption := '';
                        BenefitsTitle := '';
                        if pr_transactions.transaction_code = 'D005' then begin
                            loans.Reset;
                            loans.SetRange(loans."Loan  No.", pr_transactions."Loan No");
                            if loans.Find('-') then begin
                                loans.CalcFields(loans."Outstanding loan");
                                amt := loans."Outstanding loan";
                                Balances := 'Balances';
                            end;
                        end;
                        //ERROR('%1 is',amt);
                        if pr_transactions.transaction_name = 'Savings ' then begin
                            employee.Reset;
                            employee.SetRange(employee.st_no, pr_transactions.staff_no);
                            if employee.Find('-') then begin
                                employee.CalcFields(employee."Cummulative Savings");
                                amt := (employee."Cummulative Savings");
                                Balances := 'Balances';


                            end;
                        end;

                        benefitstotal := 0;
                        Transactions.Reset;
                        Transactions.SetRange(Transactions.staff_no, pr_transactions.staff_no);
                        Transactions.SetRange(Transactions.period_code, pr_transactions.period_code);
                        if Transactions.Find('-') then begin
                            repeat
                                if (Transactions.transaction_code = 'BPAY') or (Transactions.transaction_code = 'HALLOWANCE') or (Transactions.transaction_code = 'RETAINER') then
                                    SubtotalSalaries := SubtotalSalaries + Transactions.amount;
                                if Transactions.group_title = 'BENEFIT' then begin
                                    benefitstotal := benefitstotal + Transactions.amount;
                                    Totalbenefitscaption := 'Total Benefits';
                                    BenefitsTitle := 'Benefits';
                                end;
                            until Transactions.Next = 0;
                        end;


                        if employee.Get(pr_transactions.staff_no) then begin
                            NSSF := employee.nssf_no;
                            NHIF := employee.nhif_no;
                            BANKNAME := employee.bank_name;
                            BANKBRANCH := employee.branch_name;
                            ACCOUNTNO := employee.bank_account_no;
                        end;

                        // IF NSSF='' THEN
                        //  CurrReport.SKIP;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    Period := pr_employees.GetFilter("Period Filter");
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
        amt: Decimal;
        loans: Record "Staff Loans";
        employee: Record pr_employees;
        SubtotalSalaries: Decimal;
        Transactions: Record pr_transactions;
        benefitstotal: Decimal;
        Totalbenefitscaption: Text;
        BenefitsTitle: Text;
        Balances: Code[25];
        NSSF: Code[26];
        NHIF: Code[26];
        BANKNAME: Text;
        BANKBRANCH: Text;
        ACCOUNTNO: Code[25];
}

