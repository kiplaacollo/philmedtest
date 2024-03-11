report 50146 "Customer Receipts Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedReceiptsSummary.rdlc';
    ApplicationArea = All;
    Caption = 'Customer Receipts Summary';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") where("Document Type" = Const(Payment), "Bal. Account Type" = filter('Bank Account'), Reversed = const(FALSE));
            RequestFilterFields = "Posting Date", "Bal. Account No.", "Customer No.";
            column(CustomerNo; "Customer No.")
            {
            }

            column(Bal__Account_No_; "Bal. Account No.")
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
            column(Document_No_; "Document No.")
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(Payment_Method_Code; "Payment Method Code")
            { }
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
    var
        lvUserSetup: Record "User Setup";
    begin
        CompanyInfo.Get();
        ReportFilters := CustLedgerEntry.GetFilters;
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportFilters: Text;
        Customer: Record Customer;
}
