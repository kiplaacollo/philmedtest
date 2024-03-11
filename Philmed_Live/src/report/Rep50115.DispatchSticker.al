report 50115 "Dispatch Sticker"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PhilmedDispatchSticker.rdlc';
    ApplicationArea = All;
    Caption = 'Dispatch Sticker';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SalesInvoiceTracking; "Sales Invoice Tracking")
        {
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(InvoiceNo; "Invoice No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(RoutePlan; "Route Plan")
            {
            }
            column(Rider; Rider)
            {
            }
            column(DispatchTime; "Dispatch Time")
            {
            }

            column(PhoneNo; PhoneNo)
            {
            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {
            }

            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
            begin
                Customer.Get("Customer No.");
                PhoneNo := Customer."Phone No.";

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
        PhoneNo: Text[100];
}
