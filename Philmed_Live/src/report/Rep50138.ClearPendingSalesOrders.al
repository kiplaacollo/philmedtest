report 50138 "Clear Pending Sales Orders"
{
    ApplicationArea = All;
    Caption = 'Clear Pending Sales Orders';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "Sales Header" = rimd, tabledata "Sales Line" = rimd;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = filter(Order));
            trigger OnAfterGetRecord()
            var
                lvSalesHeader: Record "Sales Header";
                lvSalesLine: Record "Sales Line";
            begin
                If SalesHeader."Posting Date" < Today then begin
                    lvSalesHeader.Reset();
                    lvSalesLine.Reset();
                    lvSalesLine.SetRange("Document Type", SalesHeader."Document Type");
                    lvSalesLine.SetRange("Document No.", SalesHeader."No.");
                    if lvSalesLine.FindSet() then
                        lvSalesLine.DeleteAll();

                    lvSalesHeader.SetRange("Document Type", SalesHeader."Document Type");
                    lvSalesHeader.SetRange("No.", SalesHeader."No.");
                    if lvSalesHeader.FindSet() then
                        lvSalesHeader.DeleteAll();

                    Commit();
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
