report 50440 P9Report
{
    DefaultLayout = RDLC;
    RDLCLayout = './P9Report.rdl';

    dataset
    {
        dataitem(pr_employees;pr_employees)
        {
            RequestFilterFields = st_no;
            column(CName;CompanyInfo.Name)
            {
            }
            column(CAddress;CompanyInfo.Address)
            {
            }
            column(CPic;CompanyInfo.Picture)
            {
            }
            column(TaxRegNo;CompanyInfo."VAT Registration No.")
            {
            }
            column(stno_premployees;pr_employees.st_no)
            {
            }
            column(FirstName_premployees;pr_employees."First Name")
            {
            }
            column(MiddleName_premployees;pr_employees."Middle Name")
            {
            }
            column(LastName_premployees;pr_employees."Last Name")
            {
            }
            column(SearchName_HREmployees;pr_employees."Middle Name")
            {
            }
            column(PostalAddress_HREmployees;pr_employees.st_no)
            {
            }
            column(ResidentialAddress_HREmployees;pr_employees.st_no)
            {
            }
            column(PIN;PINNo)
            {
            }
            column(TotalH;TotalH)
            {
            }
            column(TotalL;TotalL)
            {
            }
            dataitem("Payroll Employee P9..";"Payroll Employee P9..")
            {
                DataItemLink = "Employee Code"=FIELD(st_no);
                RequestFilterFields = "Period Year";
                column(PensionAmt;PensionAmt)
                {
                }
                column(PenNSSF;PenNSSF)
                {
                }
                column(EmployeeCode_PayrollEmployeeP9;"Payroll Employee P9.."."Employee Code")
                {
                }
                column(BasicPay_PayrollEmployeeP9;"Payroll Employee P9.."."Basic Pay")
                {
                }
                column(Allowances_PayrollEmployeeP9;"Payroll Employee P9..".Allowances)
                {
                }
                column(Benefits_PayrollEmployeeP9;"Payroll Employee P9..".Benefits)
                {
                }
                column(ValueOfQuarters_PayrollEmployeeP9;"Payroll Employee P9.."."Value Of Quarters")
                {
                }
                column(DefinedContribution_PayrollEmployeeP9;"Payroll Employee P9.."."Defined Contribution")
                {
                }
                column(OwnerOccupierInterest_PayrollEmployeeP9;"Payroll Employee P9.."."Owner Occupier Interest")
                {
                }
                column(GrossPay_PayrollEmployeeP9;"Payroll Employee P9.."."Gross Pay")
                {
                }
                column(TaxablePay_PayrollEmployeeP9;"Payroll Employee P9.."."Taxable Pay")
                {
                }
                column(TaxCharged_PayrollEmployeeP9;"Payroll Employee P9.."."Tax Charged")
                {
                }
                column(InsuranceRelief_PayrollEmployeeP9;"Payroll Employee P9.."."Insurance Relief")
                {
                }
                column(TaxRelief_PayrollEmployeeP9;"Payroll Employee P9.."."Tax Relief")
                {
                }
                column(PAYE_PayrollEmployeeP9;"Payroll Employee P9..".PAYE)
                {
                }
                column(NSSF_PayrollEmployeeP9;"Payroll Employee P9..".NSSF)
                {
                }
                column(NHIF_PayrollEmployeeP9;"Payroll Employee P9..".NHIF)
                {
                }
                column(Deductions_PayrollEmployeeP9;"Payroll Employee P9..".Deductions)
                {
                }
                column(NetPay_PayrollEmployeeP9;"Payroll Employee P9.."."Net Pay")
                {
                }
                column(PeriodMonth_PayrollEmployeeP9;"Payroll Employee P9.."."Period Month")
                {
                }
                column(PeriodYear_PayrollEmployeeP9;"Payroll Employee P9.."."Period Year")
                {
                }
                column(PayrollPeriod_PayrollEmployeeP9;"Payroll Employee P9.."."Payroll Period")
                {
                }
                column(PeriodFilter_PayrollEmployeeP9;"Payroll Employee P9.."."Period Filter")
                {
                }
                column(Pension_PayrollEmployeeP9;"Payroll Employee P9..".Pension)
                {
                }
                column(HELB_PayrollEmployeeP9;"Payroll Employee P9..".HELB)
                {
                }
                column(PayrollCode_PayrollEmployeeP9;"Payroll Employee P9.."."Payroll Code")
                {
                }
                column(MonthText;MonthText)
                {
                }
                column(ColG;ColG)
                {
                }
                column(Grosspay_ColG;"Payroll Employee P9.."."Gross Pay"-ColG)
                {
                }
                column(FixedContribution;FixedContribution)
                {
                }
                column(Amount3;Amount3)
                {
                }
                column(Amount1;Amount1)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE('%1',"Payroll Employee P9".Pension);
                    PensionAmt:=0;
                    NSSFAmt:=0;
                    PenNSSF:=0;
                    PensionAmt:="Payroll Employee P9..".Pension;
                    NSSFAmt:="Payroll Employee P9..".NSSF;
                    PenNSSF:=PensionAmt;
                    if PenNSSF=0 then
                    PenNSSF:=NSSFAmt;



                    case "Period Month" of
                      1:
                        MonthText:='January';
                      2:
                        MonthText:='February';
                      3:
                        MonthText:='March';
                      4:
                        MonthText:='April';
                      5:
                        MonthText:='May';
                      6:
                        MonthText:='June';
                      7:
                        MonthText:='July';
                      8:
                        MonthText:='August';
                      9:
                        MonthText:='September';
                      10:
                        MonthText:='October';
                      11:
                        MonthText:='November';
                      12:
                        MonthText:='December';
                      else
                        MonthText:='';
                        end;

                    if (NSSF)>20000 then
                     begin
                      ColG:=20000+"Owner Occupier Interest";
                     end
                    else
                     begin
                      ColG:=(NSSF)+"Owner Occupier Interest";
                     end;
                    FixedContribution:=20000;
                    HTotal:="Gross Pay"-ColG;

                    Amount1:=0;
                    Amount2:=0;
                    Amount3:=0;
                    if PenNSSF<FixedContribution then
                    Amount1:=PenNSSF
                    else if FixedContribution<PenNSSF then
                    Amount1:=FixedContribution;

                    Amount2:=Amount1+"Payroll Employee P9.."."Owner Occupier Interest";
                    Amount3:="Payroll Employee P9.."."Gross Pay"-Amount2;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PINNo:='';
                PayrollEmployeee.Reset;
                PayrollEmployeee.SetRange(PayrollEmployeee.st_no,pr_employees.st_no);
                if PayrollEmployeee.Find ('-') then
                PINNo:=PayrollEmployeee.pin_no;
                TotaA:=0;
                TotalB:=0;
                totalC:=0;
                totalD:=0;
                TotalE1:=0;
                TotalE2:=0;
                TotalE3:=0;
                TotalF:=0;
                TotalG:=0;
                TotalH:=0;
                TotalJ:=0;
                TotalK:=0;
                TotalL:=0;
                P9.Reset;
                P9.SetRange(P9."Employee Code",st_no);
                P9.SetRange(P9."Period Year",2016);
                if P9.Find('-') then
                 begin
                  repeat
                   TotaA:=TotaA+P9."Basic Pay";
                   TotalB:=TotalB+P9.Benefits;
                   totalC:=totalC+P9."Value Of Quarters";
                   totalD:=totalD+P9."Gross Pay";
                   TotalE1:=TotalE1+(P9."Basic Pay"*0.3);
                   TotalE2:=TotalE2+(P9.NSSF);
                   TotalE3:=TotalE3+20000;
                   TotalF:=TotalF+P9."Owner Occupier Interest";
                   if P9.NSSF<20000 then begin
                    TotalH:=TotalH+(P9."Gross Pay"-(P9.NSSF));
                   end else begin
                     TotalH:=TotalH+(P9."Gross Pay"-20000);
                   end;
                   TotalJ:=TotalJ+P9."Tax Charged";
                   TotalK:=TotalK+(P9."Tax Relief"+P9."Insurance Relief");
                   TotalL:=TotalL+P9.PAYE;
                  until P9.Next=0;
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
        MonthText: Text;
        ObjUserSetup: Record "User Setup";
        ColG: Decimal;
        FixedContribution: Decimal;
        HTotal: Decimal;
        TotaA: Decimal;
        TotalB: Decimal;
        totalC: Decimal;
        totalD: Decimal;
        TotalE1: Decimal;
        TotalE2: Decimal;
        TotalE3: Decimal;
        TotalF: Decimal;
        TotalG: Decimal;
        TotalH: Decimal;
        TotalI: Decimal;
        TotalJ: Decimal;
        TotalK: Decimal;
        TotalL: Decimal;
        P9: Record "Payroll Employee P9..";
        PensionAmt: Decimal;
        NSSFAmt: Decimal;
        PenNSSF: Decimal;
        Amount1: Decimal;
        Amount2: Decimal;
        Amount3: Decimal;
        PayrollEmployeee: Record pr_employees;
        PINNo: Code[20];
        CompanyInfo: Record "Company Information";
}

