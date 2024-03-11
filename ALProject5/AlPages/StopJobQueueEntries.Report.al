report 50002 "Stop Job Queue Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StopJobQueueEntries.rdlc';

    dataset
    {
        dataitem("Job Queue Entry"; "Job Queue Entry")
        {
            column(ObjectIDtoRun; "Job Queue Entry"."Object ID to Run")
            {
            }
            column(EarliestStartDateTime; "Job Queue Entry"."Earliest Start Date/Time")
            {
            }

            trigger OnAfterGetRecord()
            var
                ObjQueue: Record "Job Queue Entry";
            begin
                ObjQueue.Reset;
                ObjQueue.SetRange(ID, "Job Queue Entry".ID);
                if ObjQueue.Find('-') then begin
                    ObjQueue.Scheduled := false;
                    ObjQueue.Modify;
                end;
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
        ObjSalesInvoice: Record "Sales Invoice Header";
        Filename: Text;
        SMTPSetup: Record "SMTP Mail Setup";
}

