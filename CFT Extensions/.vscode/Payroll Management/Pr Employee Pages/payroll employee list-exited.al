page 50426 "Payroll Employees List - Exit"
{
    // version Payroll Management v1.0.0

    CardPageID = "Payroll Employee Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = pr_employees;
    SourceTableView = WHERE(status = FILTER(exited));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(st_no; Rec.staff_no)
                {
                    Caption = 'No';
                }
                field(Name; Rec.Name)
                {
                    Caption = ' Name';
                }
                field(basic_pay; Rec.basic_pay)
                {
                    Caption = 'Basic Pay';
                }
                field(bank_account_no; Rec.bank_account_no)
                {
                    Caption = 'Bank Account No';
                }
                field(nssf_no; Rec.nssf_no)
                {
                    Caption = 'Nssf No';
                }
                field(nhif_no; Rec.nhif_no)
                {
                    Caption = 'Nhif No';
                }
                field(pin_no; Rec.pin_no)
                {
                    Caption = 'PIN No';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Summary)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = false;
                PromotedOnly = true;
                // RunObject = Report "Payroll Summary";
            }
            action("Send Payslips")
            {
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                // RunObject = Report "Send Payslips";
            }
        }
    }

    trigger OnInit()
    begin
        if UserSetup.Get(UserId) then begin
            //  if not UserSetup."View Payroll" then
            Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
        end else
            Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
    end;

    var
        ObjPayrollEmployee: Record pr_employees;
        ObjPayrollTransactionType: Record pr_transaction_types;
        ObjPayrollPeriods: Record pr_periods;
        ObjNSSF: Record pr_nssf;
        ObjNHIF: Record pr_nhif;
        ObjPayrollTransactions: Record pr_transaction_reports;
        ObjPayrollAllowancesAndDeductions: Record pr_allowances_and_deductions;
        ObjTransactions: Record pr_transactions;
        ObjSetup: Record "Payroll General setup";
        // SMTPSetup: Record "SMTP Mail Setup";
        //  SMTPMail: Codeunit "SMTP Mail";
        Filename: Text;
        UserSetup: Record "User Setup";
        NoOfDaysWorked: Integer;
        ProratedBPAY: Decimal;
        ProratedGPAY: Decimal;
        TOT_TAXABLE_DED: Decimal;

    local procedure Process()
    var
        BPAY: Decimal;
        TOT_DED: Decimal;
        TOT_ALLOWANCE: Decimal;
        GPAY: Decimal;
        DEFCON: Decimal;
        PERR: Decimal;
        TXBP: Decimal;
        TXCHRG: Decimal;
        CFTFactory: Codeunit "CFT Factory";
        NSSF: Decimal;
        NHIF: Decimal;
        PAYE: Decimal;
        TOTDED: Decimal;
        NPAY: Decimal;
        ActivePeriod: Code[100];
        INSR: Decimal;
    begin
        ObjPayrollPeriods.Reset;
        ObjPayrollPeriods.SetRange(Active, true);
        if ObjPayrollPeriods.Find('-') then
            ActivePeriod := ObjPayrollPeriods.period_code;

        //1.---------CLEAR CURRENT PERIOD-----------------------------------
        ObjPayrollTransactions.Reset;
        ObjPayrollTransactions.SetRange(period_code, ActivePeriod);
        if ObjPayrollTransactions.Find('-') then
            ObjPayrollTransactions.DeleteAll;

        ObjTransactions.Reset;
        ObjTransactions.SetRange(period_code, ActivePeriod);
        if ObjTransactions.Find('-') then
            ObjTransactions.DeleteAll;


        ObjPayrollEmployee.Reset;
        if ObjPayrollEmployee.Find('-') then begin
            repeat
                BPAY := 0;
                GPAY := 0;
                TOT_ALLOWANCE := 0;
                TOT_DED := 0;
                TXBP := 0;
                TXCHRG := 0;
                INSR := 0;
                PAYE := 0;
                DEFCON := 0;
                NSSF := 0;
                NHIF := 0;
                TOTDED := 0;
                ProratedBPAY := 0;
                ProratedGPAY := 0;
                TOT_TAXABLE_DED := 0;

                FnPopulateMandatoryAllowancesAndDeductions(ObjPayrollEmployee, ObjPayrollPeriods);
                BPAY := ObjPayrollEmployee.basic_pay;

                //-------------------------------Prorated On THEN number OF days worked
                if CalcDate('CM', ObjPayrollEmployee.joining_date) = (ObjPayrollPeriods.end_date) then begin

                    if ObjPayrollPeriods.end_date = 20190731D then
                        ObjPayrollPeriods.end_date := 20190730D;
                    NoOfDaysWorked := ObjPayrollPeriods.end_date - CalcDate('-1D', ObjPayrollEmployee.joining_date);
                    ProratedBPAY := FnGetBpay(ObjPayrollEmployee.basic_pay, NoOfDaysWorked, Date2DMY(ObjPayrollPeriods.end_date, 1));
                    BPAY := ProratedBPAY;
                    ObjPayrollPeriods.end_date := 20190731D;

                    //------------------Process Prorated Payroll
                    FnProratedPayrollProcess(BPAY, ActivePeriod);

                end else
                    if (ObjPayrollEmployee.contract_end_date <> 0D) then begin
                        if (CalcDate('CM', ObjPayrollEmployee.contract_end_date) = (ObjPayrollPeriods.end_date)) then begin
                            if ObjPayrollPeriods.end_date = 20190731D then
                                ObjPayrollPeriods.end_date := 20190730D;
                            NoOfDaysWorked := Date2DMY(ObjPayrollEmployee.contract_end_date, 1);
                            ProratedBPAY := FnGetBpay(ObjPayrollEmployee.basic_pay, NoOfDaysWorked, Date2DMY(ObjPayrollPeriods.end_date, 1));
                            BPAY := ProratedBPAY;
                            ObjPayrollPeriods.end_date := 20190731D;

                            //------------------Process Prorated Payroll
                            FnProratedPayrollProcess(BPAY, ActivePeriod);

                        end;
                    end else
           //-------------------------------Prorated On THEN number OF days worked
           begin
                        //2.---------BASIC PAY----------------------------------------------
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'BPAY', 'Basic Pay', 'INCOME', BPAY, 'BASIC PAY', ActivePeriod);
                        //3.-------- ALLOWANCES & DEDUCTIONS--------------------------------
                        ObjPayrollAllowancesAndDeductions.Reset;
                        ObjPayrollAllowancesAndDeductions.SetRange(st_no, ObjPayrollEmployee.staff_no);
                        ObjPayrollAllowancesAndDeductions.SetRange(period_code, ActivePeriod);
                        if ObjPayrollAllowancesAndDeductions.Find('-') then begin
                            repeat
                                FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, ObjPayrollAllowancesAndDeductions.transaction_code,
                                ObjPayrollAllowancesAndDeductions.transaction_name, Format(ObjPayrollAllowancesAndDeductions.amount_reference),
                                ObjPayrollAllowancesAndDeductions.amount, ObjPayrollAllowancesAndDeductions.group_title, ActivePeriod);
                                //TODO Update reporting table
                                if ObjPayrollAllowancesAndDeductions.group_title = 'DEDUCTION' then begin

                                    //------------------------Get the Taxable Deductions to be deducted from the Grosspay
                                    if FnCheckTaxable(ObjPayrollAllowancesAndDeductions.transaction_code) then
                                        TOT_TAXABLE_DED := TOT_TAXABLE_DED + ObjPayrollAllowancesAndDeductions.amount;
                                    //------------------------Get the Taxable Deductions to be deducted from the Grosspay

                                    TOT_DED := TOT_DED + ObjPayrollAllowancesAndDeductions.amount
                                end
                                else
                                    TOT_ALLOWANCE := TOT_ALLOWANCE + ObjPayrollAllowancesAndDeductions.amount;
                            until ObjPayrollAllowancesAndDeductions.Next = 0;
                        end;

                        //-----------INSURANCE INFORMATION
                        INSR := ObjPayrollEmployee."Instalment Premium" * 0.15;
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'INSR', 'Insurance Relief', 'INCOME', INSR, 'Insurance Relief', ActivePeriod);

                        //4.---------GROSSPAY----------------------------------------------
                        GPAY := BPAY + TOT_ALLOWANCE - TOT_TAXABLE_DED;
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'GPAY', 'Gross Pay', 'INCOME', GPAY, 'GROSS PAY', ActivePeriod);
                        //5.---------TAX CALCUATIONS----------------------------------------------
                        //A.---------DEFCON-------------------------------------------------------
                        ObjSetup.Get();
                        if ObjSetup.nssf_bands = true then begin
                            DEFCON := returnNSSFAmount(GPAY);
                        end else
                            DEFCON := 200;
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'DEFCON', 'Defined Contributions', 'INCOME', DEFCON, 'TAX CALCULATIONS', ActivePeriod);
                        //B.---------PNSR----------------------------------------------------------

                        //C.---------PERR----------------------------------------------------------
                        PERR := 1408;
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'PERR', 'Personal Relief', 'INCOME', PERR, 'TAX CALCULATIONS', ActivePeriod);

                        //D.---------TXBP----------------------------------------------------------
                        TXBP := GPAY - DEFCON;
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'TXBP', 'Taxable Pay', 'INCOME', TXBP, 'TAX CALCULATIONS', ActivePeriod);

                        //E.---------TXCHRG---------------------------------------------------------
                        if ((TXBP <= ObjSetup.minimum_taxable) or (ObjPayrollEmployee.pays_paye = false)) then
                            TXBP := 0;
                        TXCHRG := CFTFactory.FnCalculatePaye(TXBP);

                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'TXCHRG', 'Tax Charged', 'INCOME', TXCHRG, 'TAX CALCULATIONS', ActivePeriod);

                        //6.---------STATUTORY DEDUCTIONS-----------------------------------
                        //A.-----------NSSF----------------------------------------------
                        if (ObjPayrollEmployee.pays_nssf) then begin
                            if (ObjSetup.nssf_bands) then
                                NSSF := returnNSSFAmount(GPAY);
                        end
                        else
                            NSSF := 200;
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'NSSF', 'NSSF', 'DEDUCTION', NSSF, 'STATUTORIES', ActivePeriod);

                        //B.-----------NHIF--------------------------------------------------
                        if ((ObjPayrollEmployee.pays_nhif) and (BPAY > 0)) then
                            NHIF := returnNHIFAmount(BPAY);
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'NHIF', 'NHIF', 'DEDUCTION', NHIF, 'STATUTORIES', ActivePeriod);

                        //C.-----------PAYE--------------------------------------------------
                        if (ObjPayrollEmployee.pays_paye) then begin
                            PAYE := CFTFactory.FnCalculatePaye(TXBP) - INSR;
                            FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'PAYE', 'PAYE', 'DEDUCTION', PAYE, 'STATUTORIES', ActivePeriod);
                        end;

                        //7.-------------------TOTDED----------------------------------------
                        TOTDED := (TOT_DED - TOT_TAXABLE_DED) + NSSF + NHIF + PAYE;
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'TOTDED', 'Total Deductions', 'DEDUCTION', TOTDED, 'DEDUCTIONS', ActivePeriod);

                        //8.-------------------NETPAY----------------------------------------
                        NPAY := GPAY - TOTDED;
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'NPAY', 'Net Pay', 'INCOME', NPAY, 'NET PAY', ActivePeriod);
                    end;
            until ObjPayrollEmployee.Next = 0;
        end;
    end;

    local procedure FnTransactionsReportingInsertEmployees(ObjEmployee: Record pr_employees; ObjPeriod: Record pr_periods)
    var
        ObjTransactions: Record pr_transaction_reports;
    begin
        //'classification'=>$class,'job_code'=>$title,
        ObjTransactions.Init;
        ObjTransactions.st_no := ObjEmployee.staff_no;
        ObjTransactions.Validate(st_no);
        ObjTransactions.period_code := ObjPeriod.period_code;
        ObjTransactions.emp_name := ObjEmployee.Name;
        ObjTransactions.department_code := ObjEmployee.department_code;
        ObjTransactions.bank_code := ObjEmployee.bank_code;
        ObjTransactions.bank_account_no := ObjEmployee.bank_account_no;
        ObjTransactions.bank_account_name := ObjEmployee.bank_name;
        ObjTransactions.nssf_no := ObjEmployee.nssf_no;
        ObjTransactions.nhif_no := ObjEmployee.nhif_no;
        ObjTransactions.bank_name := ObjEmployee.bank_name;
        //ObjTransactions.INSERT(TRUE);
    end;

    local procedure FnPopulateMandatoryAllowancesAndDeductions(ObjEmployee: Record pr_employees; ObjPeriod: Record pr_periods)
    var
        amount: Decimal;
    begin
        ObjPayrollTransactionType.Reset;
        if ObjPayrollTransactionType.Find('-') then begin
            repeat
                amount := 0;
                amount := ObjPayrollTransactionType.amount;
                if ((ObjPayrollTransactionType.is_percentage = 1) and (ObjPayrollTransactionType.code <> 'A001'))
                  then
                    amount := ObjPayrollTransactionType.percentage * ObjEmployee.basic_pay / 100;
                if (ObjPayrollTransactionType.code = 'A001') then begin
                    amount := 0;
                    //amount=$this->FnUpdateHouseAllowance($basic_payable,$basic_pay_formula,$objTransaction->percentage);
                end;
                ObjPayrollAllowancesAndDeductions.Init;
                ObjPayrollAllowancesAndDeductions.st_no := ObjEmployee.staff_no;
                ObjPayrollAllowancesAndDeductions.transaction_code := ObjPayrollTransactionType.code;
                ObjPayrollAllowancesAndDeductions.transaction_name := ObjPayrollTransactionType.trans_name;
                ObjPayrollAllowancesAndDeductions.amount := amount;
                ObjPayrollAllowancesAndDeductions.period_month := ObjPeriod.period_month;
                ObjPayrollAllowancesAndDeductions.period_year := ObjPeriod.period_year;
                ObjPayrollAllowancesAndDeductions.period_code := ObjPeriod.period_code;
                ObjPayrollAllowancesAndDeductions.group_order := ObjPayrollTransactionType.group_order;
                ObjPayrollAllowancesAndDeductions.sub_group_order := ObjPayrollTransactionType.sub_group_order;
                ObjPayrollAllowancesAndDeductions.gl_account_no := ObjPayrollTransactionType.acc_no;
                ObjPayrollAllowancesAndDeductions.gl_account_name := ObjPayrollTransactionType.gl_account_name;

                if (amount > 0)
                then
                    ObjPayrollAllowancesAndDeductions.Insert;
            until ObjPayrollTransactionType.Next = 0;
        end;
    end;

    local procedure FnInsertPayrollTransactions(st_no: Code[100]; trans_code: Code[100]; trans_name: Text[100]; trans_reference: Code[100]; Amount: Decimal; group_title: Code[100]; period_code: Code[100])
    begin
        ObjTransactions.Init;
        ObjTransactions.staff_no := st_no;
        ObjTransactions.Validate(staff_no);
        ObjTransactions.transaction_code := trans_code;
        ObjTransactions.Validate(ObjTransactions.transaction_code);
        ObjTransactions.transaction_reference := trans_reference;
        ObjTransactions.transaction_name := trans_name;
        ObjTransactions.amount := Amount;
        ObjTransactions.group_title := group_title;
        ObjTransactions.period_code := period_code;
        ObjTransactions.Validate(period_code);
        if (ObjTransactions.amount > 0) then
            ObjTransactions.Insert;
    end;

    local procedure returnNSSFAmount(Chargeable: Decimal): Decimal
    var
        PAYE: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
    begin
        PAYE := 0;
        BAND1 := 0;
        BAND2 := 0;
        ObjNSSF.Reset;
        ObjNSSF.SetRange(nssf_band);
        if ObjNSSF.Find('-') then begin
            repeat
                if Chargeable > 0 then begin
                    case ObjNSSF.nssf_band of
                        '01':
                            begin
                                if (Chargeable > ObjNSSF.upper_limit) then begin
                                    BAND1 := FnGetNSSFBudCharge('01');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                end
                                else begin
                                    if (Chargeable > ObjNSSF.taxable_amount) then begin
                                        BAND1 := FnGetNSSFBudCharge('01');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    end
                                    else begin
                                        BAND1 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    end
                                end

                            end;
                        '02':
                            begin
                                if (Chargeable > ObjNSSF.upper_limit) then begin
                                    BAND2 := FnGetNSSFBudCharge('02');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                end else begin
                                    if (Chargeable > ObjNSSF.taxable_amount) then begin
                                        BAND2 := FnGetNSSFBudCharge('02');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    end else begin
                                        BAND2 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    end
                                end
                            end


                    end
                end
            until ObjNSSF.Next = 0;
        end;
        exit(BAND1 + BAND2);
    end;

    local procedure FnGetNSSFBudCharge(ChargeCode: Code[100]): Decimal
    var
        ObjNssf_param: Record pr_nssf;
    begin
        ObjNssf_param.Reset;
        ObjNssf_param.SetRange(nssf_band, ChargeCode);
        if ObjNssf_param.Find('-') then
            exit(ObjNssf_param.taxable_amount * 6 / 100)
    end;

    local procedure FnNSSFRate(): Decimal
    begin
        exit(6 / 100);
    end;

    local procedure returnNHIFAmount(Amount: Decimal): Decimal
    begin
        ObjNHIF.Reset;
        ObjNHIF.SetFilter(lower_limit, '<=%1', Amount);
        ObjNHIF.SetFilter(upper_limit, '>=%1', Amount);
        if ObjNHIF.Find('-') then
            exit(ObjNHIF.amount);
    end;

    local procedure FnGetBpay(BasicPay: Decimal; NoOfDaysWorked: Integer; DaysInMonth: Integer): Decimal
    var
        BasicPayAmount: Decimal;
    begin
        BasicPayAmount := Round((NoOfDaysWorked * BasicPay) / DaysInMonth, 0.01, '=');
        exit(BasicPayAmount);
    end;

    local procedure FnCheckTaxable(Transcode: Code[50]): Boolean
    var
        ObjPrtransactionTypes: Record pr_transaction_types;
    begin
        ObjPrtransactionTypes.Reset;
        ObjPrtransactionTypes.SetRange(ObjPrtransactionTypes.code, Transcode);
        if ObjPrtransactionTypes.Find('-') then
            exit(ObjPrtransactionTypes.taxable);
    end;

    local procedure FnProratedPayrollProcess(BPAY: Decimal; ActivePeriod: Code[20])
    var
        TOT_DED: Decimal;
        TOT_ALLOWANCE: Decimal;
        GPAY: Decimal;
        DEFCON: Decimal;
        PERR: Decimal;
        TXBP: Decimal;
        TXCHRG: Decimal;
        CFTFactory: Codeunit "CFT Factory";
        NSSF: Decimal;
        NHIF: Decimal;
        PAYE: Decimal;
        TOTDED: Decimal;
        NPAY: Decimal;
        INSR: Decimal;
    begin
        //2.---------BASIC PAY----------------------------------------------
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'BPAY', 'Basic Pay', 'INCOME', BPAY, 'BASIC PAY', ActivePeriod);
        //3.-------- ALLOWANCES & DEDUCTIONS--------------------------------
        ObjPayrollAllowancesAndDeductions.Reset;
        ObjPayrollAllowancesAndDeductions.SetRange(st_no, ObjPayrollEmployee.staff_no);
        ObjPayrollAllowancesAndDeductions.SetRange(period_code, ActivePeriod);
        if ObjPayrollAllowancesAndDeductions.Find('-') then begin
            repeat
                FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, ObjPayrollAllowancesAndDeductions.transaction_code,
                ObjPayrollAllowancesAndDeductions.transaction_name, Format(ObjPayrollAllowancesAndDeductions.amount_reference),
                ObjPayrollAllowancesAndDeductions.amount, ObjPayrollAllowancesAndDeductions.group_title, ActivePeriod);
                //TODO Update reporting table
                if ObjPayrollAllowancesAndDeductions.group_title = 'DEDUCTION' then begin

                    //------------------------Get the Taxable Deductions to be deducted from the Grosspay
                    if FnCheckTaxable(ObjPayrollAllowancesAndDeductions.transaction_code) then
                        TOT_TAXABLE_DED := TOT_TAXABLE_DED + ObjPayrollAllowancesAndDeductions.amount;
                    //------------------------Get the Taxable Deductions to be deducted from the Grosspay

                    TOT_DED := TOT_DED + ObjPayrollAllowancesAndDeductions.amount
                end
                else
                    TOT_ALLOWANCE := TOT_ALLOWANCE + ObjPayrollAllowancesAndDeductions.amount;
            until ObjPayrollAllowancesAndDeductions.Next = 0;
        end;

        //-----------INSURANCE INFORMATION
        INSR := ObjPayrollEmployee."Instalment Premium" * 0.15;
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'INSR', 'Insurance Relief', 'INCOME', INSR, 'Insurance Relief', ActivePeriod);

        //4.---------GROSSPAY----------------------------------------------
        GPAY := BPAY + TOT_ALLOWANCE - TOT_TAXABLE_DED;
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'GPAY', 'Gross Pay', 'INCOME', GPAY, 'GROSS PAY', ActivePeriod);
        if ProratedBPAY > 0 then
            ProratedGPAY := GPAY;
        //5.---------TAX CALCUATIONS----------------------------------------------
        //A.---------DEFCON-------------------------------------------------------
        ObjSetup.Get();
        if ObjSetup.nssf_bands = true then begin
            if ProratedBPAY > 0 then
                GPAY := ObjPayrollEmployee.basic_pay + TOT_ALLOWANCE - TOT_TAXABLE_DED;
            DEFCON := returnNSSFAmount(GPAY);
        end else
            DEFCON := 200;
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'DEFCON', 'Defined Contributions', 'INCOME', DEFCON, 'TAX CALCULATIONS', ActivePeriod);
        //B.---------PNSR----------------------------------------------------------

        //C.---------PERR----------------------------------------------------------
        PERR := 1408;
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'PERR', 'Personal Relief', 'INCOME', PERR, 'TAX CALCULATIONS', ActivePeriod);

        //D.---------TXBP----------------------------------------------------------
        if ProratedBPAY > 0 then
            GPAY := ProratedGPAY;
        TXBP := GPAY - DEFCON;
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'TXBP', 'Taxable Pay', 'INCOME', TXBP, 'TAX CALCULATIONS', ActivePeriod);

        //E.---------TXCHRG---------------------------------------------------------
        if ((TXBP <= ObjSetup.minimum_taxable) or (ObjPayrollEmployee.pays_paye = false)) then
            TXBP := 0;
        TXCHRG := CFTFactory.FnCalculatePaye(TXBP);

        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'TXCHRG', 'Tax Charged', 'INCOME', TXCHRG, 'TAX CALCULATIONS', ActivePeriod);

        //6.---------STATUTORY DEDUCTIONS-----------------------------------
        //A.-----------NSSF----------------------------------------------
        if ProratedBPAY > 0 then
            GPAY := ObjPayrollEmployee.basic_pay + TOT_ALLOWANCE - TOT_TAXABLE_DED;
        if (ObjPayrollEmployee.pays_nssf) then begin
            if (ObjSetup.nssf_bands) then
                NSSF := returnNSSFAmount(GPAY);
        end
        else
            NSSF := 200;
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'NSSF', 'NSSF', 'DEDUCTION', NSSF, 'STATUTORIES', ActivePeriod);

        //B.-----------NHIF--------------------------------------------------
        if ProratedBPAY > 0 then
            BPAY := ObjPayrollEmployee.basic_pay;

        if ((ObjPayrollEmployee.pays_nhif) and (BPAY > 0)) then
            NHIF := returnNHIFAmount(BPAY);
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'NHIF', 'NHIF', 'DEDUCTION', NHIF, 'STATUTORIES', ActivePeriod);
        if ProratedBPAY > 0 then begin
            GPAY := ProratedGPAY;
            BPAY := ProratedBPAY;
        end;
        //C.-----------PAYE--------------------------------------------------
        if (ObjPayrollEmployee.pays_paye) then begin
            PAYE := CFTFactory.FnCalculatePaye(TXBP) - INSR;
            FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'PAYE', 'PAYE', 'DEDUCTION', PAYE, 'STATUTORIES', ActivePeriod);
        end;

        //7.-------------------TOTDED----------------------------------------
        TOTDED := (TOT_DED - TOT_TAXABLE_DED) + NSSF + NHIF + PAYE;
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'TOTDED', 'Total Deductions', 'DEDUCTION', TOTDED, 'DEDUCTIONS', ActivePeriod);

        //8.-------------------NETPAY----------------------------------------
        NPAY := GPAY - TOTDED;
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'NPAY', 'Net Pay', 'INCOME', NPAY, 'NET PAY', ActivePeriod);
    end;
}

