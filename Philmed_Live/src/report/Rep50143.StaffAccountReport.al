report 50143 "Staff Account Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedStaffAccountRpt.rdlc';
    ApplicationArea = All;
    Caption = 'Staff Account Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(ValueEntry; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.") where("Source Type" = const(customer), "Payroll No." = filter(<> ''));
            RequestFilterFields = "Posting Date", "Source No.", "Payroll No.";
            column(SourceNo; "Source No.")
            {
            }
            column(PayrollNo; "Payroll No.")
            {
            }
            column(SalesAmountActual; "Sales Amount (Actual)")
            {
            }
            column(InventoryPostingGroup; "Inventory Posting Group")
            {
            }
            column(GenProdPostingGroup; "Gen. Prod. Posting Group")
            {
            }
            column(CustomerName; CustomerName)
            {

            }
            column(ReportFilter; ReportFilter)
            {

            }
            trigger OnAfterGetRecord()
            var
                lvCustomer: Record Customer;
            begin
                lvCustomer.Get("Source No.");
                CustomerName := lvCustomer.Name;
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
    var
        CustomerName: Text[100];
        ReportFilter: Text;

    trigger OnPreReport()
    begin
        ReportFilter := ValueEntry.GetFilters;
    end;
}
