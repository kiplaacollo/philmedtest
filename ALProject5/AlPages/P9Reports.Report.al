report 50452 P9Reports
{
    DefaultLayout = RDLC;
    RDLCLayout = './P9Reports.rdlc';

    dataset
    {
        dataitem("Payroll Employee P9."; "Payroll Employee P9.")
        {
            DataItemTableView = SORTING ("Employee Code", period_code) ORDER(Descending);
            RequestFilterFields = "Period Year";
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(TaxRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(PIN; PINNo)
            {
            }
            column(TotalH; TotalH)
            {
            }
            column(TotalL; TotalL)
            {
            }
            column(firstname; firstname)
            {
            }
            column(Lastname; Lastname)
            {
            }
            column(PensionAmt; PensionAmt)
            {
            }
            column(PenNSSF; PenNSSF)
            {
            }
            column(EmployeeCode_PayrollEmployeeP9; "Payroll Employee P9."."Employee Code")
            {
            }
            column(BasicPay_PayrollEmployeeP9; "Payroll Employee P9."."Basic Pay")
            {
            }
            column(Allowances_PayrollEmployeeP9; "Payroll Employee P9.".Allowances)
            {
            }
            column(Benefits_PayrollEmployeeP9; "Payroll Employee P9.".Benefits)
            {
            }
            column(ValueOfQuarters_PayrollEmployeeP9; "Payroll Employee P9."."Value Of Quarters")
            {
            }
            column(DefinedContribution_PayrollEmployeeP9; "Payroll Employee P9."."Defined Contribution")
            {
            }
            column(OwnerOccupierInterest_PayrollEmployeeP9; "Payroll Employee P9."."Owner Occupier Interest")
            {
            }
            column(GrossPay_PayrollEmployeeP9; "Payroll Employee P9."."Gross Pay")
            {
            }
            column(TaxablePay_PayrollEmployeeP9; "Payroll Employee P9."."Taxable Pay")
            {
            }
            column(TaxCharged_PayrollEmployeeP9; "Payroll Employee P9."."Tax Charged")
            {
            }
            column(InsuranceRelief_PayrollEmployeeP9; "Payroll Employee P9."."Insurance Relief")
            {
            }
            column(TaxRelief_PayrollEmployeeP9; "Payroll Employee P9."."Tax Relief")
            {
            }
            column(PAYE_PayrollEmployeeP9; "Payroll Employee P9.".PAYE)
            {
            }
            column(NSSF_PayrollEmployeeP9; "Payroll Employee P9.".NSSF)
            {
            }
            column(NHIF_PayrollEmployeeP9; "Payroll Employee P9.".NHIF)
            {
            }
            column(Deductions_PayrollEmployeeP9; "Payroll Employee P9.".Deductions)
            {
            }
            column(NetPay_PayrollEmployeeP9; "Payroll Employee P9."."Net Pay")
            {
            }
            column(PeriodMonth_PayrollEmployeeP9; "Payroll Employee P9."."Period Month")
            {
            }
            column(PeriodYear_PayrollEmployeeP9; "Payroll Employee P9."."Period Year")
            {
            }
            column(PayrollPeriod_PayrollEmployeeP9; "Payroll Employee P9."."Payroll Period")
            {
            }
            column(PeriodFilter_PayrollEmployeeP9; "Payroll Employee P9."."Period Filter")
            {
            }
            column(Pension_PayrollEmployeeP9; "Payroll Employee P9.".Pension)
            {
            }
            column(HELB_PayrollEmployeeP9; "Payroll Employee P9.".HELB)
            {
            }
            column(PayrollCode_PayrollEmployeeP9; "Payroll Employee P9."."Payroll Code")
            {
            }
            column(MonthText; MonthText)
            {
            }
            column(ColG; ColG)
            {
            }
            column(Grosspay_ColG; "Payroll Employee P9."."Gross Pay" - ColG)
            {
            }
            column(FixedContribution; FixedContribution)
            {
            }
            column(Amount3; Amount3)
            {
            }
            column(Amount1; Amount1)
            {
            }
            column(basicpay; basicpay)
            {
            }
            column(TotalGross; TotalGross)
            {
            }

            trigger OnAfterGetRecord()
            begin
                firstname := '';
                Lastname := '';
                PINNo := '';
                PayrollEmployeee.Reset;
                PayrollEmployeee.SetRange(PayrollEmployeee.st_no, "Payroll Employee P9."."Employee Code");
                if PayrollEmployeee.Find('-') then begin
                    firstname := PayrollEmployeee."First Name" + PayrollEmployeee."Middle Name";
                    Lastname := PayrollEmployeee."Last Name";
                    PINNo := PayrollEmployeee.pin_no;
                end;
                CompanyInfo.Get();
                if "Payroll Employee P9."."Period Year" <> "Payroll Employee P9."."Period Year" then
                    CurrReport.Skip;
                PensionAmt := 0;
                NSSFAmt := 0;
                PenNSSF := 0;
                PensionAmt := "Payroll Employee P9.".Pension;
                NSSFAmt := "Payroll Employee P9.".NSSF;
                PenNSSF := PensionAmt;
                if PenNSSF = 0 then
                    PenNSSF := NSSFAmt;



                case "Period Month" of
                    1:
                        MonthText := 'January';
                    2:
                        MonthText := 'February';
                    3:
                        MonthText := 'March';
                    4:
                        MonthText := 'April';
                    5:
                        MonthText := 'May';
                    6:
                        MonthText := 'June';
                    7:
                        MonthText := 'July';
                    8:
                        MonthText := 'August';
                    9:
                        MonthText := 'September';
                    10:
                        MonthText := 'October';
                    11:
                        MonthText := 'November';
                    12:
                        MonthText := 'December';
                    else
                        MonthText := '';
                end;

                if (NSSF) > 20000 then begin
                    ColG := 20000 + "Owner Occupier Interest";
                end
                else begin
                    ColG := (NSSF) + "Owner Occupier Interest";
                end;
                FixedContribution := 20000;
                HTotal := "Gross Pay" - ColG;

                Amount1 := 0;
                Amount2 := 0;
                Amount3 := 0;
                if PenNSSF < FixedContribution then
                    Amount1 := PenNSSF
                else
                    if FixedContribution < PenNSSF then
                        Amount1 := FixedContribution;
                Amount1 := 200;
                PenNSSF := 200;
                Amount2 := Amount1 + "Payroll Employee P9."."Owner Occupier Interest";

                basicpay := "Payroll Employee P9."."Basic Pay" + "Payroll Employee P9.".Allowances;

                TotalGross := basicpay + "Payroll Employee P9.".Benefits + "Payroll Employee P9."."Value Of Quarters";
                Amount3 := TotalGross - Amount2;
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
        P9: Record "Payroll Employee P9.";
        PensionAmt: Decimal;
        NSSFAmt: Decimal;
        PenNSSF: Decimal;
        Amount1: Decimal;
        Amount2: Decimal;
        Amount3: Decimal;
        PayrollEmployeee: Record pr_employees;
        PINNo: Code[20];
        CompanyInfo: Record "Company Information";
        firstname: Code[30];
        basicpay: Decimal;
        TotalGross: Decimal;
        Lastname: Code[30];
}

