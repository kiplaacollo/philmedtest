report 50137 "Reset Job Queue Entry"
{
    ApplicationArea = All;
    Caption = 'Reset Job Queue Entry';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "Job Queue Entry" = rimd;
    dataset
    {
        dataitem(JobQueueEntry; "Job Queue Entry")
        {
            DataItemTableView = where("Object Type to Run" = filter(report), "Object ID to Run" = filter(50100 .. 50200));
            trigger OnAfterGetRecord()
            begin
                if JobQueueEntry.Status = JobQueueEntry.Status::Error then begin
                    JobQueueEntry.SetStatus(JobQueueEntry.Status::Ready);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
