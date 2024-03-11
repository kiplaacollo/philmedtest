page 50445 "Hr Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HR Setup";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Primary Key"; Rec."Primary Key")
                {

                }
                field("Employee Nos."; Rec."Employee Nos.")
                {

                }
                field("Training Application Nos."; Rec."Training Application Nos.")
                {

                }
                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {

                }
                field("Disciplinary Cases Nos.;"; Rec."Disciplinary Cases Nos.;")
                {

                }
                field("Base Calender"; Rec."Base Calender")
                {

                }
                field("Job Nos."; Rec."Job Nos.")
                {

                }
                field("Transport Req Nos"; Rec."Transport Req Nos")
                {

                }
                field("Employee Requisition Nos."; Rec."Employee Requisition Nos.")
                {

                }
                field("Leave Posting Period[FROM]"; Rec."Leave Posting Period[FROM]")
                {

                }
                field("Leave Posting Period[TO]"; Rec."Leave Posting Period[TO]")
                {

                }
                field("Job Application Nos"; Rec."Job Application Nos")
                {

                }
                field("Exit Interview Nos"; Rec."Exit Interview Nos")
                {

                }
                field("Appraisal Nos"; Rec."Appraisal Nos")
                {

                }
                field("Company Activities"; Rec."Company Activities")
                {

                }
                field("Default Leave Posting Template"; Rec."Default Leave Posting Template")
                {

                }
                field("Positive Leave Posting Batch"; Rec."Positive Leave Posting Batch")
                {

                }
                field("Leave Template"; Rec."Leave Template")
                {

                }
                field("Leave Batch"; Rec."Leave Batch")
                {

                }
                field("Job Interview Nos"; Rec."Job Interview Nos")
                {

                }
                field("Company Documents"; Rec."Company Documents")
                {

                }
                field("HR Policies"; Rec."HR Policies")
                {

                }
                field("Notice Board Nos."; Rec."Notice Board Nos.")
                {

                }
                field("Leave Reimbursement Nos."; Rec."Leave Reimbursement Nos.")
                {

                }
                field("Min. Leave App. Months"; Rec."Min. Leave App. Months")
                {

                }
                field("Negative Leave Posting Batch"; Rec."Negative Leave Posting Batch")
                {

                }
                field("Appraisal Method"; Rec."Appraisal Method")
                {

                }
                field("Loan Application Nos."; Rec."Loan Application Nos.")
                {

                }
                field("Leave Carry Over App Nos."; Rec."Leave Carry Over App Nos.")
                {

                }
                field("Pay-change No."; Rec."Pay-change No.")
                {

                }
                field("Max Appraisal Rating"; Rec."Max Appraisal Rating")
                {

                }
                field("Medical Claims Nos."; Rec."Medical Claims Nos.")
                {

                }
                field("Employee Transfer Nos."; Rec."Employee Transfer Nos.")
                {

                }
                field("Leave Planner Nos."; Rec."Leave Planner Nos.")
                {

                }
                field("Deployed Nos"; Rec."Deployed Nos")
                {

                }
                field("Full Time Nos"; Rec."Full Time Nos")
                {

                }
                field("Board Nos"; Rec."Board Nos")
                {

                }
                field("Committee Nos"; Rec."Committee Nos")
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}