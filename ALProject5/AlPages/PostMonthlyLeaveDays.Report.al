report 50450 "Post Monthly Leave Days"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PostMonthlyLeaveDays.rdlc';

    dataset
    {
        dataitem(pr_employees; pr_employees)
        {
            DataItemTableView = WHERE (status = CONST (active));

            trigger OnAfterGetRecord()
            begin
                HRSetup.Get();

                LeaveGjline.Init;
                LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
                LeaveGjline."Journal Batch Name" := 'DEFAULT';//HRSetup."Leave Batch";
                LeaveGjline."Line No." := "LineNo." + 10000;
                LeaveGjline."Leave Period" := Format(Date2DMY(Today, 3));
                ///LeaveGjline."Leave Application No.":="Application Code";
                LeaveGjline."Document No." := 'REINM-' + Format(Today);
                LeaveGjline."Staff No." := pr_employees.st_no;
                LeaveGjline.Validate(LeaveGjline."Staff No.");
                LeaveGjline."Posting Date" := Today;
                LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Positive;
                LeaveGjline."Leave Approval Date" := Today;
                LeaveGjline.Description := 'REINM-' + Format(Today);
                LeaveGjline."Leave Type" := 'ANNUAL';
                //------------------------------------------------------------
                //HRSetup.RESET;
                //HRSetup.FIND('-');
                HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
                HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
                //------------------------------------------------------------
                LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
                LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
                LeaveGjline."No. of Days" := (2);//*-1;
                if LeaveGjline."No. of Days" <> 0 then
                    LeaveGjline.Insert(true);
            end;

            trigger OnPostDataItem()
            begin
                //Post Journal
                HRSetup.Get();
                LeaveGjline.Reset;
                LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
                LeaveGjline.SetRange("Journal Batch Name", 'DEFAULT');
                if LeaveGjline.Find('-') then begin
                    CODEUNIT.Run(CODEUNIT::"HR Leave Jnl.-Post", LeaveGjline);
                end;
            end;

            trigger OnPreDataItem()
            begin
                HRSetup.Get();
                LeaveGjline.Reset;
                LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
                LeaveGjline.SetRange("Journal Batch Name", 'DEFAULT');
                LeaveGjline.DeleteAll;

                "LineNo." := 0;
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
}

