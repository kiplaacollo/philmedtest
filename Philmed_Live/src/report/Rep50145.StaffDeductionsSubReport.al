report 50145 "Staff Deductions Sub - Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedStaffDeductionSubRpt.rdlc';
    ApplicationArea = All;
    Caption = 'Staff Deductions Sub - Report';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(ValueEntry; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.") where("Source Type" = const(customer), "Payroll No." = filter(<> ''));
            RequestFilterFields = "Posting Date", "Source No.", "Payroll No.", "Inventory Posting Group", "Item Category Code";
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
            column(Document_No_; "Document No.")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(Item_Category_Code; "Item Category Code")
            { }
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
