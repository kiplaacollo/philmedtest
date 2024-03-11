report 50129 "Daily Sales Route Target"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedSalesRouteTargetReport.rdlc';
    ApplicationArea = All;
    Caption = 'Daily Sales Route Target Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Global Dimension 1 Code", "Route Plan") where("Item Ledger Entry Type" = const(Sale));
            RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Route Plan";

            column(Route_Plan; "Route Plan")
            { }
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
            column(RoutePlanSalesTarget; RoutePlan."Daily Sales Target")
            { }
            column(RoutePlanCustomerTarget; RoutePlan."Daily Customer Target")
            { }
            column(NumberofInvoices; NumberofInvoices)
            { }
            column(RoutePlanTotalSalesTarget; RoutePlanTotalSalesTarget)
            { }
            column(BranchRoutesTotalTarget; BranchRoutesTotalTarget)
            { }
            column(Salespers__Purch__Code; "Salespers./Purch. Code")
            { }
            column(RoutePlanTotalCustomerTarget; RoutePlanTotalCustomerTarget)
            { }
            column(Document_No_; "Document No.")
            { }

            trigger OnAfterGetRecord()
            begin
                NumberofInvoices := 0;
                if "Route Plan" <> '' then begin
                    RoutePlan.Get("Route Plan");
                    if (PrevRoutePlan <> "Value Entry"."Route Plan") AND ("Sales Amount (Actual)" <> 0) then begin
                        RoutePlanTotalSalesTarget += RoutePlan."Daily Sales Target";
                        RoutePlanTotalCustomerTarget += RoutePlan."Daily Customer Target";
                    end;

                    if (PrevBranch = "Value Entry"."Global Dimension 1 Code") AND ("Sales Amount (Actual)" <> 0) then begin
                        BranchRoutesTotalTarget += RoutePlan."Daily Sales Target"
                    end else begin
                        BranchRoutesTotalTarget := 0;
                        BranchRoutesTotalTarget += RoutePlan."Daily Sales Target";
                    end;

                    PrevRoutePlan := "Value Entry"."Route Plan";
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

        PrevRoutePlan := '';
        PrevBranch := '';
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportFilters: Text;
        RoutePlan: Record "Route Plan";
        NumberofInvoices: Integer;
        PrevRoutePlan: Code[20];
        RoutePlanTotalSalesTarget: Decimal;
        BranchRoutesTotalTarget: Decimal;
        PrevBranch: Code[20];
        RoutePlanTotalCustomerTarget: Integer;
}