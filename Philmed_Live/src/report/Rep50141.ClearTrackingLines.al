report 50141 "Clear Tracking Lines"
{
    ApplicationArea = All;
    Caption = 'Clear Tracking Lines';
    UsageCategory = Tasks;
    dataset
    {
        dataitem(SalesInvoiceTrackingStores; "Sales Invoice Tracking Stores")
        {
            DataItemTableView = where("Branch Code" = filter('HEAD OFFICE'));
            trigger OnAfterGetRecord()
            begin
                if SalesInvoiceTrackingStores."Posting Date" < Today then
                    SalesInvoiceTrackingStores.Delete();
            end;
        }

        dataitem(SalesInvTrackingConfirm1; "Sales Inv. Tracking Confirm 1")
        {
            DataItemTableView = where("Branch Code" = filter('HEAD OFFICE'));
            trigger OnAfterGetRecord()
            begin
                if SalesInvTrackingConfirm1."Posting Date" < Today then
                    SalesInvTrackingConfirm1.Delete();
            end;
        }
        dataitem(SalesInvTrackingConfirm2; "Sales Inv. Tracking Confirm 2")
        {
            DataItemTableView = where("Branch Code" = filter('HEAD OFFICE'));
            trigger OnAfterGetRecord()
            begin
                if SalesInvTrackingConfirm2."Posting Date" < Today then
                    SalesInvTrackingConfirm2.Delete();
            end;
        }
        dataitem(SalesInvTrackingDispatch; "Sales Inv. Tracking Dispatch")
        {
            DataItemTableView = where("Branch Code" = filter('HEAD OFFICE'));
            trigger OnAfterGetRecord()
            begin
                if SalesInvTrackingDispatch."Posting Date" < Today then
                    SalesInvTrackingDispatch.Delete();
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
}
