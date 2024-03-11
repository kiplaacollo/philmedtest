report 50128 "Item Ledger Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemLedgerCard.rdlc';
    ApplicationArea = All;
    Caption = 'Item Ledger Card';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.");
            RequestFilterFields = "Item No.", "Posting Date";

            column(ItemNo; "Item No.")
            {
            }
            column(Description; Description)
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(EntryType; "Entry Type")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(UnitofMeasureCode; "Unit of Measure Code")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            { }
            column(ReportFilters; ReportFilters)
            { }
            column(ItemName; ItemName)
            { }
            column(RunningBalance; RunningBalance)
            { }
            column(SourceName; SourceName)
            { }

            trigger OnAfterGetRecord()
            var
                lvItem: Record Item;
                lvCustomer: Record Customer;
                lvVendor: Record Vendor;
            begin
                SourceName := '';
                lvItem.Get("Item No.");
                ItemName := lvItem.Description;

                if "Source Type" = "Source Type"::Customer then begin
                    if lvCustomer.get("Source No.") then
                        SourceName := lvCustomer.Name;
                end;

                if "Source Type" = "Source Type"::Vendor then begin
                    if lvVendor.get("Source No.") then
                        SourceName := lvVendor.Name;
                end;
                RunningBalance += Quantity;
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
    begin
        CompanyInfo.Get();
        ReportFilters := ItemLedgerEntry.GetFilters;
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportFilters: Text;
        ItemName: Text[100];
        RunningBalance: Decimal;
        SourceName: Text[100];
}
