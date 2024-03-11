page 50425 "Payroll Employees List"
{
    // version Payroll Management v1.0.0

    // Morgage Relief is Calculated Based on upto 300,000 Annually which is equal to 25,000 per month.
    // If the employee contribution is more than 25,000 only 25,000 of it is subject to relief and affects the Taxable Pay.
    // To Calculate the relief, take the Tax bracket Rate of the Employee * the Contribution upto the higher limit.
    // 
    // This concept Applies for Pension Relief.

    CardPageID = "Payroll Employee Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = pr_employees;
    SourceTableView = WHERE(status = FILTER(<> exited));
    ApplicationArea = all;

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
            action("Process RM Rewards")
            {
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    FnProcessRmRewards();
                end;
            }
            action("Process payroll")
            {
                Image = Production;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Process();
                    Message('Process Completed successfully');
                end;
            }
            action(Payslip)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    // ObjPayrollEmployee.Reset;
                    //   ObjPayrollEmployee.SetRange(staff_no,staff_no);
                    //if ObjPayrollEmployee.Find('-') then
                    //   REPORT.Run(50420, true, false, ObjPayrollEmployee);
                end;
            }
            action(Summary)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = false;
                PromotedOnly = true;
                // RunObject = Report "Payroll Summary";
            }
            action(Transactions)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                // RunObject = Report "Transactions Report";
            }
            action("PAYE Schedule")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                // RunObject = Report "PAYE Schedule";
            }
            action("NSSF Schedule")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                //  RunObject = Report "NSSF Schedule";
            }
            action("NHIF Schedule")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                //  RunObject = Report "NHIF Schedule";
            }
            action("BANK Schedule")
            {
                Image = "report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                // RunObject = Report "BANK Schedule";
            }
            action("HELB Schedule")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                // RunObject = Report "HELB Schedule";
            }
            action("Post Payroll")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                //  RunObject = Report "Payroll Journal Transfer";

                trigger OnAction()
                begin
                    ObjPayrollEmployee.Reset;
                    if ObjPayrollEmployee.Find('-') then
                        REPORT.Run(50428, true, false, ObjPayrollEmployee);
                end;
            }
            action("Post Net")
            {
                Image = post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                //  RunObject = Report "NetPay Journal Transfer";
            }
            action("Send Payslips")
            {
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                // RunObject = Report "Send Payslips";
            }
            action("Save All ")
            {
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjPayrollPeriods.Reset;
                    ObjPayrollPeriods.SetRange(Active, true);
                    if ObjPayrollPeriods.Find('-') then
                        Objpremployees.Reset;
                    //Objpremployees.SETRANGE(Objpremployees.st_no,st_no);
                    Objpremployees.SetFilter(Objpremployees."Period Filter", ObjPayrollPeriods.period_code);
                    if Objpremployees.Find('-') then begin
                        repeat
                        // Filename:='';
                        //  Filename:= SMTPSetup."Path to Save Report"+'PAYSLIP - '+'.pdf';


                        // REPORT.SaveAsPdf(REPORT::Payslip,Filename,Objpremployees);
                        until Objpremployees.Next = 0;
                    end;
                    Message('Payslips saved successfully');
                end;
            }
        }
    }

    trigger OnInit()
    begin
        // if UserSetup.Get(UserId) then begin
        //  if not UserSetup."View Payroll" then
        //     Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
        // end else
        //     Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
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
        //  SMTPSetup: Record "SMTP Mail Setup";
        //  SMTPMail: Codeunit "SMTP Mail";
        Filename: Text;
        UserSetup: Record "User Setup";
        NoOfDaysWorked: Integer;
        ProratedBPAY: Decimal;
        ProratedGPAY: Decimal;
        TOT_TAXABLE_DED: Decimal;
        TaxBracketRate: Decimal;
        Objpremployees: Record pr_employees;

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
        MORGR: Decimal;
        MORG: Decimal;
        PENSR: Decimal;
        PENS: Decimal;
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

        ObjPayrollTransactionType.Reset;
        ObjPayrollTransactionType.SetRange(ObjPayrollTransactionType.is_mandatory, true);
        if ObjPayrollTransactionType.Find('-') then begin
            repeat
                ObjPayrollAllowancesAndDeductions.Reset;
                ObjPayrollAllowancesAndDeductions.SetRange(ObjPayrollAllowancesAndDeductions.transaction_code, ObjPayrollTransactionType.code);
                ObjPayrollAllowancesAndDeductions.SetRange(ObjPayrollAllowancesAndDeductions.period_code, ActivePeriod);
                if ObjPayrollAllowancesAndDeductions.Find('-') then
                    ObjPayrollAllowancesAndDeductions.DeleteAll;
            until ObjPayrollTransactionType.Next = 0;
        end;

        ObjPayrollEmployee.Reset;
        ObjPayrollEmployee.SetRange(status, Rec.status::active);
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
                TaxBracketRate := 0;

                ObjSetup.Get();

                FnPopulateMandatoryAllowancesAndDeductions(ObjPayrollEmployee, ObjPayrollPeriods);
                BPAY := ObjPayrollEmployee.basic_pay;

                //-------------------------------Prorated On THEN number OF days worked
                if CalcDate('CM', ObjPayrollEmployee.joining_date) = (ObjPayrollPeriods.end_date) then begin

                    //      IF ObjPayrollPeriods.end_date = 310719D THEN
                    //        ObjPayrollPeriods.end_date := 300719D;
                    NoOfDaysWorked := ObjPayrollPeriods.end_date - CalcDate('-1D', ObjPayrollEmployee.joining_date);
                    ProratedBPAY := FnGetBpay(ObjPayrollEmployee.basic_pay, NoOfDaysWorked, Date2DMY(ObjPayrollPeriods.end_date, 1));
                    BPAY := ProratedBPAY;
                    //      ObjPayrollPeriods.end_date := 310719D;

                    //------------------Process Prorated Payroll
                    FnProratedPayrollProcess(BPAY, ActivePeriod);

                end else
                    if (ObjPayrollEmployee.contract_end_date <> 0D) then begin
                        if (CalcDate('CM', ObjPayrollEmployee.contract_end_date) = (ObjPayrollPeriods.end_date)) then begin
                            //      IF ObjPayrollPeriods.end_date = 310719D THEN
                            //        ObjPayrollPeriods.end_date := 300719D;
                            NoOfDaysWorked := Date2DMY(ObjPayrollEmployee.contract_end_date, 1);
                            ProratedBPAY := FnGetBpay(ObjPayrollEmployee.basic_pay, NoOfDaysWorked, Date2DMY(ObjPayrollPeriods.end_date, 1));
                            BPAY := ProratedBPAY;
                            //      ObjPayrollPeriods.end_date := 310719D;

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


                        //B.---------PNSR    PENSION INFORMATION ----------------------------------------------------------
                        TaxBracketRate := FnGetTaxBracketRate(GPAY);
                        if (ObjPayrollEmployee."Pension Contribution" + DEFCON) > ObjSetup."Maximum Pension Relief" then
                            ObjPayrollEmployee."Pension Contribution" := ObjSetup."Maximum Pension Relief" - DEFCON;

                        PENS := ObjPayrollEmployee."Pension Contribution";
                        PENSR := ObjPayrollEmployee."Pension Contribution" * (TaxBracketRate / 100);
                        if PENSR > 0 then
                            FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'PENSR', 'Pension Relief', 'INCOME', PENSR, 'TAX CALCULATIONS', ActivePeriod);

                        //---------MORTGAGE INFORMATION
                        if ObjPayrollEmployee."Mortgage Interest" > ObjSetup."Maximum Morgage Relief" then
                            ObjPayrollEmployee."Mortgage Interest" := ObjSetup."Maximum Morgage Relief";

                        MORG := ObjPayrollEmployee."Mortgage Interest";
                        MORGR := ObjPayrollEmployee."Mortgage Interest" * (TaxBracketRate / 100);
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'MORGR', 'Mortgage Relief', 'INCOME', MORGR, 'TAX CALCULATIONS', ActivePeriod);


                        //C.---------PERR----------------------------------------------------------
                        PERR := ObjSetup."Personal Relief";//1408;
                        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'PERR', 'Personal Relief', 'INCOME', PERR, 'TAX CALCULATIONS', ActivePeriod);

                        //D.---------TXBP----------------------------------------------------------
                        TXBP := GPAY - (DEFCON + PENS + MORG);
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
        ObjPayrollTransactionType.SetRange(ObjPayrollTransactionType.is_mandatory, true);
        if ObjPayrollTransactionType.Find('-') then begin
            repeat
                amount := 0;
                amount := ObjPayrollTransactionType.amount;
                if ((ObjPayrollTransactionType.is_percentage <> 0))
                   then
                    amount := ObjPayrollTransactionType.percentage * ObjEmployee.basic_pay / 100;

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
                ObjPayrollAllowancesAndDeductions.amount_reference := ObjPayrollTransactionType.amount_reference;
                ObjPayrollAllowancesAndDeductions.group_title := ObjPayrollTransactionType.group_title;

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
        MORGR: Decimal;
        MORG: Decimal;
        PENSR: Decimal;
        PENS: Decimal;
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

        //B.---------PNSR    PENSION INFORMATION ----------------------------------------------------------
        TaxBracketRate := FnGetTaxBracketRate(GPAY);
        if (ObjPayrollEmployee."Pension Contribution" + DEFCON) > ObjSetup."Maximum Pension Relief" then
            ObjPayrollEmployee."Pension Contribution" := ObjSetup."Maximum Pension Relief" - DEFCON;

        PENS := ObjPayrollEmployee."Pension Contribution";
        PENSR := ObjPayrollEmployee."Pension Contribution" * (TaxBracketRate / 100);
        if PENSR > 0 then
            FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'PENSR', 'Pension Relief', 'INCOME', PENSR, 'TAX CALCULATIONS', ActivePeriod);

        //---------MORTGAGE INFORMATION
        if ObjPayrollEmployee."Mortgage Interest" > ObjSetup."Maximum Morgage Relief" then
            ObjPayrollEmployee."Mortgage Interest" := ObjSetup."Maximum Morgage Relief";

        MORG := ObjPayrollEmployee."Mortgage Interest";
        MORGR := ObjPayrollEmployee."Mortgage Interest" * (TaxBracketRate / 100);
        FnInsertPayrollTransactions(ObjPayrollEmployee.staff_no, 'MORGR', 'Mortgage Relief', 'INCOME', MORGR, 'TAX CALCULATIONS', ActivePeriod);

        //C.---------PERR----------------------------------------------------------
        PERR := ObjSetup."Personal Relief";//1408;
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

    local procedure FnGetTaxBracketRate(TXBPAmt: Decimal): Decimal
    var
        ObjTaxBracketSetup: Record "Tax Bracket Setup";
    begin
        ObjTaxBracketSetup.Reset;
        ObjTaxBracketSetup.SetFilter(ObjTaxBracketSetup."Lower Limit", '>=%1', TXBPAmt);
        if ObjTaxBracketSetup.Find('-') then begin
            exit(ObjTaxBracketSetup.Percentage);
        end else begin
            ObjTaxBracketSetup.Reset;
            if ObjTaxBracketSetup.Find('+') then
                exit(ObjTaxBracketSetup.Percentage);
        end
    end;

    local procedure FnProcessRmRewards()
    var
        ActivePeriod: Date;
        DateFilter: Code[50];
        ObjLoans: Record Loans;
        AmountDisbursed: Decimal;
        RMReward: Decimal;
        CFTFactory: Codeunit "CFT Factory";
        LoanCount: Integer;
        ObjRewards: Record pr_rewards;
        ObjAllowanceDeductions: Record pr_allowances_and_deductions;
        Activep: Code[20];
        ObjLoanDisb: Record "Loan Disbursement";
        StartD: Date;
        EndD: Date;
    begin
        ObjPayrollPeriods.Reset;
        ObjPayrollPeriods.SetRange(Closed, true);
        ObjPayrollPeriods.SetCurrentKey(ObjPayrollPeriods.start_date, ObjPayrollPeriods.end_date);
        ObjPayrollPeriods.SetAscending(ObjPayrollPeriods.start_date, true);
        if ObjPayrollPeriods.Find('+') then begin
            DateFilter := Format(ObjPayrollPeriods.start_date) + '..' + Format(ObjPayrollPeriods.end_date);
            //  MESSAGE('Datefilter %1',DateFilter);
            StartD := ObjPayrollPeriods.start_date;
            EndD := ObjPayrollPeriods.end_date;
        end;


        //------------------Get Current Active Period.
        ObjPayrollPeriods.Reset;
        ObjPayrollPeriods.SetRange(Active, true);
        if ObjPayrollPeriods.Find('-') then
            Activep := ObjPayrollPeriods.period_code;

        //------------------Delete Rewards Carried forward from previous Month.
        ObjAllowanceDeductions.Reset;
        ObjAllowanceDeductions.SetRange(ObjAllowanceDeductions.period_code, Activep);
        ObjAllowanceDeductions.SetRange(ObjAllowanceDeductions.transaction_code, 'A001');
        if ObjAllowanceDeductions.Find('-') then
            ObjAllowanceDeductions.DeleteAll;


        ObjPayrollEmployee.Reset;
        ObjPayrollEmployee.SetRange(ObjPayrollEmployee.status, ObjPayrollEmployee.status::active);
        if ObjPayrollEmployee.Find('-') then begin
            repeat
                AmountDisbursed := 0;
                RMReward := 0;
                LoanCount := 0;

                //Changed 5th march 2020 from objloans to ObjLoanDisb to for tranche disb
                ObjLoanDisb.Reset;
                ObjLoanDisb.SetCurrentKey(ObjLoanDisb."RM Code", ObjLoanDisb."Amount to Disburse", ObjLoanDisb."Posting Date");
                ObjLoanDisb.SetFilter(ObjLoanDisb."Posting Date", DateFilter);
                ObjLoanDisb.SetRange(ObjLoanDisb."RM Code", ObjPayrollEmployee.staff_no);
                if ObjLoanDisb.Find('-') then begin
                    repeat
                        //ObjLoanDisb.CALCFIELDS(ObjLoanDisb."Net Disbursement On Topup");
                        LoanCount := LoanCount + 1;
                        //AmountDisbursed := AmountDisbursed + fnGetNetDisbursed(ObjLoanDisb."Loan No",ObjPayrollPeriods.start_date,ObjPayrollPeriods.end_date,ObjLoanDisb."RM Code");
                        AmountDisbursed := AmountDisbursed + fnGetNetDisbursed(ObjLoanDisb."Loan No", StartD, EndD, ObjLoanDisb."RM Code");
                    until ObjLoanDisb.Next = 0;

                    //MESSAGE('Dates %1 and %2 Amount Disbursed %3 and Loan Count %4 for days %5',StartD,EndD,AmountDisbursed,LoanCount,EndD-StartD);

                    if (LoanCount > 1) and (AmountDisbursed > 0) then begin
                        // ObjRewards.Reset;
                        // ObjRewards.SetRange(ObjRewards.rm_band,'01');
                        // if ObjRewards.Find('-') then
                        //if AmountDisbursed >= ObjRewards.lower_limit then
                        // RMReward := CFTFactory.FnCalculateRMReward(AmountDisbursed);
                    end;
                    if RMReward > 0 then
                        Message('Total Amount Disbursed in %4, by %1 is %2 and Reward %3', ObjPayrollEmployee.Name, AmountDisbursed, RMReward, DateFilter);
                    if RMReward > 0 then
                        FnInsertRewardEntries(ObjPayrollEmployee.staff_no, RMReward);
                end;
            until ObjPayrollEmployee.Next = 0;
        end;
    end;

    local procedure FnInsertRewardEntries(St_No: Code[50]; Reward: Decimal)
    var
        ObjAllowanceDeductions: Record pr_allowances_and_deductions;
        ActivePeriod: Code[50];
    begin
        ObjPayrollPeriods.Reset;
        ObjPayrollPeriods.SetRange(Active, true);
        if ObjPayrollPeriods.Find('-') then
            ActivePeriod := ObjPayrollPeriods.period_code;

        ObjAllowanceDeductions.Reset;
        ObjAllowanceDeductions.SetRange(ObjAllowanceDeductions.st_no, St_No);
        ObjAllowanceDeductions.SetRange(ObjAllowanceDeductions.period_code, ActivePeriod);
        ObjAllowanceDeductions.SetRange(ObjAllowanceDeductions.transaction_code, 'A001');
        if ObjAllowanceDeductions.Find('-') then
            ObjAllowanceDeductions.DeleteAll;

        ObjAllowanceDeductions.Init;
        ObjAllowanceDeductions.st_no := St_No;
        ObjAllowanceDeductions.transaction_code := 'A001';
        ObjAllowanceDeductions.Validate(ObjAllowanceDeductions.transaction_code);
        ObjAllowanceDeductions.amount := Reward;
        if ObjAllowanceDeductions.amount > 0 then
            ObjAllowanceDeductions.Insert;
    end;

    local procedure fnGetNetDisbursed(Loanno: Code[50]; startDate: Date; endDate: Date; RM: Code[50]) NetDisb: Decimal
    var
        ObjDisbursement: Record "Loan Disbursement";
        ObLoans: Record Loans;
        PrevDate: Date;
        Prevfilter: Text;
        PrevTotal: Decimal;
        CurrTotal: Decimal;
        TotalOffset: Decimal;
        Dfilter: Text;
    begin
        PrevDate := CalcDate('-1D', startDate);
        Prevfilter := '..' + Format(PrevDate);

        ObLoans.Reset;
        ObLoans.SetRange(ObLoans."Loan Number", Loanno);
        if ObLoans.Find('-') then begin
            ObLoans.CalcFields(ObLoans."Total Offset Amount", ObLoans."Amount Disbursed");
            TotalOffset := ObLoans."Total Offset Amount";
            CurrTotal := ObLoans."Amount Disbursed";
        end;

        ObjDisbursement.Reset;
        ObjDisbursement.SetRange(ObjDisbursement."Loan No", Loanno);
        ObjDisbursement.SetCurrentKey(ObjDisbursement."RM Code", ObjDisbursement."Amount to Disburse", ObjDisbursement."Posting Date");
        ObjDisbursement.SetFilter(ObjDisbursement."Posting Date", Prevfilter);
        ObjDisbursement.SetRange(Posted, true);
        ObjDisbursement.SetRange(Reversed, false);
        ObjDisbursement.SetRange(ObjDisbursement."RM Code", RM);
        if ObjDisbursement.Find('-') then begin
            ObjDisbursement.CalcSums(ObjDisbursement."Amount to Disburse");
            PrevTotal := ObjDisbursement."Amount to Disburse";
        end;

        NetDisb := CurrTotal - (PrevTotal + TotalOffset);

        exit(NetDisb);
    end;
}

