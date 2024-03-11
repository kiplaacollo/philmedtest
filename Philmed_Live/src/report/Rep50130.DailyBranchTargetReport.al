report 50130 "Daily Branch Target Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedBranchTargetReport.rdlc';
    ApplicationArea = All;
    Caption = 'Daily Branch Target Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Global Dimension 1 Code") where("Item Ledger Entry Type" = const(Sale));
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code";

            column(Posting_Date; "Posting Date")
            { }
            column(Sales_Amount__Actual_; "Sales Amount (Actual)")
            { }
            column(Cost_Amount__Actual_; "Cost Amount (Actual)")
            { }
            column(Invoiced_Quantity; "Invoiced Quantity")
            { }

            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            { }
            column(Company_Name; CompanyInfo.Name)
            { }
            column(ReportFilters; ReportFilters)
            { }
            column(BranchSalesTarget; Branch."Daily Sales Target")
            { }
            column(BranchCustomerTarget; Branch."Daily Customer Target")
            { }
            column(NumberofInvoices; NumberofInvoices)
            { }
            column(TotalBranchTarget; TotalBranchTarget)
            { }

            trigger OnAfterGetRecord()
            begin
                NumberofInvoices := 0;
                if "Global Dimension 1 Code" <> '' then begin
                    Branch.Get('BRANCH', "Global Dimension 1 Code");

                    if (PrevBranch <> "Value Entry"."Global Dimension 1 Code") AND ("Sales Amount (Actual)" <> 0) then
                        TotalBranchTarget += Branch."Daily Sales Target";

                    PrevBranch := "Value Entry"."Global Dimension 1 Code";
                end;

                if "Document Type" = "Document Type"::"Sales Invoice" then
                    NumberofInvoices := 1;


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
        ReportFilters := "Value Entry".GetFilters;
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');

        PrevBranch := '';
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportFilters: Text;
        Branch: Record "Dimension Value";
        NumberofInvoices: Integer;
        TotalBranchTarget: Decimal;
        PrevBranch: Code[20];
}