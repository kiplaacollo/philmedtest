report 50439 "HR Leave Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRLeaveApplication.rdlc';

    dataset
    {
        dataitem("Hr Leave Application"; "Hr Leave Application")
        {
            DataItemTableView = WHERE (Status = FILTER (Posted));
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(EmployeeNo_HrLeaveApplication; "Hr Leave Application"."Employee No")
            {
            }
            column(Empname; "Hr Leave Application".Names)
            {
            }
            column(DaysApplied_HRLeaveApplication; "Days Applied")
            {
                IncludeCaption = true;
            }
            column(ApplicationCode_HRLeaveApplication; "Application Code")
            {
                IncludeCaption = true;
            }
            column(RequestLeaveAllowance_HRLeaveApplication; "Request Leave Allowance")
            {
                IncludeCaption = true;
            }
            column(LeaveAllowanceAmount_HRLeaveApplication; "Leave Allowance Amount")
            {
                IncludeCaption = true;
            }
            column(NumberofPreviousAttempts_HRLeaveApplication; "Number of Previous Attempts")
            {
                IncludeCaption = true;
            }
            column(DetailsofExamination_HRLeaveApplication; "Details of Examination")
            {
                IncludeCaption = true;
            }
            column(DateofExam_HRLeavseApplication; "Date of Exam")
            {
                IncludeCaption = true;
            }
            column(Reliever_HRLeaveApplication; Reliever)
            {
                IncludeCaption = true;
            }
            column(RelieverName_HRLeaveApplication; "Reliever Name")
            {
                IncludeCaption = true;
            }
            column(StartDate_HRLeaveApplication; "Start Date")
            {
                IncludeCaption = true;
            }
            column(ReturnDate_HRLeaveApplication; "Return Date")
            {
                IncludeCaption = true;
            }
            column(LeaveType_HRLeaveApplication; "Leave Type")
            {
                IncludeCaption = true;
            }
            column(JobTittle_HRLeaveApplication; "Job Tittle")
            {
                IncludeCaption = true;
            }
            column(ApplicationDate_HRLeaveApplication; "Application Date")
            {
                IncludeCaption = true;
            }
            column(EmailAddress_HRLeaveApplication; "E-mail Address")
            {
                IncludeCaption = true;
            }
            column(CellPhoneNumber_HRLeaveApplication; "Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(Approveddays_HRLeaveApplication; "Approved days")
            {
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
        CI: Record "Company Information";
}

