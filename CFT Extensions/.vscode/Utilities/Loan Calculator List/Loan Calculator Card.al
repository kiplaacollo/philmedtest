page 50179 "Loan Calculator"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Calculator";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Calculator Type"; Rec."Calculator Type")
                {
                    trigger OnValidate()
                    begin
                        FnRunEnableGroupings();
                    end;
                }
                field("Loan Type"; Rec."Loan Type")
                {

                }
                field("Product Description"; Rec."Product Description")
                {
                    Editable = false;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {

                }
                field("Loan Tenure"; Rec."Loan Tenure")
                {

                }
            }
            group("Installment From Proposed Amount")
            {
                Visible = VarInstallmentFromAmouint;
                field("Requested Amount"; Rec."Requested Amount")
                {

                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    Editable = false;
                }
                field("Disbursement Details"; Rec."Disbursement Details")
                {
                    trigger OnValidate()
                    begin
                        if Rec."Disbursement Details" = true then begin
                            Rec."Disbursement Date" := 0D;
                            Rec."Repayment Debut Date" := 0D;
                            Rec."First Repayment" := 0;
                            Rec."No of Repayment Holidays" := 0;
                            ActionDetailedDisbursement := true;
                        end else begin
                            Rec."Disbursement Date" := 0D;
                            Rec."Repayment Debut Date" := 0D;
                            Rec."First Repayment" := 0;
                            Rec."No of Repayment Holidays" := 0;
                            ActionDetailedDisbursement := false;
                        end;
                    end;
                }
            }
            group("Disbursement Information")
            {
                Visible = ActionDetailedDisbursement;
                field("Disbursement Date"; Rec."Disbursement Date")
                {

                }
                field("Repayment Debut Date"; Rec."Repayment Debut Date")
                {

                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {

                }
                field("No of Repayment Holidays"; Rec."No of Repayment Holidays")
                {

                }
                field("First Repayment"; Rec."First Repayment")
                {

                }
            }
            group("Amount From Proposed Installment")
            {
                Visible = VarAmountFromInstalments;
                field("Expected Instalment"; Rec."Expected Instalment")
                {

                }
                field("Qualifying Amount"; Rec."Qualifying Amount")
                {

                }
            }
            group("Eligibility Calculator")
            {
                Visible = VarEligibilityCalculator;
                field("No of Students"; Rec."No of Students")
                {

                }
                field("Average Fee Per Term"; Rec."Average Fee Per Term")
                {

                }
                field("Fee Collection Efficiency(%)"; Rec."Fee Collection Efficiency(%)")
                {

                }
                field("Gross Fee Income"; Rec."Gross Fee Income")
                {
                    Editable = false;
                }
                group("Monthly Expenses")
                {
                    field(Rent; Rec.Rent)
                    {

                    }
                    field(Rent_multi; Rec.Rent_multi)
                    {

                    }
                    field(Salaries; Rec.Salaries)
                    {

                    }
                    field(Salaries_multi; Rec.Salaries_multi)
                    {

                    }
                    field("Business Permit"; Rec."Business Permit")
                    {

                    }
                    field("Business Permit_multi"; Rec."Business Permit_multi")
                    {

                    }
                    field("Cost Of Meals"; Rec."Cost Of Meals")
                    {

                    }
                    field("Cost Of Meals_multi"; Rec."Cost Of Meals_multi")
                    {

                    }
                    field("All Other Expenses"; Rec."All Other Expenses")
                    {

                    }
                    field("All Other Expenses_multi"; Rec."All Other Expenses_multi")
                    {

                    }
                    field("Annual Net Fee Income"; Rec."Annual Net Fee Income")
                    {
                        Editable = false;
                    }
                    field("Maximum Profitability Margin"; Rec."Maximum Profitability Margin")
                    {
                        Editable = false;
                    }
                    field("Net Appraised Monthly Income"; Rec."Net Appraised Monthly Income")
                    {
                        Editable = false;
                    }
                    field("Existing EMI"; Rec."Existing EMI")
                    {

                    }
                    field("Varthana EMI"; Rec."Varthana EMI")
                    {
                        Editable = false;
                    }
                    field(VarMaximumEligibleAmount; VarMaximumEligibleAmount)
                    {
                        Caption = 'Maximum Eligible Amount';
                        Editable = false;
                    }

                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                ApplicationArea = All;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Rec."Calculator Type" = Rec."Calculator Type"::"Instalment From Requested Amount" then begin
                        if Rec."Repayment Method" = Rec."Repayment Method"::Amortized then begin
                            Rec."Monthly Repayment" := Round((Rec."Interest Rate" / 12 / 100) / (1 - Power((1 + (Rec."Interest Rate" / 12 / 100)), -Rec."Loan Tenure")) * Rec."Requested Amount", 1, '>');
                        end;
                        if Rec."Repayment Method" = Rec."Repayment Method"::"Straight Line" then begin
                            VarLoanPrinciple := Round(Rec."Requested Amount" / Rec."Loan Tenure", 1, '>');
                            VarLoanInterest := Round((Rec."Interest Rate" / 1200) * Rec."Requested Amount", 1, '>');
                            Rec."Monthly Repayment" := VarLoanPrinciple + VarLoanInterest;
                        end;
                        if Rec."Disbursement Details" = true then
                            FnGenerateRepaymentSchedule(Rec."Document No");

                    end;
                    // Get Qualifying Amount From Instalment
                    if Rec."Calculator Type" = Rec."Calculator Type"::"Qualifying Amount From Proposed Instalment" then begin
                        if Rec."Repayment Method" = Rec."Repayment Method"::Amortized then
                            Rec."Qualifying Amount" := Round(Rec."Expected Instalment" * ((Power((1 + rec."Interest Rate" / 1200), Rec."Loan Tenure") - 1) / ((rec."Interest Rate" / 1200) * (Power((1 + Rec."Interest Rate" / 1200), Rec."Loan Tenure")))), 1, '=');
                    end;
                    VarMonthlyNetFeeIncome := Round(Rec."Annual Net Fee Income" / 12, 0.01 / '=');
                    VarMaximumMonthlyProfitability := Round(Rec."Maximum Profitability Margin" / 12, 0.01, '=');
                    if Rec."Calculator Type" = Rec."Calculator Type"::"Eligibility Calculator" then begin
                        if VarMonthlyNetFeeIncome < VarMaximumMonthlyProfitability then begin
                            Rec."Net Appraised Monthly Income" := VarMonthlyNetFeeIncome
                        end
                        else
                            if VarMaximumMonthlyProfitability < VarMonthlyNetFeeIncome then begin
                                Rec."Net Appraised Monthly Income" := VarMaximumMonthlyProfitability
                            end;
                        Rec."Varthana EMI" := Rec."Net Appraised Monthly Income" - Rec."Existing EMI";
                        VarMaximumEligibleAmount := ROUND(Rec."Varthana EMI" * ((POWER((1 + Rec."Interest Rate" / 1200), rec."Loan Tenure") - 1) / ((rec."Interest Rate" / 1200) * (POWER((1 + rec."Interest Rate" / 1200), rec."Loan Tenure")))), 1, '=');
                    end;
                end;
            }
            action("Clear Calculator")
            {
                ApplicationArea = all;
                Image = ClearLog;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ObjLoanCalculator: Record "Loan Calculator";
                begin
                    ObjLoanCalculator.Reset();
                    ObjLoanCalculator.DeleteAll();
                    ObjLoanCalculator.Init();
                    ObjLoanCalculator."Document No" := 'CALC_00001';
                    ObjLoanCalculator.Insert();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec."Repayment Frequency" := Rec."Repayment Frequency"::Monthly;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec."Repayment Frequency" := rec."Repayment Frequency"::Monthly;
    end;

    trigger OnAfterGetRecord()
    begin
        FnRunEnableGroupings();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Repayment Frequency" := Rec."Repayment Frequency"::Monthly;
    end;

    procedure FnRunEnableGroupings()
    begin
        VarAmountFromInstalments := false;
        VarInstallmentFromAmouint := false;
        VarEligibilityCalculator := false;
        ActionDetailedDisbursement := false;
        if Rec."Calculator Type" = Rec."Calculator Type"::"Instalment From Requested Amount" then
            VarInstallmentFromAmouint := true;
        if Rec."Calculator Type" = Rec."Calculator Type"::"Qualifying Amount From Proposed Instalment" then
            VarAmountFromInstalments := true;
        if Rec."Calculator Type" = Rec."Calculator Type"::"Eligibility Calculator" then
            VarEligibilityCalculator := true;
        if (Rec."Calculator Type" = Rec."Calculator Type"::"Instalment From Requested Amount") and (rec."Disbursement Details" = true) then
            ActionDetailedDisbursement := true;
    end;

    procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var



    begin
        HRepayment := 0;
        ActualTotalRepayment := 0;
        InstallmentOneRepayment := 0;

        ObjCalculator.RESET;
        ObjCalculator.SETRANGE(ObjCalculator."Document No", LoanNumber);
        ObjCalculator.SETFILTER(ObjCalculator."Requested Amount", '>%1', 0);
        IF ObjCalculator.FIND('-') THEN BEGIN
            IF (ObjCalculator."Repayment Debut Date" <> 0D) THEN BEGIN //(ObjCalculator."Repayment Debut Date"<>0D) AND (ObjCalculator."Repayment Debut Date"<>0D)
                ObjCalculator.TESTFIELD(ObjCalculator."Disbursement Date");
                ObjCalculator.TESTFIELD(ObjCalculator."Repayment Debut Date");


                IF rec."No of Repayment Holidays" > 0 THEN BEGIN
                    ActualTotalRepayment := FnGenerateNoHolidaysSchedule(ObjCalculator."Document No");
                END;


                RSchedule.RESET;
                RSchedule.SETRANGE(RSchedule."Loan No.", ObjCalculator."Document No");
                RSchedule.DELETEALL;

                LoanAmount := ObjCalculator."Requested Amount";
                InterestRate := ObjCalculator."Interest Rate";
                RepayPeriod := ObjCalculator."Loan Tenure";
                InitialInstal := ObjCalculator."Loan Tenure";
                LBalance := ObjCalculator."Requested Amount";
                RunDate := ObjCalculator."Repayment Debut Date";
                InstalNo := 0;



                // Ed Patners Repayment Holidays
                RepaymentHolidays := 0;
                //RepaymentHolidays := FnGetRepaymentHolidaysCount(ObjCalculator."Document No",RunDate);
                RepaymentHolidays := rec."No of Repayment Holidays";

                RepayPeriod := RepayPeriod - RepaymentHolidays;
                // Ed Patners Repayment Holidays



                //Repayment Frequency
                IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Daily THEN
                    RunDate := CALCDATE('-1D', RunDate)
                ELSE
                    IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Weekly THEN
                        RunDate := CALCDATE('-1W', RunDate)
                    ELSE
                        IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Monthly THEN
                            RunDate := CALCDATE('-1M', RunDate)
                        ELSE
                            IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Quarterly THEN
                                RunDate := CALCDATE('-1Q', RunDate);
                //Repayment Frequency


                REPEAT
                    InstalNo := InstalNo + 1;

                    IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Daily THEN
                        RunDate := CALCDATE('1D', RunDate)
                    ELSE
                        IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Weekly THEN
                            RunDate := CALCDATE('1W', RunDate)
                        ELSE
                            IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Monthly THEN
                                RunDate := CALCDATE('1M', RunDate)
                            ELSE
                                IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Quarterly THEN
                                    RunDate := CALCDATE('1Q', RunDate);

                    IF ObjCalculator."Repayment Method" = ObjCalculator."Repayment Method"::Amortized THEN BEGIN
                        ObjCalculator.TESTFIELD(ObjCalculator."Interest Rate");
                        ObjCalculator.TESTFIELD(ObjCalculator."Loan Tenure");
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - POWER((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;


                        IF InstalNo = 1 THEN BEGIN
                            DaysToAmortize := 0;
                            DaysToAmortize := ObjCalculator."Repayment Debut Date" - ObjCalculator."Disbursement Date";
                            IF DaysToAmortize <= 30 THEN BEGIN
                                LInterest := LoanAmount * (DaysToAmortize) / 30 * InterestRate / 1200;
                            END
                            ELSE BEGIN
                                LInterest := LoanAmount * InterestRate / 1200;
                                LInterest := LInterest + ((LInterest + LoanAmount) * InterestRate / 1200) * (DaysToAmortize - 30) / 30;
                            END;
                            IF RepaymentHolidays > 0 THEN
                                InstallmentOneRepayment := LPrincipal + LInterest;
                            MESSAGE('No of Days %1 ', DaysToAmortize);
                            ObjCalculator."First Repayment" := ROUND(LPrincipal + LInterest, 1, '>');
                            ObjCalculator.MODIFY;
                        END;
                    END;

                    IF RepaymentHolidays > 0 THEN
                        HRepayment := (ActualTotalRepayment - InstallmentOneRepayment) / (RepayPeriod - 1);//,0.01,'=');

                    IF ObjCalculator."Repayment Method" = ObjCalculator."Repayment Method"::"Straight Line" THEN BEGIN
                        ObjCalculator.TESTFIELD(ObjCalculator."Interest Rate");
                        ObjCalculator.TESTFIELD(ObjCalculator."Loan Tenure");
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    END;

                    IF ObjCalculator."Repayment Method" = ObjCalculator."Repayment Method"::"Reducing Balance" THEN BEGIN
                        ObjCalculator.TESTFIELD(ObjCalculator."Interest Rate");
                        ObjCalculator.TESTFIELD(ObjCalculator."Loan Tenure");
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    END;


                    //Grace Period
                    IF GrPrinciple > 0 THEN BEGIN
                        LPrincipal := 0
                    END ELSE BEGIN

                        //Delete for other clients
                        IF (ObjCalculator."Document No" = '00100300004') AND (InstalNo < 3) THEN
                            LPrincipal := 0;
                        //Delete for other clients


                        LBalance := LBalance - LPrincipal;

                    END;

                    IF GrInterest > 0 THEN
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    EVALUATE(RepayCode, FORMAT(InstalNo));


                    // //ED Partners RunDate Update
                    // NewRunDate := FnGetNextRunDate(ObjCalculator."Document No",RunDate);

                    IF (NewRunDate <> RunDate) AND (NewRunDate <> 0D) THEN
                        RunDate := NewRunDate;
                    //ED Partners RunDate Update



                    RSchedule.INIT;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := ObjCalculator."Document No";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Client No." := ObjCalculator."Document No";//Member Number
                    RSchedule."Loan Category" := ObjCalculator."Loan Type";
                    //Capture Repayment Holidays concept
                    IF ((LInterest + LPrincipal) < HRepayment) AND (InstalNo > 1) THEN BEGIN
                        RSchedule."Monthly Repayment" := HRepayment;
                        RSchedule."Monthly Interest" := HRepayment - LPrincipal
                    END ELSE BEGIN
                        RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                        RSchedule."Monthly Interest" := LInterest;
                    END;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule."Repayment Day" := DATE2DMY(GetLastDayOfMonth(RunDate), 1);
                    RSchedule."Repayment Month" := DATE2DMY(GetLastDayOfMonth(RunDate), 2);
                    RSchedule."Repayment Year" := DATE2DMY(GetLastDayOfMonth(RunDate), 3);
                    RSchedule."Loan Balance" := LBalance;
                    RSchedule.INSERT;
                    WhichDay := DATE2DWY(RSchedule."Repayment Date", 1);
                UNTIL LBalance < 1

            END;
        END;

        COMMIT;

        RSchedule.RESET;
        RSchedule.SETRANGE(RSchedule."Loan No.", LoanNumber);
        RSchedule.SETRANGE(RSchedule."Instalment No", 3);
        IF RSchedule.FIND('-') THEN BEGIN
            ObjCalculator.RESET;
            ObjCalculator.GET(LoanNumber);
            ObjCalculator."Monthly Repayment" := ROUND(RSchedule."Monthly Repayment", 1, '>');//LInterest + LPrincipal;
            ObjCalculator.MODIFY;
        END;
    end;

    procedure GetLastDayOfMonth(CurDate: Date): Date
    var
        EndMonth: Date;
    begin
        EndMonth := CalcDate('CM', CurDate);
        exit(EndMonth);
    end;

    procedure FnGenerateNoHolidaysSchedule(LoanNumber: Code[50]) Repayment: Decimal
    begin
        HRepayment := 0;
        ActualTotalRepayment := 0;
        InstallmentOneRepayment := 0;

        ObjCalculator.RESET;
        ObjCalculator.SETRANGE(ObjCalculator."Document No", LoanNumber);
        ObjCalculator.SETFILTER(ObjCalculator."Requested Amount", '>%1', 0);
        IF ObjCalculator.FIND('-') THEN BEGIN
            IF (ObjCalculator."Repayment Debut Date" <> 0D) THEN BEGIN //(ObjCalculator."Repayment Debut Date"<>0D) AND (ObjCalculator."Repayment Debut Date"<>0D)
                ObjCalculator.TESTFIELD(ObjCalculator."Disbursement Date");
                ObjCalculator.TESTFIELD(ObjCalculator."Repayment Debut Date");


                RSchedule.RESET;
                RSchedule.SETRANGE(RSchedule."Loan No.", ObjCalculator."Document No");
                RSchedule.DELETEALL;

                LoanAmount := ObjCalculator."Requested Amount";
                InterestRate := ObjCalculator."Interest Rate";
                RepayPeriod := ObjCalculator."Loan Tenure";
                InitialInstal := ObjCalculator."Loan Tenure";
                LBalance := ObjCalculator."Requested Amount";
                RunDate := ObjCalculator."Repayment Debut Date";
                InstalNo := 0;

                //Repayment Frequency
                IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Daily THEN
                    RunDate := CALCDATE('-1D', RunDate)
                ELSE
                    IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Weekly THEN
                        RunDate := CALCDATE('-1W', RunDate)
                    ELSE
                        IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Monthly THEN
                            RunDate := CALCDATE('-1M', RunDate)
                        ELSE
                            IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Quarterly THEN
                                RunDate := CALCDATE('-1Q', RunDate);
                //Repayment Frequency


                REPEAT
                    InstalNo := InstalNo + 1;

                    IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Daily THEN
                        RunDate := CALCDATE('1D', RunDate)
                    ELSE
                        IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Weekly THEN
                            RunDate := CALCDATE('1W', RunDate)
                        ELSE
                            IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Monthly THEN
                                RunDate := CALCDATE('1M', RunDate)
                            ELSE
                                IF ObjCalculator."Repayment Frequency" = ObjCalculator."Repayment Frequency"::Quarterly THEN
                                    RunDate := CALCDATE('1Q', RunDate);

                    IF ObjCalculator."Repayment Method" = ObjCalculator."Repayment Method"::Amortized THEN BEGIN
                        ObjCalculator.TESTFIELD(ObjCalculator."Interest Rate");
                        ObjCalculator.TESTFIELD(ObjCalculator."Loan Tenure");
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - POWER((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;


                        IF InstalNo = 1 THEN BEGIN
                            DaysToAmortize := 0;
                            DaysToAmortize := ObjCalculator."Repayment Debut Date" - ObjCalculator."Disbursement Date";
                            IF DaysToAmortize <= 30 THEN BEGIN
                                LInterest := LoanAmount * (DaysToAmortize) / 30 * InterestRate / 1200;
                            END
                            ELSE BEGIN
                                LInterest := LoanAmount * InterestRate / 1200;
                                LInterest := LInterest + ((LInterest + LoanAmount) * InterestRate / 1200) * (DaysToAmortize - 30) / 30;
                            END;
                            IF RepaymentHolidays > 0 THEN
                                InstallmentOneRepayment := LPrincipal + LInterest;
                        END;
                    END;

                    IF ObjCalculator."Repayment Method" = ObjCalculator."Repayment Method"::"Straight Line" THEN BEGIN
                        ObjCalculator.TESTFIELD(ObjCalculator."Interest Rate");
                        ObjCalculator.TESTFIELD(ObjCalculator."Loan Tenure");
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    END;

                    IF ObjCalculator."Repayment Method" = ObjCalculator."Repayment Method"::"Reducing Balance" THEN BEGIN
                        ObjCalculator.TESTFIELD(ObjCalculator."Interest Rate");
                        ObjCalculator.TESTFIELD(ObjCalculator."Loan Tenure");
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    END;
                    // {
                    // IF ObjCalculator."Repayment Method" = ObjCalculator."Repayment Method"::Constants THEN BEGIN
                    //                         ObjCalculator.TESTFIELD(ObjCalculator.Repayment);
                    //                         IF LBalance < ObjCalculator.Repayment THEN
                    //                             LPrincipal := LBalance
                    //                         ELSE
                    //                             LPrincipal := ObjCalculator.Repayment;
                    //                         LInterest := ObjCalculator.Interest;
                    //                     END;
                    // }
                    //Grace Period
                    IF GrPrinciple > 0 THEN BEGIN
                        LPrincipal := 0
                    END ELSE BEGIN

                        //Delete for other clients
                        IF (ObjCalculator."Document No" = '00100300004') AND (InstalNo < 3) THEN
                            LPrincipal := 0;
                        //Delete for other clients


                        LBalance := LBalance - LPrincipal;

                    END;

                    IF GrInterest > 0 THEN
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    EVALUATE(RepayCode, FORMAT(InstalNo));


                    RSchedule.INIT;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := ObjCalculator."Document No";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Client No." := ObjCalculator."Document No";//Member Number
                    RSchedule."Loan Category" := ObjCalculator."Loan Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule."Repayment Day" := DATE2DMY(GetLastDayOfMonth(RunDate), 1);
                    RSchedule."Repayment Month" := DATE2DMY(GetLastDayOfMonth(RunDate), 2);
                    RSchedule."Repayment Year" := DATE2DMY(GetLastDayOfMonth(RunDate), 3);
                    RSchedule."Loan Balance" := LBalance;
                    RSchedule.INSERT;
                    WhichDay := DATE2DWY(RSchedule."Repayment Date", 1);
                UNTIL LBalance < 1

            END;
        END;

        COMMIT;

        RSchedule.RESET;
        RSchedule.SETRANGE(RSchedule."Loan No.", LoanNumber);
        //RSchedule.SETFILTER(RSchedule."Instalment No",'>%1',1);
        IF RSchedule.FIND('-') THEN BEGIN
            RSchedule.CALCSUMS(RSchedule."Monthly Repayment");
            Repayment := RSchedule."Monthly Repayment";
            //Repayment := ROUND((RSchedule."Monthly Repayment")/(RepayPeriod-(RepaymentHolidays+1)),0.01,'='); //the plus one excludes the first month which is based on the repayment debut date
            //MESSAGE('Repayment %1, for total %2 repaymentholidays %3 for Holidays %4',Repayment,RSchedule."Monthly Repayment",(RepayPeriod-(RepaymentHolidays+1)),RepaymentHolidays);
            EXIT(Repayment);
        END;
    end;

    var
        myInt: Integer;
        VarAmountFromInstalments: Boolean;
        VarInstallmentFromAmouint: Boolean;
        VarEligibilityCalculator: Boolean;
        ActionDetailedDisbursement: Boolean;
        VarLoanPrinciple: Decimal;
        VarLoanInterest: Decimal;
        VarMonthlyNetFeeIncome: Decimal;
        VarMaximumMonthlyProfitability: Decimal;
        VarMaximumEligibleAmount: Decimal;
        RSchedule: Record "Loan Repayment Shedule";
        HRepayment: Decimal;
        ActualTotalRepayment: Decimal;
        InstallmentOneRepayment: Decimal;
        ObjCalculator: Record "Loan Calculator";
        // RSchedule: Record "Loan Repayment Shedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepaymentHolidays: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        DaysToAmortize: Integer;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        NewRunDate: Date;
        WhichDay: Integer;
}