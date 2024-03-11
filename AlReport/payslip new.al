report 50420 Payslip
{
    // version Payroll Management v1.0.0

    DefaultLayout = RDLC;
    RDLCLayout = './Payslip.rdlc';

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
                column(JobGroup_premployees;pr_employees."Job Group")
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
                    column(amount_prTransactions;amt)
                    {
                    }
                    column(SubtotalSalaries;SubtotalSalaries)
                    {
                    }
                    column(grouptitle_prtransactions;pr_transactions.group_title)
                    {
                    }
                    column(benefitstotal;benefitstotal)
                    {
                    }
                    column(Totalbenefitscaption;Totalbenefitscaption)
                    {
                    }
                    column(BenefitsTitle;BenefitsTitle)
                    {
                    }
                    column(balancescaption;Balances)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Period:=pr_employees.GetFilter("Period Filter");
                         if prperiods.Get(Period) then
                        Balances:='';
                        amt:=0;
                        SubtotalSalaries:=0;
                        Totalbenefitscaption:='';
                        BenefitsTitle:='';
                        if pr_transactions.transaction_code='D005' then  begin

                         loans.Reset;
                         loans.SetRange(loans."Loan  No.",pr_transactions."Loan No");
                         if loans.Find('-') then begin
                           loans.CalcFields(loans."Defined Contribution");
                         // amt:=loans."Outstanding loan";
                         amt:=0;

                          Balances:='Balances';
                          membledger.RESET;
                          membledger.SETRANGE(membledger."Loan No",loans."Loan  No.");
                          membledger.SETFILTER(membledger."Posting Date",'<=%1',prperiods.end_date);
                          if membledger.FIND('-') then begin
                            repeat
                              if (membledger."Transaction Type"=membledger."Transaction Type"::"2") or
                                (membledger."Transaction Type"=membledger."Transaction Type"::"3") then
                            amt:=amt+membledger.Amount;

                              until membledger.NEXT=0;
                            end;
                        end ;
                        end;
                        if pr_transactions.transaction_code='D006' then
                          Balances:='';
                        //MESSAGE('pr_transactions %1',pr_transactions.transaction_name);
                        if pr_transactions.transaction_name='Savings ' then  begin

                         employee.Reset;
                         employee.SetRange(employee.st_no,pr_transactions.staff_no);
                         if employee.Find('-') then begin
                           employee.CalcFields(employee."Cummulative Savings");
                         // amt:=(employee."Cummulative Savings");
                            Balances:='Balances';
                           // ERROR('%1 iss',amt);
                          membledger.RESET;
                          membledger.SETRANGE(membledger."Customer No.",pr_transactions.staff_no);
                          membledger.SETFILTER(membledger."Posting Date",'<=%1',prperiods.end_date);
                          if membledger.FIND('-') then begin
                            repeat
                              if (membledger."Transaction Type"=membledger."Transaction Type"::"46") then
                            amt:=amt+(membledger.Amount)*-1;

                              until membledger.NEXT=0;
                            end;

                        end ;
                        end;

                        benefitstotal:=0;
                        Transactions.Reset;
                        Transactions.SetRange(Transactions.staff_no,pr_transactions.staff_no);
                        Transactions.SetRange(Transactions.period_code,pr_transactions.period_code);
                        if Transactions.Find('-') then begin
                          repeat
                            if (Transactions.transaction_code='BPAY') or (Transactions.transaction_code='HALLOWANCE') or  (Transactions.transaction_code='RETAINER') then
                               SubtotalSalaries:=SubtotalSalaries+Transactions.amount;
                            if Transactions.group_title='BENEFIT' then begin
                              benefitstotal:=benefitstotal+Transactions.amount;
                              Totalbenefitscaption:='Total Benefits';
                              BenefitsTitle:='Benefits';
                              end;
                              until Transactions.Next=0;
                        end;

                        //Check Savings
                        if pr_transactions.transaction_name='Savings' then  begin
                         employee.CalcFields(employee."Cummulative Savings");
                         // amt:=(employee."Cummulative Savings");
                            Balances:='Balances';
                            amt:=0;
                           // ERROR('%1 iss',amt);
                          membledger.RESET;
                          membledger.SETRANGE(membledger."Customer No.",pr_transactions.staff_no);
                          membledger.SETFILTER(membledger."Posting Date",'<=%1',prperiods.end_date);
                          if membledger.FIND('-') then begin
                            repeat
                              if (membledger."Transaction Type"=membledger."Transaction Type"::"46") then
                            amt:=amt+(membledger.Amount)*-1;

                              until membledger.NEXT=0;
                            end;

                        end ;
                    end;
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
        amt: Decimal;
        loans: Record "Payroll Employee P9..";
        employee: Record pr_employees;
        SubtotalSalaries: Decimal;
        Transactions: Record pr_transactions;
        benefitstotal: Decimal;
        Totalbenefitscaption: Text;
        BenefitsTitle: Text;
        Balances: Code[25];
        membledger: Record Table50433;
        prperiods: Record pr_periods;
}

