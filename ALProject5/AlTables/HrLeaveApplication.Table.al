table 50436 "Hr Leave Application"
{

    fields
    {
        field(1; "Application Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Leave Application Nos.");
                    "No series" := '';
                end;
            end;
        }
        field(3; "Leave Type"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Hr Leave Types".Code;

            trigger OnValidate()
            begin
                HRLeaveTypes.Reset;
                HRLeaveTypes.SetRange(HRLeaveTypes.Code, "Leave Type");
                HRLeaveTypes.SetFilter(HRLeaveTypes.Gender, '<>%1', HRLeaveTypes.Gender::Both);
                if HRLeaveTypes.Find('-') then begin
                    HREmp.Reset;
                    HREmp.SetRange(HREmp.st_no, "Employee No");
                    if HREmp.Find('-') then begin
                        if HRLeaveTypes.Gender = HRLeaveTypes.Gender::Female then begin
                            if HREmp.Male = true then
                                Error('This leave type is restricted to the ' + Format(HRLeaveTypes.Gender) + ' gender');
                        end;

                        if HRLeaveTypes.Gender = HRLeaveTypes.Gender::Male then begin
                            if HREmp.Female = true then
                                Error('This leave type is restricted to the ' + Format(HRLeaveTypes.Gender) + ' gender');
                        end;
                    end;
                end;

                if HREmp.Get("Employee No") then begin
                    // ERROR('%1 "Days Earned"');
                    HREmp.CalcFields(HREmp."Annual Leave Account", HREmp."Compassionate Leave Acc.", HREmp."Maternity Leave Acc.", HREmp."Paternity Leave Acc.");
                    HREmp.CalcFields(HREmp."Study Leave Acc", HREmp."Sick Leave Acc.", HREmp."Pre-adoptive Leave Acc.", HREmp."Compensatory Leave");
                    if "Leave Type" = 'ANNUAL' then
                        "Days Earned" := HREmp."Annual Leave Account"
                    else
                        if "Leave Type" = 'COMPASSIONATE' then
                            "Days Earned" := HREmp."Compassionate Leave Acc."
                        else
                            if "Leave Type" = 'MATERNITY' then
                                "Days Earned" := HREmp."Maternity Leave Acc."
                            else
                                if "Leave Type" = 'PATERNITY' then
                                    "Days Earned" := HREmp."Paternity Leave Acc."
                                else
                                    if "Leave Type" = 'PRE ADOPTIVE' then
                                        "Days Earned" := HREmp."Pre-adoptive Leave Acc."
                                    else
                                        if "Leave Type" = 'SICK' then
                                            "Days Earned" := HREmp."Sick Leave Acc."
                                        else
                                            if "Leave Type" = 'STUDY' then
                                                "Days Earned" := HREmp."Study Leave Acc"
                                            else
                                                if "Leave Type" = 'COMPENSATORY' then
                                                    "Days Earned" := HREmp."Compensatory Leave";
                    Modify;
                    //   to

                end;

                //calc taken days
                noofDays := 0;
                leaveledger.Reset;
                leaveledger.SetRange(leaveledger."Staff No.", "Employee No");
                leaveledger.SetRange(leaveledger."Leave Type", "Leave Type");
                leaveledger.SetRange(leaveledger."Leave Entry Type", leaveledger."Leave Entry Type"::Negative);
                if leaveledger.Find('-') then begin
                    noofDays := noofDays + (leaveledger."No. of days") * -1
                end;
                "Days Taken" := noofDays;
                Modify
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin


                /*
                TESTFIELD("Leave Type");
                //CALCULATE THE END DATE AND RETURN DATE
                BEGIN
                IF ("Days Applied" <> 0) AND ("Start Date" <> 0D) THEN
                "Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
                "End Date" := DeterminethisLeaveEndDate("Return Date");
                MODIFY;
                END;
                 */
                if ("Days Applied" > ("Days Earned")) then begin
                    if ("Leave Type" <> 'COMPULSARY') then   //-"Days Taken")
                        Error('You cannot apply more than your  available days for this leave type,your available days are %1', ("Days Earned" - "Days Taken"));
                end;


                if ("Days Applied" <> 0) and ("Start Date" <> 0D) then begin
                    Validate("Start Date")
                end;
                "Approved days" := "Days Applied";

            end;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                rdate: Date;
            begin
                "End Date" := cft.FnCalcEndDate("Days Applied", "Start Date", "Leave Type");
                rdate := CalcDate('0D', "End Date");
                "Return Date" := cft.FnCalcReturnDate(rdate);
            end;
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Return Date';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(7; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,HOD Approval,HR Approval,Final Approval,Rejected,Canceled,Approved,On leave,Resumed,Posted';
            OptionMembers = New,"Pending Approval","HOD Approval","HR Approval",MDApproval,Rejected,Canceled,Approved,"On leave",Resumed,Posted;

            trigger OnValidate()
            begin
                HumanResourceSetup.Get();


                if Status = Status::"Pending Approval" then begin
                    if HumanResourceSetup."Disable Leave Emails" = false then begin
                        //email to reliever
                        if (employee.Get(Reliever) and (Reliever <> '')) then begin
                            if (employee."Doc No for Leave Notification" <> "Application Code") then begin
                                Emailmessage := 'You have been Listed as a reliever for ' + "Employee Name" + ' between ' + Format("Start Date") + ' and ' + Format("Return Date") + '. You will be notified once the leave is approved ';
                                if employee.employee_email <> '' then
                                    CFTFactory.FnSendHrMail('', Emailmessage, employee.employee_email, 'Leave Application');
                            end;

                            employee."Doc No for Leave Notification" := "Application Code";
                            employee.Modify;
                        end;

                        //email to Supervisor
                        if emp.Get("Supervisor Id") then begin
                            Emailmessage := 'You have ' + "Leave Type" + ' approval request from ' + "Applicants Name" +
                          '<a class="btn btn-info" role="button" href=''https://crm.mawingunetworks.com/selfhelp/leaves/requests/my_staff''>Click here to Approve</a>';
                            if emp.employee_email <> '' then
                                CFTFactory.FnSendHrMail('', Emailmessage, emp.employee_email, 'Leave Approval');
                        end;
                    end;

                end;


                if Status = Status::Approved then begin

                    Emailmessage := "Applicants Name" + ' leave application has been approved by the line manager. Please give the final approval. ';
                    if HumanResourceSetup."Disable Leave Emails" = false then
                        CFTFactory.FnSendHrMail('', Emailmessage, HumanResourceSetup."Hr Email", 'Leave Approval');


                    //Email to the applicant

                    if employee.Get("Employee No") then begin
                        Emailmessage := 'Your leave request has been approved. You are expected to report back on ' + Format("Return Date");
                        if ((HumanResourceSetup."Disable Leave Emails" = false) and (employee.employee_email <> '')) then
                            CFTFactory.FnSendHrMail('', Emailmessage, employee.employee_email, 'Leave Approval');
                    end;




                    //Email to the Reliever
                    if emp.Get(Reliever) then begin
                        Emailmessage := "Employee Name" + ' leave application has been approved and you are the reliever until return_date';
                        if ((HumanResourceSetup."Disable Leave Emails" = false) and (emp.employee_email <> '')) then
                            CFTFactory.FnSendHrMail('', Emailmessage, emp.employee_email, 'Leave Approval');
                    end;

                end;

                if Status = Status::Rejected then begin

                    if employee.Get("Employee No") then begin
                        Emailmessage := 'Your leave request has been rejected by the Hr ';
                        if ((HumanResourceSetup."Disable Leave Emails" = false) and (employee.employee_email <> '')) then
                            CFTFactory.FnSendHrMail('', Emailmessage, employee.employee_email, 'Leave Rejected');
                    end;
                end;

                // IF Status=Status::Posted THEN BEGIN
                // END;
            end;
        }
        field(15; "Applicant Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "No series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Gender; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'MALE,FEMALE';
            OptionMembers = MALE,FEMALE;
        }
        field(28; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Current Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;

            trigger OnValidate()
            begin
                /*IF SalCard.GET("No.") THEN BEGIN
                SalCard.Department:="Department Code";
                SalCard.MODIFY;
                END;
                */

            end;
        }
        field(3900; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3901; "Total Taken"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(3921; "E-mail Address"; Text[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            ExtendedDatatype = EMail;
        }
        field(3924; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3929; "Start Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3936; "Cell Phone Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(3937; "Request Leave Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // HREmp.RESET;
                // HREmp.SETRANGE(HREmp."No.","Employee No");
                // IF HREmp.FIND('-') THEN BEGIN
                //  IF HREmp."Leave Allowance Claimed"=TRUE THEN
                //    ERROR('Leave Allowance has been claimed');
                //  Allowance:=HREmp."Leave Allowance Amount";
                //  IF "Request Leave Allowance"=TRUE THEN BEGIN
                //  "Leave Allowance Amount":=Allowance;
                //
                // END
                // ELSE BEGIN
                //  "Leave Allowance Amount":=0;
                //
                //
                // END;
                //  //HREmp."Leave Allowance Claimed":=TRUE;
                //  //HREmp.MODIFY;
                //
                // END;
            end;
        }
        field(3939; Picture; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(3940; Names; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3942; "Leave Allowance Entittlement"; Decimal)
        {
        }
        field(3943; "Leave Allowance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3945; "Details of Examination"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3947; "Date of Exam"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3949; Reliever; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.st_no;

            trigger OnValidate()
            begin
                //                    //DISPLAY RELEIVERS NAME
                //                    IF Reliever = "Employee No" THEN
                //                    ERROR('Employee cannot relieve him/herself');
                //
                if HREmp.Get(Reliever) then
                    "Reliever Name" := HREmp.Name;
            end;
        }
        field(3950; "Reliever Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3952; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3955; "Supervisor Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3956; "Number of Previous Attempts"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3958; "Job Tittle"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3959; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3961; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.st_no WHERE (status = FILTER (active));

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp.st_no, "Employee No");
                if HREmp.Find('-') then begin
                    "Employee Name" := HREmp.Name;
                    Gender := HREmp.Gender;
                    "E-mail Address" := HREmp.employee_email;
                    "Supervisor Id" := HREmp.SuperVisor;
                    "Applicants Name" := HREmp.Name;

                    if emp.Get("Supervisor Id") then
                        "Supervisor Name" := emp.Name;
                    "Days Earned" := 0;

                    Modify;
                end
            end;
        }
        field(3962; Supervisor; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(3969; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(3970; "Approved days"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF "Approved days">"Days Applied" THEN
                // ERROR(TEXT001);
            end;
        }
        field(3972; Emergency; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'This is used to ensure one can apply annual leave which is emergency';
        }
        field(3973; "Approver Comments"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3974; "Available Days"; Decimal)
        {
            CalcFormula = Sum ("HR Leave Ledger Entries"."No. of days" WHERE ("Staff No." = FIELD ("Employee No")));
            FieldClass = FlowField;
        }
        field(3975; Reliever2; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.st_no;

            trigger OnValidate()
            begin
                //                    //DISPLAY RELEIVERS NAME
                //                    IF Reliever2 = "Employee No" THEN
                //                    ERROR('Employee cannot relieve him/herself');
                //
                if HREmp.Get(Reliever2) then
                    "Reliever Name2" := HREmp.Name;
            end;
        }
        field(3976; "Reliever Name2"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3977; "Date Of Exam 1"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //  IF "Date Of Exam 1"<"Application Date"THEN
                // ERROR('You cannot Start your leave before the application date');
                //
                //
                // IF "Date Of Exam 1"="Date Of Exam 7"THEN
                // ERROR('Date already assigned');
                // IF "Date Of Exam 1"="Date Of Exam 3"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 1"="Date Of Exam 4"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 1"="Date Of Exam 5"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 1"="Date Of Exam 6"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 1"="Date Of Exam 2"THEN
                // ERROR('Date already assigned');
            end;
        }
        field(3978; "Date Of Exam 2"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //  IF "Date Of Exam 2"<"Application Date"THEN
                // ERROR('You cannot Start your leave before the application date');
                //
                // IF "Date Of Exam 2"="Date Of Exam 1"THEN
                // ERROR('Date already assigned');
                // IF "Date Of Exam 2"="Date Of Exam 3"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 2"="Date Of Exam 4"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 2"="Date Of Exam 5"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 2"="Date Of Exam 6"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 2"="Date Of Exam 7"THEN
                // ERROR('Date already assigned');
            end;
        }
        field(3979; "Date Of Exam 3"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //  IF "Date Of Exam 3"<"Application Date"THEN
                // ERROR('You cannot Start your leave before the application date');
                //
                //  IF "Date Of Exam 3"="Date Of Exam 1"THEN
                // ERROR('Date already assigned');
                // IF "Date Of Exam 3"="Date Of Exam 2"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 3"="Date Of Exam 4"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 3"="Date Of Exam 5"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 3"="Date Of Exam 6"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 3"="Date Of Exam 7"THEN
                // ERROR('Date already assigned');
            end;
        }
        field(3980; "Date Of Exam 4"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //  IF "Date Of Exam 4"<"Application Date"THEN
                // ERROR('You cannot Start your leave before the application date');
                //
                // IF "Date Of Exam 4"="Date Of Exam 1"THEN
                // ERROR('Date already assigned');
                // IF "Date Of Exam 4"="Date Of Exam 3"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 4"="Date Of Exam 2"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 4"="Date Of Exam 5"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 4"="Date Of Exam 6"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 4"="Date Of Exam 7"THEN
                // ERROR('Date already assigned');
            end;
        }
        field(3981; "Date Of Exam 5"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //  IF "Date Of Exam 5"<"Application Date"THEN
                // ERROR('You cannot Start your leave before the application date');
                //
                // IF "Date Of Exam 5"="Date Of Exam 1"THEN
                // ERROR('Date already assigned');
                // IF "Date Of Exam 5"="Date Of Exam 3"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 5"="Date Of Exam 4"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 5"="Date Of Exam 2"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 5"="Date Of Exam 6"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 5"="Date Of Exam 7"THEN
                // ERROR('Date already assigned');
            end;
        }
        field(3982; "Date Of Exam 6"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //  IF "Date Of Exam 6"<"Application Date"THEN
                // ERROR('You cannot Start your leave before the application date');
                //
                // IF "Date Of Exam 6"="Date Of Exam 1"THEN
                // ERROR('Date already assigned');
                // IF "Date Of Exam 6"="Date Of Exam 3"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 6"="Date Of Exam 4"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 6"="Date Of Exam 5"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 6"="Date Of Exam 2"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 6"="Date Of Exam 7"THEN
                // ERROR('Date already assigned');
            end;
        }
        field(3983; "Date Of Exam 7"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF "Date Of Exam 7"<"Application Date"THEN
                // ERROR('You cannot Start your leave before the application date');
                //
                // IF "Date Of Exam 7"="Date Of Exam 1"THEN
                // ERROR('Date already assigned');
                // IF "Date Of Exam 7"="Date Of Exam 3"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 7"="Date Of Exam 4"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 7"="Date Of Exam 5"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 7"="Date Of Exam 6"THEN
                // ERROR('Date already assigned');
                //
                // IF "Date Of Exam 7"="Date Of Exam 2"THEN
                // ERROR('Date already assigned');
            end;
        }
        field(3984; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // HREmp.RESET;
                //                            IF HREmp.GET("Employee No") THEN
                //                            BEGIN
                //                            EmpName:=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
                //                            EmpDept:=HREmp."Global Dimension 2 Code";
                //                            "Job Tittle":=HREmp."Job Title";
                //                            END ELSE BEGIN
                //                            EmpDept:='';
                //                             // HREmp.MODIFY;
                //                            END;
            end;
        }
        field(3985; "Address No."; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3986; "Outstanding Leave Balance"; Decimal)
        {
        }
        field(3987; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3988; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3989; "Days Earned"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3990; "Days Taken"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3991; "Supervisor Id"; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.st_no;
        }
        field(3992; "Supervisor Name"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3993; "Applicants Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3994; "Leave Request ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //No. Series
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No series", 0D, "Application Code", "No series");
        end;

        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            HREmp.TestField(HREmp.joining_date);

            //    Calendar.RESET;
            //    Calendar.SETRANGE("Period Type",Calendar."Period Type"::Month);
            //    Calendar.SETRANGE("Period Start",HREmp."Date Of Join",TODAY);
            //    empMonths := Calendar.COUNT;

            //Minimum duration in months for Leave Applications
            //    IF HRSetup.GET THEN
            //    BEGIN
            //        HRSetup.TESTFIELD(HRSetup."Min. Leave App. Months");
            //        IF empMonths < HRSetup."Min. Leave App. Months" THEN ERROR(Text002,HRSetup."Min. Leave App. Months");
            //    END;

            //Populate fields
            "Employee No" := HREmp.st_no;
            Gender := HREmp.Gender;
            "Application Date" := Today;
            "User ID" := UserId;
            "Job Tittle" := HREmp.job_title;
            //  HREmp.CALCFIELDS(HREmp.Picture);
            //  Picture:=HREmp.Picture;
            //Approver details
            //GetApplicantSupervisor(USERID);
            // END ELSE
            // BEGIN
            //    ERROR('UserID'+' '+'['+USERID+']'+' has not been assigned to any employee. Please consult the HR officer for assistance')
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRLeaveTypes: Record "Hr Leave Types";
        HREmp: Record pr_employees;
        dates: Record Date;
        BaseCalendar: Record "Base Calendar Change";
        LeaveGjline: Record "HR Journal Line";
        "LineNo.": Integer;
        leaveledger: Record "HR Leave Ledger Entries";
        noofDays: Integer;
        GeneralOptions: Record "Sacco No Series Setup";
        emp: Record pr_employees;
        cft: Codeunit "CFT Factory";
        HumanResourceSetup: Record "Human Resources Setup";
        employee: Record pr_employees;
        Emailmessage: Text;
        CFTFactory: Codeunit "CFT Factory";
        ccount: Integer;

    [Scope('Internal')]
    procedure CalcEndDate(SDate: Date; LDays: Integer) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        ltype: Record "Hr Leave Types";
    begin
        ltype.Reset;
        if ltype.Get("Leave Type") then begin
        end;
        SDate := SDate - 1;
        EndLeave := false;
        while EndLeave = false do begin
            if not DetermineIfIsNonWorking(SDate, ltype) then
                DayCount := DayCount + 1;
            SDate := SDate + 1;
            if DayCount > LDays then
                EndLeave := true;
        end;
        LEndDate := SDate - 1;

        while DetermineIfIsNonWorking(LEndDate, ltype) = true do begin
            LEndDate := LEndDate + 1;
        end;
    end;

    [Scope('Internal')]
    procedure CalcReturnDate(EndDate: Date) RDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        LEndDate: Date;
        ltype: Record "Hr Leave Types";
    begin
        if ltype.Get("Leave Type") then begin
        end;
        /*
         EndLeave:=FALSE;
         EndDate:=EndDate+1;
         LEndDate:=EndDate;
         CLEAR(DayCount);
         WHILE EndLeave=FALSE DO BEGIN
         IF NOT DetermineIfIsNonWorking(EndDate,ltype) THEN BEGIN
         DayCount:=DayCount+1;
         EndDate:=EndDate+1;

         END ELSE BEGIN
         EndLeave:=TRUE;
         END;
         END;
           */
        RDate := EndDate + 1;
        while DetermineIfIsNonWorking(RDate, ltype) = true do begin
            RDate := RDate + 1;
        end;

    end;

    [Scope('Internal')]
    procedure DetermineIfIsNonWorking(var bcDate: Date; var ltype: Record "Hr Leave Types") ItsNonWorking: Boolean
    var
        dates: Record Date;
    begin
        /*CLEAR(ItsNonWorking);
        GeneralOptions.FIND('-');
        //One off Hollidays like Good Friday
        BaseCalendar.RESET;
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code",GeneralOptions."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar.Date,bcDate);
        IF BaseCalendar.FIND('-') THEN BEGIN
        IF BaseCalendar.Nonworking = TRUE THEN
        ItsNonWorking:=TRUE;
        END;
        
        // For Annual Holidays
        BaseCalendar.RESET;
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code",GeneralOptions."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar."Recurring System",BaseCalendar."Recurring System"::"Annual Recurring");
        IF BaseCalendar.FIND('-') THEN BEGIN
        REPEAT
        IF ((DATE2DMY(bcDate,1)=BaseCalendar."Date Day") AND (DATE2DMY(bcDate,2)=BaseCalendar."Date Month")) THEN BEGIN
        IF BaseCalendar.Nonworking = TRUE THEN
        ItsNonWorking:=TRUE;
        END;
        UNTIL BaseCalendar.NEXT=0;
        END;
        
        IF ItsNonWorking=FALSE THEN BEGIN
        // Check if its a weekend
        dates.RESET;
        dates.SETRANGE(dates."Period Type",dates."Period Type"::Date);
        dates.SETRANGE(dates."Period Start",bcDate);
        IF dates.FIND('-') THEN BEGIN
        //if date is a sunday
        IF dates."Period Name"='Sunday' THEN BEGIN
        //check if Leave includes sunday
        IF ltype."Inclusive of Sunday"=FALSE THEN ItsNonWorking:=TRUE;
        END ELSE IF dates."Period Name"='Saturday' THEN BEGIN
        //check if Leave includes sato
         IF ltype."Inclusive of Saturday"=FALSE THEN ItsNonWorking:=TRUE;
        END;
        END;
        END;
        */

    end;

    [Scope('Internal')]
    procedure CreateLeaveLedgerEntries()
    begin
        if Status = Status::Posted then Error('Leave Already posted');
        TestField("Approved days");
        HRSetup.Reset;
        if HRSetup.Find('-') then begin

            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            LeaveGjline.DeleteAll;
            //Dave
            HRSetup.TestField(HRSetup."Leave Template");
            HRSetup.TestField(HRSetup."Leave Batch");

            HREmp.Get("Employee No");
            HREmp.TestField(HREmp.employee_email);

            //POPULATE JOURNAL LINES

            "LineNo." := 10000;
            LeaveGjline.Init;
            LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
            LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
            LeaveGjline."Line No." := "LineNo.";
            LeaveGjline."Leave Period" := Format(Date2DMY(Today, 3));
            LeaveGjline."Leave Application No." := "Application Code";
            LeaveGjline."Document No." := "Application Code";
            LeaveGjline."Staff No." := "Employee No";
            LeaveGjline.Validate(LeaveGjline."Staff No.");
            LeaveGjline."Posting Date" := Today;
            LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Negative;
            LeaveGjline."Leave Approval Date" := Today;
            LeaveGjline.Description := 'Leave Taken';
            LeaveGjline."Leave Type" := "Leave Type";
            //------------------------------------------------------------
            //HRSetup.RESET;
            //HRSetup.FIND('-');
            HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
            LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
            LeaveGjline."No. of Days" := ("Approved days");//*-1;
            if LeaveGjline."No. of Days" <> 0 then
                LeaveGjline.Insert(true);

            //Post Journal
            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            if LeaveGjline.Find('-') then begin
                CODEUNIT.Run(CODEUNIT::"HR Leave Jnl.-Post", LeaveGjline);
            end;
            Status := Status::Posted;
            Modify;

            /*END ELSE BEGIN
            ERROR('You must specify no of days');
            END;
            END;*/
            //NotifyApplicant;
        end;

    end;
}

