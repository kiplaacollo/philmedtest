page 50425 "Payroll Employees List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_employees;
    SourceTableView = where(status = filter(<> exited), Contractor = filter(false));
    CardPageId = "Payroll Employee Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(st_no; Rec.st_no)
                {
                    Caption = 'No';
                }
                field(Name; Rec.Name)
                {

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
                field(id_no; Rec.id_no)
                {
                    Caption = 'ID No';
                }
                field(employee_email; Rec.employee_email)
                {
                    Caption = 'Employee Email';
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {

                }
                field(Region; Rec.Region)
                {

                }
                field(contract_end_date; Rec.contract_end_date)
                {
                    Caption = 'Contract End Date';
                }
            }
        }
        area(FactBoxes)
        {
            part(employeesfactbox; "Employees Factbaox")
            {
                SubPageLink = st_no = field(st_no);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Process Payroll")
            {
                ApplicationArea = All;
                Image = Production;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Process();
                    MESSAGE('Process Completed successfully');
                end;
            }
            action("Post Payroll")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Payroll Journal Tranfer";
                trigger OnAction()
                begin
                    ObjPayrollEmployee.RESET;
                    IF ObjPayrollEmployee.FIND('-') THEN
                        REPORT.RUN(50428, TRUE, FALSE, ObjPayrollEmployee);
                end;
            }
            action(Payroll)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    ObjPayrollEmployee.RESET;
                    ObjPayrollEmployee.SETRANGE(st_no, REC.st_no);
                    IF ObjPayrollEmployee.FIND('-') THEN
                        REPORT.RUN(50420, TRUE, FALSE, ObjPayrollEmployee);
                end;
            }
        }
    }
    procedure Process()
    begin
        ObjPayrollPeriods.Reset();
        ObjPayrollPeriods.SetRange(Active, true);
        if ObjPayrollPeriods.Find('-') then
            ActivePeriod := ObjPayrollPeriods.period_code;
        // CLEAR CURRENT PERIOD
        ObjPayrollTransactions.RESET;
        ObjPayrollTransactions.SETRANGE(period_code, ActivePeriod);
        IF ObjPayrollTransactions.FIND('-') THEN
            ObjPayrollTransactions.DELETEALL;

        ObjTransactions.RESET;
        ObjTransactions.SETRANGE(period_code, ActivePeriod);
        IF ObjTransactions.FIND('-') THEN
            ObjTransactions.DELETEALL;

        ObjPayrollTransactionType.RESET;
        ObjPayrollTransactionType.SETRANGE(ObjPayrollTransactionType.is_mandatory, TRUE);
        IF ObjPayrollTransactionType.FIND('-') THEN begin
            REPEAT
                ObjPayrollAllowancesAndDeductions.RESET;
                ObjPayrollAllowancesAndDeductions.SETRANGE(ObjPayrollAllowancesAndDeductions.transaction_code, ObjPayrollTransactionType.code);
                ObjPayrollAllowancesAndDeductions.SETRANGE(ObjPayrollAllowancesAndDeductions.period_code, ActivePeriod);
                IF ObjPayrollAllowancesAndDeductions.FIND('-') THEN
                    ObjPayrollAllowancesAndDeductions.DELETEALL;
            UNTIL ObjPayrollTransactionType.NEXT = 0;
        end;
        ObjPayrollEmployee.RESET;
        ObjPayrollEmployee.SETRANGE(status, Rec.status::active);
        IF ObjPayrollEmployee.FIND('-') THEN begin
            repeat
                BPAY := 0;
                Rec.RETAINER := 0;
                GPAY := 0;
                TOT_ALLOWANCE := 0;
                TOT_DED := 0;

                TXBP := 0;
                TXCHRG := 0;
                INSR := 0;
                PAYE := 0;
                INSURELIEF := 0;
                DEFCON := 0;
                NSSF := 0;
                NHIF := 0;
                TOTDED := 0;
                HouseCon := 0;
                HouseLvy := 0;
                ProratedBPAY := 0;
                ProratedGPAY := 0;
                TOT_TAXABLE_DED := 0;
                totAllowancenontaxable := 0;
                TaxBracketRate := 0;
                ObjSetup.GET();
                FnPopulateMandatoryAllowancesAndDeductions(ObjPayrollEmployee, ObjPayrollPeriods);
                BPAY := ObjPayrollEmployee.basic_pay;
                Rec.RETAINER := ObjPayrollEmployee.Retainer;
                //Prorated On THEN number OF days worked
                IF CALCDATE('CM', ObjPayrollEmployee.joining_date) = (ObjPayrollPeriods.end_date) THEN begin
                    NoOfDaysWorked := ObjPayrollPeriods.end_date - CALCDATE('-1D', ObjPayrollEmployee.joining_date);
                    ProratedBPAY := FnGetBpay(ObjPayrollEmployee.basic_pay, NoOfDaysWorked, DATE2DMY(ObjPayrollPeriods.end_date, 1));
                    rec.RETAINER := FnGetBpay(ObjPayrollEmployee.Retainer, NoOfDaysWorked, DATE2DMY(ObjPayrollPeriods.end_date, 1));
                    BPAY := ProratedBPAY;
                    //Process Prorated Payroll
                    IF BPAY > 0 THEN
                        FnProratedPayrollProcess(BPAY, ActivePeriod);
                    IF rec.RETAINER > 0 THEN
                        FnProratedPayrollProcess(rec.RETAINER, ActivePeriod);
                    IF (BPAY = 0) AND (rec.RETAINER = 0) THEN
                        FnProratedPayrollProcess(0, ActivePeriod);
                    IF (ObjPayrollEmployee.contract_end_date <> 0D) THEN begin

                    end;
                end else
                //-------------------------------Prorated On THEN number OF days worked
                begin
                    IF CALCDATE('CM', ObjPayrollEmployee.joining_date) <> (ObjPayrollPeriods.end_date) THEN begin
                        IF (ObjPayrollEmployee.contract_end_date <> 0D) THEN begin
                            IF ((CALCDATE('CM', ObjPayrollEmployee.contract_end_date)) = (ObjPayrollPeriods.end_date)) THEN begin
                                NoOfDaysWorked := CALCDATE('0D', ObjPayrollEmployee.contract_end_date) - ObjPayrollPeriods.start_date;
                                IF (DATE2DMY(ObjPayrollEmployee.contract_end_date, 1) <= 2) THEN
                                    NoOfDaysWorked := (ObjPayrollEmployee.contract_end_date) - ObjPayrollPeriods.start_date;
                                ProratedBPAY := FnGetBpay(ObjPayrollEmployee.basic_pay, NoOfDaysWorked, DATE2DMY(ObjPayrollPeriods.end_date, 1));

                                rec.RETAINER := FnGetBpay(ObjPayrollEmployee.Retainer, NoOfDaysWorked, DATE2DMY(ObjPayrollPeriods.end_date, 1));
                                BPAY := ProratedBPAY;

                                //------------------Process Prorated Payroll

                                IF BPAY > 0 THEN
                                    FnProratedPayrollProcess(BPAY, ActivePeriod);
                                IF rec.RETAINER > 0 THEN
                                    FnProratedPayrollProcess(rec.RETAINER, ActivePeriod);
                                IF (BPAY = 0) AND (rec.RETAINER = 0) THEN
                                    FnProratedPayrollProcess(0, ActivePeriod);
                            end;
                        end;
                        IF (ObjPayrollEmployee.contract_end_date = 0D) OR ((ObjPayrollEmployee.contract_end_date) >= (ObjPayrollPeriods.end_date)) THEN begin
                            //2a.---------BASIC PAY----------------------------------------------
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'BPAY', 'Basic Pay', 'INCOME', ROUND(BPAY, 1), 'BASIC PAY', ActivePeriod, '', '', FALSE, '');
                            //2b.--------- retainer----------------------------------------------
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'RETAINER', 'Retainer', 'INCOME', ROUND(rec.RETAINER, 1), 'Retainer', ActivePeriod, '', '', FALSE, '');
                            //3.-------- ALLOWANCES & DEDUCTIONS--------------------------------
                            TOT_DED := 0;
                            ObjPayrollAllowancesAndDeductions.RESET;
                            ObjPayrollAllowancesAndDeductions.SETRANGE(st_no, ObjPayrollEmployee.st_no);
                            ObjPayrollAllowancesAndDeductions.SETRANGE(period_code, ActivePeriod);
                            ObjPayrollAllowancesAndDeductions.SETFILTER(ObjPayrollAllowancesAndDeductions.group_title, '<>%1', 'BENEFIT');
                            IF ObjPayrollAllowancesAndDeductions.FIND('-') THEN begin
                                REPEAT

                                    //insert into member ledger Entry

                                    //     IF  ObjPayrollAllowancesAndDeductions.transaction_name='Savings' THEN 
                                    //       InsertMemberLedgerEntry('',ObjPayrollEmployee.st_no,ObjPayrollEmployee.Name,transType::"Savings to Savings",ObjPayrollAllowancesAndDeductions.amount,ObjPayrollPeriods.end_date);
                                    //     FnInsertPayrollTransactions(ObjPayrollEmployee.st_no,ObjPayrollAllowancesAndDeductions.transaction_code,
                                    //     ObjPayrollAllowancesAndDeductions.transaction_name+' '+ObjPayrollAllowancesAndDeductions."loan type",FORMAT(ObjPayrollAllowancesAndDeductions.amount_reference),
                                    //    ROUND(ObjPayrollAllowancesAndDeductions.amount,1),ObjPayrollAllowancesAndDeductions.group_title,ActivePeriod,ObjPayrollAllowancesAndDeductions."loan No",ObjPayrollAllowancesAndDeductions.gl_account_no,
                                    //    ObjPayrollAllowancesAndDeductions."Sacco Deduction",ObjPayrollAllowancesAndDeductions."loan type");

                                    //TODO Update reporting table
                                    IF ObjPayrollAllowancesAndDeductions.group_title = 'DEDUCTION' THEN BEGIN
                                        //------------------------Get the Taxable Deductions to be deducted from the Grosspay
                                        IF FnCheckTaxable(ObjPayrollAllowancesAndDeductions.transaction_code) THEN
                                            TOT_TAXABLE_DED := TOT_TAXABLE_DED + ObjPayrollAllowancesAndDeductions.amount;
                                        //------------------------Get the Taxable Deductions to be deducted from the Grosspay


                                        TOT_DED := TOT_DED + ObjPayrollAllowancesAndDeductions.amount;

                                    END
                                    ELSE
                                        TOT_ALLOWANCE := TOT_ALLOWANCE + ObjPayrollAllowancesAndDeductions.amount;

                                    IF ObjPayrollAllowancesAndDeductions.taxable = FALSE THEN BEGIN
                                        IF ObjPayrollAllowancesAndDeductions.group_title <> 'DEDUCTION' THEN BEGIN
                                            IF ObjPayrollAllowancesAndDeductions.transaction_code <> '' THEN
                                                totAllowancenontaxable := totAllowancenontaxable + ObjPayrollAllowancesAndDeductions.amount;
                                        END;
                                    END;
                                UNTIL ObjPayrollAllowancesAndDeductions.NEXT = 0;
                            end;
                            //Morgage Interest Deduction

                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'MORG', 'Morgage Interest', 'DEDUCTION', ObjPayrollEmployee."Mortgage Interest", 'STATUTORIES', ActivePeriod, '', '', ObjPayrollAllowancesAndDeductions."Sacco Deduction", '');
                            //End Morgage Interest Deduction
                            TOT_DED := TOT_DED + ObjPayrollEmployee."Mortgage Interest";
                            //Calculate total Benefits
                            tot_benefits := 0;
                            ObjPayrollAllowancesAndDeductions.RESET;
                            ObjPayrollAllowancesAndDeductions.SETRANGE(st_no, ObjPayrollEmployee.st_no);
                            ObjPayrollAllowancesAndDeductions.SETRANGE(period_code, ActivePeriod);
                            ObjPayrollAllowancesAndDeductions.SETRANGE(ObjPayrollAllowancesAndDeductions.group_title, 'BENEFIT');
                            IF ObjPayrollAllowancesAndDeductions.FIND('-') THEN begin
                                REPEAT

                                    FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, ObjPayrollAllowancesAndDeductions.transaction_code,
                                    ObjPayrollAllowancesAndDeductions.transaction_name + ' ' + ObjPayrollAllowancesAndDeductions."loan type", FORMAT(ObjPayrollAllowancesAndDeductions.amount_reference),
                                   ROUND(ObjPayrollAllowancesAndDeductions.amount, 1), ObjPayrollAllowancesAndDeductions.group_title, ActivePeriod, ObjPayrollAllowancesAndDeductions."loan No", ObjPayrollAllowancesAndDeductions.gl_account_no,
                                   ObjPayrollAllowancesAndDeductions."Sacco Deduction", '');
                                    tot_benefits := tot_benefits + ObjPayrollAllowancesAndDeductions.amount;
                                UNTIL ObjPayrollAllowancesAndDeductions.NEXT = 0;
                            end;
                            //4.---------GROSSPAY----------------------------------------------
                            GPAY := BPAY + TOT_ALLOWANCE - TOT_TAXABLE_DED + rec.RETAINER;

                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'GPAY', 'Gross Pay', 'INCOME', ROUND(GPAY, 1), 'GROSS PAY', ActivePeriod, '', '', FALSE, '');
                            //5.---------TAX CALCUATIONS----------------------------------------------
                            //A.---------DEFCON-------------------------------------------------------
                            ObjSetup.GET();
                            //B.---------PNSR    PENSION INFORMATION ----------------------------------------------------------
                            TaxBracketRate := FnGetTaxBracketRate(GPAY);
                            IF (ObjPayrollEmployee."Pension Contribution" + DEFCON) > ObjSetup."Maximum Pension Relief" THEN
                                ObjPayrollEmployee."Pension Contribution" := ObjSetup."Maximum Pension Relief" - DEFCON;

                            PENS := ObjPayrollEmployee."Pension Contribution";
                            PENSR := ObjPayrollEmployee."Pension Contribution" * (TaxBracketRate / 100);
                            IF PENSR > 0 THEN
                                FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'PENSR', 'Pension Relief', 'INCOME', ROUND(PENSR, 1), 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
                            //C.---------PERR----------------------------------------------------------
                            PERR := ObjSetup."Personal Relief";//1408;
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'PERR', 'Personal Relief', 'INCOME', PERR, 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
                            //---------      NHIF RELIEF----------------------------------------------------------
                            NHIF := returnNHIFAmount(GPAY);
                            NHIFRelief := 0;
                            NHIFRelief := NHIF * 0.15;
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'NHIFRELIEF', 'Nhif Relief', 'INCOME', ROUND(NHIFRelief, 1), 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
                            //---------  INSURANCE RELIEF----------------------------------------------------------
                            INSURELIEF := ObjPayrollEmployee."Instalment Premium" * 0.15;

                            IF (NHIFRelief + INSURELIEF) > 5000 THEN
                                INSURELIEF := 5000 - NHIFRelief;
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'INSURELIEF', 'Insurance Relief', 'INCOME', ROUND(INSURELIEF, 1), 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
                            //D.---------TXBP----------------------------------------------------------
                            TXBP := GPAY - (DEFCON + PENS + MORG);
                            IF ObjSetup.GET() THEN
                                NSSF := ObjSetup."NSSF Amount";

                            NSSF := returnNSSFAmount(GPAY);
                            IF ObjPayrollEmployee.pays_nssf = FALSE THEN
                                NSSF := 0;

                            IF GPAY >= 18000 THEN
                                NSSF := 1080;
                            TXBP := (TXBP + tot_benefits) - NSSF;
                            TXBP := TXBP - totAllowancenontaxable;
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'TXBP', 'Taxable Pay', 'INCOME', ROUND(TXBP, 1), 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');

                            //E.---------TXCHRG---------------------------------------------------------
                            IF ((TXBP <= ObjSetup.minimum_taxable) OR (ObjPayrollEmployee.pays_paye = FALSE)) THEN
                                TXBP := 0;

                            TXBP := TXBP;
                            TXCHRG := CFTFactory.FnCalculatePaye(TXBP);
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'TXCHRG', 'Tax Charged', 'INCOME', ROUND(TXCHRG, 1, '>'), 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
                            //6.---------STATUTORY DEDUCTIONS-----------------------------------
                            //A.-----------NSSF----------------------------------------------
                            IF (ObjPayrollEmployee.pays_nssf) THEN begin
                                IF ObjSetup.GET() THEN
                                    NSSF := ObjSetup."NSSF Amount";
                            end;
                            NSSF := returnNSSFAmount(GPAY);
                            IF ObjPayrollEmployee.pays_nssf = FALSE THEN
                                NSSF := 0;

                            IF GPAY >= 18000 THEN
                                NSSF := 1080;
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'NSSF', 'NSSF', 'DEDUCTION', NSSF, 'STATUTORIES', ActivePeriod, '', '', FALSE, '');
                            HouseLvy := GPAY * 0.015;
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'HOUSELVY', 'HouseLvy', 'DEDUCTION', HouseLvy, 'STATUTORIES', ActivePeriod, '', '', FALSE, '');
                            //*******************end housing*************

                            //B.-----------NHIF--------------------------------------------------
                            IF ((ObjPayrollEmployee.pays_nhif)) THEN
                                NHIF := returnNHIFAmount(GPAY);

                            IF ObjPayrollEmployee.pays_nhif = FALSE THEN
                                NHIF := 0;

                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'NHIF', 'NHIF', 'DEDUCTION', NHIF, 'STATUTORIES', ActivePeriod, '', '', FALSE, '');
                            //C.-----------PAYE--------------------------------------------------
                            IF (ObjPayrollEmployee.pays_paye) THEN BEGIN
                                TXBP := TXBP;//-(ObjPayrollEmployee."Mortgage Interest"-INSURELIEF);
                                TXCHRG := ROUND(TXCHRG, 1, '>');
                                PAYE := TXCHRG - (PERR + INSURELIEF + NHIFRelief);//CFTFactory.FnCalculatePaye(TXBP)

                                IF PAYE < 0 THEN
                                    PAYE := 0;

                                IF ObjPayrollEmployee.pays_paye = FALSE THEN
                                    PAYE := 0;
                                FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'PAYE', 'PAYE', 'DEDUCTION', ROUND(PAYE, 1), 'STATUTORIES', ActivePeriod, '', '', FALSE, '');
                            END;
                            //7.-------------------TOTDED----------------------------------------

                            TOTDED := (PAYE + NSSF + NHIF + HouseLvy + TOT_DED);//+ObjPayrollEmployee."Mortgage Interest"; //TOT_TAXABLE_DED

                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'TOTDED', 'Total Deductions', 'DEDUCTION', ROUND(TOTDED, 1), 'DEDUCTIONS', ActivePeriod, '', '', FALSE, '');

                            //8.-------------------NETPAY----------------------------------------
                            NPAY := GPAY - TOTDED;
                            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'NPAY', 'Net Pay', 'INCOME', ROUND(NPAY, 1), 'NET PAY', ActivePeriod, '', '', FALSE, '');
                        end;
                    end;
                end;
            UNTIL ObjPayrollEmployee.NEXT = 0;
        end;
    end;

    procedure FnPopulateMandatoryAllowancesAndDeductions(ObjEmployee: Record pr_employees; ObjPeriod: Record pr_periods)
    begin
        ObjPayrollTransactionType.RESET;
        ObjPayrollTransactionType.SETRANGE(ObjPayrollTransactionType.is_mandatory, TRUE);
        IF ObjPayrollTransactionType.FIND('-') THEN begin
            repeat
                amount := 0;
                amount := ObjPayrollTransactionType.amount;
                IF ((ObjPayrollTransactionType.is_percentage <> 0))
                  THEN
                    amount := ObjPayrollTransactionType.percentage * ObjEmployee.basic_pay / 100;

                ObjPayrollAllowancesAndDeductions.INIT;
                ObjPayrollAllowancesAndDeductions.st_no := ObjEmployee.st_no;
                ObjPayrollAllowancesAndDeductions.transaction_code := ObjPayrollTransactionType.code;
                ObjPayrollAllowancesAndDeductions.transaction_name := ObjPayrollTransactionType.trans_name;
                ObjPayrollAllowancesAndDeductions.amount := amount;
                ObjPayrollAllowancesAndDeductions.taxable := ObjPayrollTransactionType.taxable;
                ObjPayrollAllowancesAndDeductions.period_month := ObjPeriod.period_month;
                ObjPayrollAllowancesAndDeductions.period_year := ObjPeriod.period_year;
                ObjPayrollAllowancesAndDeductions.period_code := ObjPeriod.period_code;
                ObjPayrollAllowancesAndDeductions.group_order := ObjPayrollTransactionType.group_order;
                ObjPayrollAllowancesAndDeductions.sub_group_order := ObjPayrollTransactionType.sub_group_order;
                ObjPayrollAllowancesAndDeductions.gl_account_no := ObjPayrollTransactionType.acc_no;
                ObjPayrollAllowancesAndDeductions.gl_account_name := ObjPayrollTransactionType.gl_account_name;
                ObjPayrollAllowancesAndDeductions.amount_reference := ObjPayrollTransactionType.amount_reference;
                ObjPayrollAllowancesAndDeductions.group_title := ObjPayrollTransactionType.group_title;

                IF (amount > 0)
                THEN
                    ObjPayrollAllowancesAndDeductions.INSERT;
            UNTIL ObjPayrollTransactionType.NEXT = 0;
        end;
    end;

    procedure FnGetBpay(BasicPay: Decimal; NoOfDaysWorked: Integer; DaysInMonth: Integer): Decimal
    var
        BasicPayAmount: Decimal;
    begin
        BasicPayAmount := ROUND((NoOfDaysWorked * BasicPay) / DaysInMonth, 0.01, '=');
        EXIT(BasicPayAmount);
    end;

    procedure FnProratedPayrollProcess(BPAY: Decimal; ActivePeriod: Code[20])
    begin
        //BASIC 
        IF ObjPayrollEmployee.basic_pay > 0 THEN
            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'BPAY', 'Basic Pay', 'INCOME', BPAY, 'BASIC PAY', ActivePeriod, '', '', FALSE, '');
        IF ObjPayrollEmployee.Retainer > 0 THEN
            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'RETAINER', 'Retainer', 'INCOME', ROUND(BPAY, 1), 'Retainer', ActivePeriod, '', '', FALSE, '');
        //ALLOWANCES & DEDUCTIONS
        ObjPayrollAllowancesAndDeductions.RESET;
        ObjPayrollAllowancesAndDeductions.SETRANGE(st_no, ObjPayrollEmployee.st_no);
        ObjPayrollAllowancesAndDeductions.SETRANGE(period_code, ActivePeriod);

        IF ObjPayrollAllowancesAndDeductions.FIND('-') THEN begin
            repeat
                DeductedAmount := 0;
                DeductedAmount := ObjPayrollAllowancesAndDeductions.amount;
                IF (ObjPayrollAllowancesAndDeductions.transaction_code = 'HALLOWANCE') OR (ObjPayrollAllowancesAndDeductions.transaction_code = 'A005') THEN
                    DeductedAmount := FnGetBpay(ObjPayrollAllowancesAndDeductions.amount, NoOfDaysWorked, DATE2DMY(ObjPayrollPeriods.end_date, 1));
                FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, ObjPayrollAllowancesAndDeductions.transaction_code,
    ObjPayrollAllowancesAndDeductions.transaction_name, FORMAT(ObjPayrollAllowancesAndDeductions.amount_reference),
    DeductedAmount, ObjPayrollAllowancesAndDeductions.group_title, ActivePeriod, ObjPayrollAllowancesAndDeductions."loan No", '', ObjPayrollAllowancesAndDeductions."Sacco Deduction", '');
                //TODO Update reporting table
                IF ObjPayrollAllowancesAndDeductions.group_title = 'DEDUCTION' THEN begin
                    //------------------------Get the Taxable Deductions to be deducted from the Grosspay
                    IF FnCheckTaxable(ObjPayrollAllowancesAndDeductions.transaction_code) THEN
                        TOT_TAXABLE_DED := TOT_TAXABLE_DED + DeductedAmount;
                    //------------------------Get the Taxable Deductions to be deducted from the Grosspay
                    TOT_DED := TOT_DED + DeductedAmount
                end
                else
                    TOT_ALLOWANCE := TOT_ALLOWANCE + DeductedAmount;
                IF ObjPayrollAllowancesAndDeductions.taxable = FALSE THEN
                    totAllowancenontaxable := totAllowancenontaxable + DeductedAmount;
            UNTIL ObjPayrollAllowancesAndDeductions.NEXT = 0;
        end;
        //4.---------GROSSPAY----------------------------------------------
        GPAY := BPAY + TOT_ALLOWANCE - TOT_TAXABLE_DED;
        GPAY := ROUND(GPAY, 1);
        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'GPAY', 'Gross Pay', 'INCOME', GPAY, 'GROSS PAY', ActivePeriod, '', '', FALSE, '');
        ProratedGPAY := GPAY;
        //5.---------TAX CALCUATIONS----------------------------------------------
        //A.---------DEFCON-------------------------------------------------------
        ObjSetup.GET();
        //B.---------PNSR    PENSION INFORMATION ----------------------------------------------------------
        TaxBracketRate := FnGetTaxBracketRate(GPAY);
        IF (ObjPayrollEmployee."Pension Contribution" + DEFCON) > ObjSetup."Maximum Pension Relief" THEN
            ObjPayrollEmployee."Pension Contribution" := ObjSetup."Maximum Pension Relief" - DEFCON;
        PENS := ObjPayrollEmployee."Pension Contribution";
        PENSR := ObjPayrollEmployee."Pension Contribution" * (TaxBracketRate / 100);
        IF PENSR > 0 THEN
            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'PENSR', 'Pension Relief', 'INCOME', ROUND(PENSR, 1), 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
        //---------MORTGAGE INFORMATION
        IF ObjPayrollEmployee."Mortgage Interest" > ObjSetup."Maximum Morgage Relief" THEN
            ObjPayrollEmployee."Mortgage Interest" := ObjSetup."Maximum Morgage Relief";
        //C.---------PERR----------------------------------------------------------
        PERR := ObjSetup."Personal Relief";//1408;
        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'PERR', 'Personal Relief', 'INCOME', PERR, 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
        //D.---------TXBP----------------------------------------------------------

        IF ObjSetup.GET() THEN
            NSSF := ObjSetup."NSSF Amount";
        NSSF := returnNSSFAmount(ProratedGPAY);
        IF ObjPayrollEmployee.pays_nssf = FALSE THEN
            NSSF := 0;
        IF ProratedGPAY >= 18000 THEN
            NSSF := 1080;
        IF ProratedBPAY > 0 THEN
            GPAY := ProratedGPAY;
        TXBP := GPAY - NSSF;
        TXBP := ROUND(TXBP, 1);
        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'TXBP', 'Taxable Pay', 'INCOME', TXBP, 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
        //E.---------TXCHRG---------------------------------------------------------
        IF ((TXBP <= ObjSetup.minimum_taxable) OR (ObjPayrollEmployee.pays_paye = FALSE)) THEN
            TXBP := 0;

        TXCHRG := ROUND(CFTFactory.FnCalculatePaye(TXBP), 1);

        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'TXCHRG', 'Tax Charged', 'INCOME', TXCHRG, 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
        //6.---------STATUTORY DEDUCTIONS-----------------------------------
        //A.-----------NSSF----------------------------------------------
        IF ProratedBPAY > 0 THEN
            GPAY := ObjPayrollEmployee.basic_pay + TOT_ALLOWANCE - TOT_TAXABLE_DED;
        IF (ObjPayrollEmployee.pays_nssf) THEN BEGIN
            IF ObjSetup.GET() THEN
                NSSF := ObjSetup."NSSF Amount"
        END;
        NSSF := ROUND(returnNSSFAmount(ProratedGPAY), 1);
        IF ObjPayrollEmployee.pays_nssf = FALSE THEN
            NSSF := 0;

        IF ProratedGPAY > 18000 THEN
            NSSF := 1080;

        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'NSSF', 'NSSF', 'DEDUCTION', NSSF, 'STATUTORIES', ActivePeriod, '', '', FALSE, '');
        //*****************************Housing Levy**********
        //  IF((ObjPayrollEmployee.Pays_Hoising)) THEN
        HouseLvy := ProratedGPAY * 0.015;
        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'HOUSELVY', 'HouseLvy', 'DEDUCTION', HouseLvy, 'STATUTORIES', ActivePeriod, '', '', FALSE, '');

        //****************************************************
        //B.-----------NHIF--------------------------------------------------
        IF ProratedBPAY > 0 THEN
            BPAY := ObjPayrollEmployee.basic_pay;
        IF ((ObjPayrollEmployee.pays_nhif)) THEN  //AND (BPAY >0))
            NHIF := returnNHIFAmount(ProratedGPAY);
        IF ((ObjPayrollEmployee.pays_nhif) AND (BPAY = 0)) THEN
            NHIF := returnNHIFAmount((TOT_ALLOWANCE - TOT_TAXABLE_DED));
        NHIF := returnNHIFAmount((ProratedGPAY));
        IF ObjPayrollEmployee.pays_nhif = FALSE THEN
            NHIF := 0;
        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'NHIF', 'NHIF', 'DEDUCTION', NHIF, 'STATUTORIES', ActivePeriod, '', '', FALSE, '');
        IF ProratedBPAY > 0 THEN BEGIN
            GPAY := ProratedGPAY;
            BPAY := ProratedBPAY;
        END;
        //---------      NHIF RELIEF----------------------------------------------------------
        NHIF := returnNHIFAmount(ProratedGPAY);
        NHIFRelief := 0;
        NHIFRelief := NHIF * 0.15;
        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'NHIFRELIEF', 'Nhif Relief', 'INCOME', ROUND(NHIFRelief, 1), 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
        //---------  INSURANCE RELIEF----------------------------------------------------------
        INSURELIEF := ObjPayrollEmployee."Instalment Premium" * 0.15;

        IF (NHIFRelief + INSURELIEF) > 5000 THEN
            INSURELIEF := 5000 - NHIFRelief;
        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'INSURELIEF', 'Insurance Relief', 'INCOME', ROUND(INSURELIEF, 1), 'TAX CALCULATIONS', ActivePeriod, '', '', FALSE, '');
        //C.-----------PAYE--------------------------------------------------
        IF (ObjPayrollEmployee.pays_paye) THEN BEGIN

            // PAYE:=CFTFactory.FnCalculatePaye(TXBP);//-(PERR);//INSR;
            PAYE := TXCHRG - (PERR + INSURELIEF + NHIFRelief);//CFTFactory.FnCalculatePaye(TXBP)

            IF PAYE < 0 THEN
                PAYE := 0;
            IF ObjPayrollEmployee.pays_paye = FALSE THEN
                PAYE := 0;
            FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'PAYE', 'PAYE', 'DEDUCTION', ROUND(PAYE, 1), 'STATUTORIES', ActivePeriod, '', '', FALSE, '');
        END;

        //7.-------------------TOTDED----------------------------------------
        TOTDED := (TOT_DED - TOT_TAXABLE_DED) + NSSF + NHIF + PAYE + HouseLvy;

        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'TOTDED', 'Total Deductions', 'DEDUCTION', ROUND(TOTDED, 1), 'DEDUCTIONS', ActivePeriod, '', '', FALSE, '');

        //8.-------------------NETPAY----------------------------------------
        NPAY := GPAY - TOTDED;
        NPAY := ROUND(NPAY, 1);
        FnInsertPayrollTransactions(ObjPayrollEmployee.st_no, 'NPAY', 'Net Pay', 'INCOME', NPAY, 'NET PAY', ActivePeriod, '', '', FALSE, '');
    end;

    procedure FnInsertPayrollTransactions(st_no: Code[100]; trans_code: Code[100]; trans_name: Text[100]; trans_reference: Code[100]; Amount: Decimal; group_title: Code[100]; period_code: Code[100]; loanNo: Code[25]; Gl_account: Code[25]; saccoDeduction: Boolean; LoanType: Code[30])
    BEGIN
        ObjTransactions.INIT;
        ObjTransactions.staff_no := st_no;
        ObjTransactions.VALIDATE(staff_no);
        ObjTransactions.transaction_code := trans_code;
        ObjTransactions.VALIDATE(ObjTransactions.transaction_code);
        ObjTransactions.transaction_reference := trans_reference;
        ObjTransactions.transaction_name := trans_name;
        ObjTransactions.amount := Amount;
        ObjTransactions."Loan No" := loanNo;
        IF (trans_code = 'D005') OR (trans_code = 'D006') THEN BEGIN
            ObjTransactions.DeleteNotAllowed := TRUE;
            ObjTransactions.gl_account_no := Gl_account;
        END;
        IF (trans_code = 'D005') OR (trans_code = 'D006') OR (trans_code = 'D007') OR (trans_code = 'D010')
          OR (trans_code = 'D011') OR (trans_code = 'D008') THEN
            ObjTransactions."Sacco Deduction" := TRUE;
        ObjTransactions."Loan Product Type" := LoanType;
        ObjTransactions.group_title := group_title;
        ObjTransactions.period_code := period_code;
        ObjTransactions.VALIDATE(period_code);

        IF (ObjTransactions.amount > 0) THEN BEGIN
            ObjTransactions.INSERT;

        END;
    END;

    procedure FnCheckTaxable(Transcode: Code[50]): Boolean
    begin
        ObjPrtransactionTypes.RESET;
        ObjPrtransactionTypes.SETRANGE(ObjPrtransactionTypes.code, Transcode);
        IF ObjPrtransactionTypes.FIND('-') THEN
            EXIT(ObjPrtransactionTypes.taxable);
    end;

    procedure FnGetTaxBracketRate(TXBPAmt: Decimal): Decimal
    begin
        ObjTaxBracketSetup.RESET;
        ObjTaxBracketSetup.SETFILTER(ObjTaxBracketSetup."Lower Limit", '>=%1', TXBPAmt);
        IF ObjTaxBracketSetup.FIND('-') THEN BEGIN
            EXIT(ObjTaxBracketSetup.Percentage);
        END ELSE BEGIN
            ObjTaxBracketSetup.RESET;
            IF ObjTaxBracketSetup.FIND('+') THEN
                EXIT(ObjTaxBracketSetup.Percentage);
        END
    end;

    procedure returnNSSFAmount(Chargeable: Decimal): Decimal
    var
        PAYE: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        BAND6: Decimal;
        BAND7: Decimal;
        BAND8: Decimal;
        BAND9: Decimal;

    begin
        PAYE := 0;
        BAND1 := 0;
        BAND2 := 0;
        BAND3 := 0;
        BAND4 := 0;
        BAND5 := 0;
        BAND6 := 0;
        BAND7 := 0;
        BAND8 := 0;
        BAND9 := 0;
        ObjNSSF.RESET;
        ObjNSSF.SETRANGE(nssf_band);
        IF ObjNSSF.FIND('-') THEN BEGIN
            REPEAT
                IF Chargeable > 0 THEN BEGIN
                    CASE ObjNSSF.nssf_band OF
                        '01':
                            BEGIN
                                IF (Chargeable > ObjNSSF.upper_limit) THEN BEGIN
                                    BAND1 := FnGetNSSFBudCharge('01');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;

                                END
                                ELSE BEGIN
                                    IF (Chargeable > ObjNSSF.taxable_amount) THEN BEGIN
                                        BAND1 := FnGetNSSFBudCharge('01');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    END
                                    ELSE BEGIN
                                        BAND1 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    END
                                END

                            END;

                        '02':
                            BEGIN
                                IF (Chargeable > ObjNSSF.upper_limit) THEN BEGIN
                                    BAND2 := FnGetNSSFBudCharge('02');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                END ELSE BEGIN
                                    IF (Chargeable > ObjNSSF.taxable_amount) THEN BEGIN
                                        BAND2 := FnGetNSSFBudCharge('02');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    END ELSE BEGIN
                                        BAND2 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    END
                                END
                            END;

                        '03':
                            BEGIN
                                IF (Chargeable > ObjNSSF.upper_limit) THEN BEGIN
                                    BAND3 := FnGetNSSFBudCharge('03');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                END ELSE BEGIN
                                    IF (Chargeable > ObjNSSF.taxable_amount) THEN BEGIN
                                        BAND3 := FnGetNSSFBudCharge('03');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    END ELSE BEGIN
                                        BAND3 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    END
                                END
                            END;

                        '04':
                            BEGIN
                                IF (Chargeable > ObjNSSF.upper_limit) THEN BEGIN
                                    BAND4 := FnGetNSSFBudCharge('04');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                END ELSE BEGIN
                                    IF (Chargeable > ObjNSSF.taxable_amount) THEN BEGIN
                                        BAND4 := FnGetNSSFBudCharge('04');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    END ELSE BEGIN
                                        BAND4 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    END
                                END
                            END;

                        '05':
                            BEGIN
                                IF (Chargeable > ObjNSSF.upper_limit) THEN BEGIN
                                    BAND5 := FnGetNSSFBudCharge('05');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                END ELSE BEGIN
                                    IF (Chargeable > ObjNSSF.taxable_amount) THEN BEGIN
                                        BAND5 := FnGetNSSFBudCharge('05');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    END ELSE BEGIN
                                        BAND5 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    END
                                END
                            END;

                        '06':
                            BEGIN
                                IF (Chargeable > ObjNSSF.upper_limit) THEN BEGIN
                                    BAND6 := FnGetNSSFBudCharge('06');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                END ELSE BEGIN
                                    IF (Chargeable > ObjNSSF.taxable_amount) THEN BEGIN
                                        BAND6 := FnGetNSSFBudCharge('06');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    END ELSE BEGIN
                                        BAND6 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    END
                                END
                            END;

                        '07':
                            BEGIN
                                IF (Chargeable > ObjNSSF.upper_limit) THEN BEGIN
                                    BAND7 := FnGetNSSFBudCharge('07');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                END ELSE BEGIN
                                    IF (Chargeable > ObjNSSF.taxable_amount) THEN BEGIN
                                        BAND7 := FnGetNSSFBudCharge('07');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    END ELSE BEGIN
                                        BAND7 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    END
                                END
                            END;
                        '08':
                            BEGIN
                                IF (Chargeable > ObjNSSF.upper_limit) THEN BEGIN
                                    BAND8 := FnGetNSSFBudCharge('08');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                END ELSE BEGIN
                                    IF (Chargeable > ObjNSSF.taxable_amount) THEN BEGIN
                                        BAND8 := FnGetNSSFBudCharge('08');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    END ELSE BEGIN
                                        BAND8 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    END
                                END
                            END;

                        '09':
                            BEGIN
                                IF (Chargeable > ObjNSSF.upper_limit) THEN BEGIN
                                    BAND9 := FnGetNSSFBudCharge('09');
                                    Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                END ELSE BEGIN
                                    IF (Chargeable > ObjNSSF.taxable_amount) THEN BEGIN
                                        BAND9 := FnGetNSSFBudCharge('09');
                                        Chargeable := Chargeable - ObjNSSF.taxable_amount;
                                    END ELSE BEGIN
                                        BAND9 := Chargeable * FnNSSFRate();
                                        Chargeable := 0;
                                    END
                                END
                            END




                    END
                END
            UNTIL ObjNSSF.NEXT = 0;
        END;
        EXIT(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 + BAND6 + BAND7 + BAND8 + BAND9);
    end;

    procedure FnGetNSSFBudCharge(ChargeCode: Code[100]): Decimal
    begin
        ObjNssf_param.RESET;
        ObjNssf_param.SETRANGE(nssf_band, ChargeCode);
        IF ObjNssf_param.FIND('-') THEN
            EXIT(ObjNssf_param.taxable_amount * 6 / 100)

    end;

    procedure FnNSSFRate(): Decimal
    begin
        EXIT(6 / 100);
    end;

    procedure returnNHIFAmount(Amount: Decimal): Decimal
    begin
        ObjNHIF.RESET;
        ObjNHIF.SETFILTER(lower_limit, '<=%1', Amount);
        ObjNHIF.SETFILTER(upper_limit, '>=%1', Amount);
        IF ObjNHIF.FIND('-') THEN
            EXIT(ObjNHIF.amount);
    end;

    var
        myInt: Integer;
        ObjPayrollPeriods: Record pr_periods;
        ActivePeriod: Code[100];
        ObjPayrollTransactions: Record pr_transaction_reports;
        ObjTransactions: Record pr_transactions;
        ObjPayrollTransactionType: Record pr_transaction_types;
        ObjPayrollAllowancesAndDeductions: Record pr_allowances_and_deductions;
        ObjPayrollEmployee: Record pr_employees;
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

        INSR: Decimal;
        MORGR: Decimal;
        MORG: Decimal;
        PENSR: Decimal;
        PENS: Decimal;
        INSURELIEF: Decimal;
        HouseCon: Decimal;
        HouseLvy: Decimal;
        ProratedBPAY: Decimal;
        ProratedGPAY: Decimal;
        TOT_TAXABLE_DED: Decimal;
        totAllowancenontaxable: Decimal;
        TaxBracketRate: Decimal;
        ObjSetup: Record "Payroll General Setup";
        amount: Decimal;
        NoOfDaysWorked: Decimal;
        DeductedAmount: Decimal;
        ObjPrtransactionTypes: Record pr_transaction_types;
        ObjTaxBracketSetup: Record "Tax Bracket Setup";
        ObjNSSF: Record pr_nssfs;
        ObjNssf_param: Record pr_nssfs;
        ObjNHIF: Record pr_nhifs;
        NHIFRelief: Decimal;
        tot_benefits: Decimal;
}