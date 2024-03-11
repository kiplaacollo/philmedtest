report 50469 "Hr Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrSummaryReport.rdlc';

    dataset
    {
        dataitem(pr_employees; pr_employees)
        {
            CalcFields = "Annual Leave Account";
            DataItemTableView = WHERE (status = FILTER (active));
            RequestFilterFields = contract_end_date;
            column(stno_premployees; pr_employees.st_no)
            {
            }
            column(Name_premployees; pr_employees.Name)
            {
            }
            column(Gender_premployees; pr_employees.Gender)
            {
            }
            column(DateofBirth_premployees; pr_employees."Date of Birth")
            {
            }
            column(Age; Age)
            {
            }
            column(joiningdate_premployees; pr_employees.joining_date)
            {
            }
            column(departmentcode_premployees; pr_employees.department_code)
            {
            }
            column(jobtitle_premployees; pr_employees.job_title)
            {
            }
            column(Natureofcontract_premployees; pr_employees."Nature of contract")
            {
            }
            column(contractstartdate_premployees; pr_employees.contract_start_date)
            {
            }
            column(contractenddate_premployees; pr_employees.contract_end_date)
            {
            }
            column(ProbationEndDate_premployees; pr_employees."Probation End Date")
            {
            }
            column(Reasonforseparation_premployees; pr_employees."Reason for separation")
            {
            }
            column(lastworkingdate_premployees; pr_employees."last working date")
            {
            }
            column(AnnualLeaveAccount_premployees; pr_employees."Annual Leave Account")
            {
            }
            column(Picture_CompanyInformation; companyinfo.Picture)
            {
            }
            column(Bpaysubtotals; Bpaysubtotals)
            {
            }
            column(Retainersubtotals; Retainersubtotals)
            {
            }
            column(InternsAllowance; InternsAllowance)
            {
            }
            column(Region_premployees; pr_employees.Region)
            {
            }
            column(JobGroup_premployees; pr_employees."Job Group")
            {
            }
            column(Complete_Years_Of_Service; Sdate)
            {
            }
            column(OfficeFieldbased_premployees; pr_employees."Office/Field based")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Date of Birth" <> 0D then begin
                    yearBirth := 0;
                    //Age:=cftfactory.DetermineAge("Date of Birth",TODAY);
                    yearBirth := Date2DMY("Date of Birth", 3);
                    Age := Date2DMY(Today, 3) - yearBirth;
                end;
                Hallowance := 0;
                Bpaysubtotals := 0;
                Retainersubtotals := 0;
                InternsAllowance := 0;
                Transactions.Reset;
                Transactions.SetRange(Transactions.staff_no, pr_employees.st_no);
                Transactions.SetRange(Transactions.transaction_code, 'HALLOWANCE');
                if Transactions.FindLast then
                    Hallowance := Transactions.amount;

                if pr_employees.basic_pay > 0 then
                    Bpaysubtotals := pr_employees.basic_pay + Hallowance;

                if pr_employees.Retainer > 0 then
                    Retainersubtotals := pr_employees.Retainer + Hallowance;



                Emptransactions.Reset;
                Emptransactions.SetRange(Emptransactions.staff_no, pr_employees.st_no);
                Emptransactions.SetRange(Emptransactions.transaction_code, 'A005');
                if Emptransactions.FindLast then
                    InternsAllowance := Emptransactions.amount;

                if pr_employees.basic_pay <> 0 then
                    InternsAllowance := 0;

                //****************************
                Sdate := '';
                if pr_employees.joining_date <> 0D then begin
                    Sdate := DetermineAge(pr_employees.joining_date, Today);
                end;

                //***************************
            end;

            trigger OnPreDataItem()
            begin
                companyinfo.CalcFields(companyinfo.Picture);
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
        Age: Integer;
        cftfactory: Codeunit "CFT Factory";
        companyinfo: Record "Company Information";
        Transactions: Record pr_transactions;
        Hallowance: Decimal;
        Bpaysubtotals: Decimal;
        Retainersubtotals: Decimal;
        InternsAllowance: Decimal;
        Emptransactions: Record pr_transactions;
        yearBirth: Integer;
        Sdate: Text;
        TEXTDATE1: Label 'The Start date cannot be Greater then the end Date.';

    [Scope('Internal')]
    procedure DetermineAge(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45]
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin
        if ((DateOfBirth <> 0D) and (DateOfJoin <> 0D)) then begin
            dayB := Date2DMY(DateOfBirth, 1);
            monthB := Date2DMY(DateOfBirth, 2);
            yearB := Date2DMY(DateOfBirth, 3);
            dayJ := Date2DMY(DateOfJoin, 1);
            monthJ := Date2DMY(DateOfJoin, 2);
            yearJ := Date2DMY(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            case (DateCat) of
                1:
                    begin
                        Year := yearJ - yearB;
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        end;

                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;

                        AgeString := '%1  ';
                        AgeString := StrSubstNo(AgeString, Year);

                    end;

                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then begin
                            if monthJ >= monthB then
                                Month := monthJ - monthB
                            //  ELSE ERROR('The wrong date category!');
                        end;

                        if (dayJ <> dayB) then begin
                            if (dayJ >= dayB) then
                                Day := dayJ - dayB
                            else
                                if (dayJ < dayB) then begin
                                    Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                    Month := Month - 1;
                                end;
                        end;

                        AgeString := '%1  ';
                        AgeString := StrSubstNo(AgeString, 0);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        AgeString := '#1## ';
                        AgeString := StrSubstNo(AgeString, Year);
                    end;
                5:
                    begin
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                monthJ := monthJ - 1;
                                Month := (monthJ + 12) - monthB;
                                yearJ := yearJ - 1;
                            end;

                        Year := yearJ - yearB;
                        AgeString := '%1  ';
                        AgeString := StrSubstNo(AgeString, Year);
                    end;
                6:
                    begin
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        AgeString := '%1  ';
                        AgeString := StrSubstNo(AgeString, Year);
                    end;
                else
                    AgeString := '';
            end;
        end else
            Message('For Date Calculation Enter All Applicable Dates!');
        exit;
    end;

    [Scope('Internal')]
    procedure DateCategory(BDay: Integer; EDay: Integer; BMonth: Integer; EMonth: Integer; BYear: Integer; EYear: Integer) Category: Integer
    begin
        if ((EYear > BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
            Category := 1
        else
            if ((EYear = BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
                Category := 2
            else
                if ((EYear = BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
                    Category := 3
                else
                    if ((EYear > BYear) and (EMonth = BMonth) and (EDay = BDay)) then
                        Category := 4
                    else
                        if ((EYear > BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
                            Category := 5
                        else
                            if ((EYear > BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
                                Category := 6
                            else
                                if ((EYear = BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
                                    Category := 7
                                else
                                    if ((EYear = BYear) and (EMonth = BMonth) and (EDay = BDay)) then
                                        Category := 3
                                    else
                                        if ((EYear < BYear)) then
                                            Error(TEXTDATE1)
                                        else begin
                                            Category := 0;
                                            //ERROR('The start date cannot be after the end date.');
                                        end;
        exit;
    end;

    [Scope('Internal')]
    procedure DetermineDaysInMonth(Month: Integer; Year: Integer) DaysInMonth: Integer
    begin
        case (Month) of
            1:
                DaysInMonth := 31;
            2:
                begin
                    if (LeapYear(Year)) then
                        DaysInMonth := 29
                    else
                        DaysInMonth := 28;
                end;
            3:
                DaysInMonth := 31;
            4:
                DaysInMonth := 30;
            5:
                DaysInMonth := 31;
            6:
                DaysInMonth := 30;
            7:
                DaysInMonth := 31;
            8:
                DaysInMonth := 31;
            9:
                DaysInMonth := 30;
            10:
                DaysInMonth := 31;
            11:
                DaysInMonth := 30;
            12:
                DaysInMonth := 31;
            else
                Message('Not valid date. The month must be between 1 and 12');
        end;

        exit;
    end;

    [Scope('Internal')]
    procedure LeapYear(Year: Integer) LY: Boolean
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
        CenturyYear := Year mod 100 = 0;
        DivByFour := Year mod 4 = 0;
        if ((not CenturyYear and DivByFour) or (Year mod 400 = 0)) then
            LY := true
        else
            LY := false;
    end;
}

