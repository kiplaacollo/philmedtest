report 50122 "Receipts Not Allocated"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedReceiptsNotAllocated.rdlc';
    ApplicationArea = All;
    Caption = 'Receipts Not Allocated';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") where("Document Type" = Const(Payment), Open = const(TRUE), Reversed = const(FALSE));
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Customer No.";
            column(CustomerNo; "Customer No.")
            {
            }

            column(Document_No_; "Document No.")
            {
            }
            column(Document_Type; "Document Type")
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
