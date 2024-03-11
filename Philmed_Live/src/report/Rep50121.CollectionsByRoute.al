report 50121 "Collections By Route"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedCollectionsByRoute.rdlc';
    ApplicationArea = All;
    Caption = 'Collections By Route';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") where("Document Type" = Const(Payment), Reversed = const(FALSE));
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Customer No.";
            column(CustomerNo; "Customer No.")
            {
            }

            column(CustomerRoute; "Customer Route")
            {
            }
            column(CustomerRegion; "Customer Region")
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
