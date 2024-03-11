report 50134 "Clear Cash Receipt Batch"
{
    ApplicationArea = All;
    Caption = 'Clear Cash Receipt Batch';
    UsageCategory = Administration;
    ProcessingOnly = true;
    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            //DataItemTableView = sorting("Line No.") where("Journal Batch Name" = filter('MPESA-AUTO'), "Journal Template Name" = filter('CASH RECE'));
            DataItemTableView = sorting("Line No.") where("Journal Template Name" = filter('CASH RECE'));

            trigger OnAfterGetRecord()
            var
                JournalLine: Record "Gen. Journal Line";
            begin
                JournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
                JournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
                JournalLine.SetRange("Line No.", GenJournalLine."Line No.");
                if JournalLine.FindFirst() then begin
                    //if Not JournalLine.IsApplied() then
                    JournalLine.Delete(true);

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
