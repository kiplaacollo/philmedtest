report 50139 "Items Sold Below Minimum Price"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedItemsBelowMinPrice.rdlc';
    ApplicationArea = All;
    Caption = 'Items Sold Below Minimum Price';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SalesInvoiceLine; "Sales Invoice Line")
        {
            DataItemTableView = where("Minimum Unit Price" = filter(<> 0), "Unit of Measure Code" = filter('W'));
            RequestFilterFields = "Posting Date", "No.", "Shortcut Dimension 1 Code";
            column(DocumentNo; "Document No.")
            {
            }
            column(No; "No.")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(MinimumUnitPrice; "Minimum Unit Price")
            {
            }
            column(UnitCost; "Unit Cost")
            {
            }
            column(UnitCostLCY; "Unit Cost (LCY)")
            {
            }
            column(UnitPrice; "Unit Price")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(QtyperUnitofMeasure; "Qty. per Unit of Measure")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Description; Description)
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(Company_Name; CompanyInfo.Name)
            { }
            column(ReportFilters; ReportFilters)
            { }
            trigger OnAfterGetRecord()
            begin
                if SalesInvoiceLine."Unit Price" >= SalesInvoiceLine."Minimum Unit Price" then
                    CurrReport.Skip();
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
        lvUserSetup: Record "User Setup";
    begin
        CompanyInfo.Get();
        ReportFilters := SalesInvoiceLine.GetFilters;
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');


    end;

    var
        CompanyInfo: Record "Company Information";
        ReportFilters: Text;

}
