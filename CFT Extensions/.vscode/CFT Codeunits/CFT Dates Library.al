codeunit 50003 "CFT Dates Library"
{
    procedure GetAge(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45]
    begin
        if ((DateOfBirth <> 0D) AND (DateOfJoin <> 0D)) then begin
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
                            Day := dayJ - dayB else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;
                        AgeString := '%1 Years,%2 Months and #3## Days';
                        AgeString := StrSubstNo(AgeString, Year, Month, Day);
                    end;
                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then begin
                            if monthJ >= monthB then
                                Month := monthJ - monthB
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
                        AgeString := '%1 Months %2 Days';
                        AgeString := StrSubstNo(AgeString, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        AgeString := '#1## Years';
                        AgeString := StrSubstNo(AgeString, year);
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
                        AgeString := '%1 Years, %2 Months and #3## Days';
                        AgeString := StrSubstNo(AgeString, Year, Month, Day);
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
                        AgeString := '%1 Years and #2## Months';
                        AgeString := StrSubstNo(AgeString, Year, Month);
                    end;
                else
                    AgeString := '';
            end;
            // end 
            // else Message('For Date Calculation Enter All Applicable Dates');
            exit;

        end;


    end;

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
                Message('Not Valid Date. The Month Must be Between 1 and 12');
        end;

        exit;
    end;

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
                ELSE
                    IF ((EYear > BYear) AND (EMonth = BMonth) AND (EDay = BDay)) THEN
                        Category := 4
                    ELSE
                        IF ((EYear > BYear) AND (EMonth = BMonth) AND (EDay <> BDay)) THEN
                            Category := 5
                        ELSE
                            IF ((EYear > BYear) AND (EMonth <> BMonth) AND (EDay = BDay)) THEN
                                Category := 6
                            ELSE
                                IF ((EYear = BYear) AND (EMonth <> BMonth) AND (EDay <> BDay)) THEN
                                    Category := 7
                                ELSE
                                    IF ((EYear = BYear) AND (EMonth = BMonth) AND (EDay = BDay)) THEN
                                        Category := 3
                                    ELSE
                                        IF ((EYear < BYear)) THEN Category := 0;
        exit;
    end;

    procedure LeapYear(Year: Integer) LY: Boolean
    begin
        CenturyYear := Year MOD 100 = 0;
        DivByFour := Year MOD 4 = 0;
        IF ((not CenturyYear AND DivByFour) OR (Year MOD 400 = 0)) then
            LY := true
        else
            LY := false;
    end;

    procedure CalculateNextDay(Date: Date) NextDate: Date
    begin
        today := Date2DMY(Date, 1);
        Month := Date2DMY(Date, 2);
        Year := Date2DMY(Date, 3);
        daysInMonth := DetermineDaysInMonth(Month, Year);
        // nextDay := today + 1;
        // if (nextDay > daysInMonth) then begin
        // nextDay := 1;
        // Month := Month + 1;
        if (Month > 12) then begin
            Month := 1;
            Year := Year + 1;
        end;

        // end;
        // NextDate := Date2DMY(nextDay, Month, Year);
    end;

    procedure ConvertDate(nDate: Date) strDate: Text[30]
    begin
        // This function converts the date to the format required by ksps
        lDay := Date2DMY(nDate, 1);
        lMonth := Date2DMY(nDate, 2);
        lYear := Date2DMY(nDate, 3);
        if lDay = 1 then begin strDay := '1st' end;
        IF lDay = 2 THEN BEGIN strDay := '2nd' END;
        IF lDay = 3 THEN BEGIN strDay := '3rd' END;
        IF lDay = 4 THEN BEGIN strDay := '4th' END;
        IF lDay = 5 THEN BEGIN strDay := '5th' END;
        IF lDay = 6 THEN BEGIN strDay := '6th' END;
        IF lDay = 7 THEN BEGIN strDay := '7th' END;
        IF lDay = 8 THEN BEGIN strDay := '8th' END;
        IF lDay = 9 THEN BEGIN strDay := '9th' END;
        IF lDay = 10 THEN BEGIN strDay := '10th' END;
        IF lDay = 11 THEN BEGIN strDay := '11th' END;
        IF lDay = 12 THEN BEGIN strDay := '12th' END;
        IF lDay = 13 THEN BEGIN strDay := '13th' END;
        IF lDay = 14 THEN BEGIN strDay := '14th' END;
        IF lDay = 15 THEN BEGIN strDay := '15th' END;
        IF lDay = 16 THEN BEGIN strDay := '16th' END;
        IF lDay = 17 THEN BEGIN strDay := '17th' END;
        IF lDay = 18 THEN BEGIN strDay := '18th' END;
        IF lDay = 19 THEN BEGIN strDay := '19th' END;
        IF lDay = 20 THEN BEGIN strDay := '20th' END;
        IF lDay = 21 THEN BEGIN strDay := '21st' END;
        IF lDay = 22 THEN BEGIN strDay := '22nd' END;
        IF lDay = 23 THEN BEGIN strDay := '23rd' END;
        IF lDay = 24 THEN BEGIN strDay := '24th' END;
        IF lDay = 25 THEN BEGIN strDay := '25th' END;
        IF lDay = 26 THEN BEGIN strDay := '26th' END;
        IF lDay = 27 THEN BEGIN strDay := '27th' END;
        IF lDay = 28 THEN BEGIN strDay := '28th' END;
        IF lDay = 29 THEN BEGIN strDay := '29th' END;
        IF lDay = 30 THEN BEGIN strDay := '30th' END;
        IF lDay = 31 THEN BEGIN strDay := '31st' END;


        IF lMonth = 1 THEN BEGIN StrMonth := ' January ' END;
        IF lMonth = 2 THEN BEGIN StrMonth := ' February ' END;
        IF lMonth = 3 THEN BEGIN StrMonth := ' March ' END;
        IF lMonth = 4 THEN BEGIN StrMonth := ' April ' END;
        IF lMonth = 5 THEN BEGIN StrMonth := ' May ' END;
        IF lMonth = 6 THEN BEGIN StrMonth := ' June ' END;
        IF lMonth = 7 THEN BEGIN StrMonth := ' July ' END;
        IF lMonth = 8 THEN BEGIN StrMonth := ' August ' END;
        IF lMonth = 9 THEN BEGIN StrMonth := ' September ' END;
        IF lMonth = 10 THEN BEGIN StrMonth := ' October ' END;
        IF lMonth = 11 THEN BEGIN StrMonth := ' November ' END;
        IF lMonth = 12 THEN BEGIN StrMonth := ' December ' END;

        StrYear := FORMAT(lYear);
        strDate := strDay + StrMonth + StrYear;



    end;



    var
        myInt: Integer;
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        yearJ: Integer;
        monthJ: Integer;
        DateCat: Integer;
        AgeString: Text[45];
        CenturyYear: Boolean;
        DivByFour: Boolean;
        today: Integer;
        daysInMonth: Integer;
        nextDay: Date;
        lDay: Integer;
        lMonth: Integer;
        lYear: Integer;
        nDate: Date;
        strDay: Text[4];
        StrMonth: Text[20];
        StrYear: Text[6];
        Strdate: Text[30];




}
