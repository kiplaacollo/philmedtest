report 50123 "Open Invoices Not Allocated"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedOpenInvoicesNotAllocated.rdlc';
    ApplicationArea = All;
    Caption = 'Open Invoices Not Allocated';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") where("Document Type" = Const(Invoice), Open = Const(TRUE), Reversed = const(FALSE));
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Customer No.";
            column(CustomerNo; "Customer No.")
            {
            }

            column(Document_No_; "Document No.")
            {
            }
            column(OriginalAmount; "Original Amount")
            {
            }
            column(RemainingAmount; "Remaining Amount")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            { }
            column(ReportFilters; ReportFilters)
            { }
            column(Customer_Name; Customer.Name)
            { }

            trigger OnAfterGetRecord()
            begin
                Customer.get(CustLedgerEntry."Customer No.")
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
        ReportFilters := CustLedgerEntry.GetFilters;
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportFilters: Text;
        Customer: Record Customer;
}
