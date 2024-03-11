report 50116 "Short Expiry Item List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedShortExpiry.rdlc';
    ApplicationArea = All;
    Caption = 'Short Expiry Item List';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = WHERE("Expiry Date" = filter(<> 0D));
            column(ItemNo; "Item No.")
            {
            }
            column(Description; Description)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(BatchNo; "Batch No.")
            {
            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            { }
            column(ItemName; ItemName)
            { }

            trigger OnAfterGetRecord()
            var
                lvItem: Record Item;
            begin
                if "Expiry Date" - Today > 60 then
                    CurrReport.Skip();
                lvItem.Get("Item No.");
                ItemName := lvItem.Description;
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
    trigger OnPreReport()
    var

    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        ItemName: Text[100];
}
