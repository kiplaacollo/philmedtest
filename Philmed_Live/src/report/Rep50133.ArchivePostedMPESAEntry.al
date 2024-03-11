report 50133 "Archive Posted MPESA Entry"
{
    ApplicationArea = All;
    Caption = 'Archive Posted MPESA Entry';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(MPESATransaction; "MPESA Transaction")
        {
            DataItemTableView = SORTING(ID) where(ID = filter(> 110000));
            trigger OnAfterGetRecord()
            var
                PostedMPESATransaction: Record "Posted MPESA Transaction";
                PostedMPESATransaction2: Record "Posted MPESA Transaction";
                MPESAEntry: Record "MPESA Transaction";
            begin

                MPESAEntry.Get(MPESATransaction.ID);
                MPESAEntry.CalcFields("Posted Document No.");

                if MPESAEntry."Posted Document No." <> '' then begin
                    IF (NOT PostedMPESATransaction2.Get(MPESATransaction.ID)) then begin
                        PostedMPESATransaction.Init();
                        PostedMPESATransaction.TransferFields(MPESAEntry);
                        PostedMPESATransaction.Insert();
                    end;
                    MPESAEntry.Delete();
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
