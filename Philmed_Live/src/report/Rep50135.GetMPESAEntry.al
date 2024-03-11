report 50135 GetMPESAEntry
{
    ApplicationArea = All;
    Caption = 'GetMPESAEntry';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(MPESATransactions; "MPESA Transaction")
        {
            DataItemTableView = sorting(ID) where(ID = filter(249800));

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
    trigger OnPreReport()
    var
        SQLConnection: Codeunit "MPESA SQLConnection";
    begin
        SQLConnection.Run();
        GetMPESAEntries;
    end;

    local Procedure GetMPESAEntries()
    var
        lvMPESASQL: Record "MPESA Transactions SQL";
        lvMPESATransaction: Record "MPESA Transaction";
        lvMPESATransaction2: Record "MPESA Transaction";
    begin
        lvMPESASQL.RESET;
        //lvMPESASQL.SETFILTER(Posted, '<>%1', 1);
        lvMPESASQL.SetFilter(ID, '>=%1', 172077);
        IF lvMPESASQL.FINDFIRST THEN
            REPEAT
                lvMPESATransaction2.SETRANGE(TransID, lvMPESASQL.TransID);
                IF NOT lvMPESATransaction2.FINDFIRST THEN BEGIN
                    lvMPESATransaction.INIT;
                    lvMPESATransaction.TRANSFERFIELDS(lvMPESASQL);
                    lvMPESATransaction.TransTime := lvMPESASQL.TransTime - (10800000);
                    lvMPESATransaction.Posted := 0;
                    lvMPESATransaction.DocumentNo := '';
                    lvMPESATransaction.INSERT(TRUE);

                    //Update the Entries
                    lvMPESASQL.Posted := 1;
                    lvMPESASQL.MODIFY;
                END;
            UNTIL lvMPESASQL.NEXT = 0;
    end;
}
