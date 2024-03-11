report 50001 "Generate Bulk Sales Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GenerateBulkSalesInvoice.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = WHERE ("ESD Processed" = CONST (true));
            RequestFilterFields = "No.", "Bill-to Customer No.", "Posting Date";
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ObjSalesInvoice.Reset;
                ObjSalesInvoice.SetRange(ObjSalesInvoice."No.", "Sales Invoice Header"."No.");
                ObjSalesInvoice.SetRange(ObjSalesInvoice."Bill-to Customer No.", "Sales Invoice Header"."Bill-to Customer No.");
                if ObjSalesInvoice.Find('-') then begin
                    Filename := '';
                    Filename := SMTPSetup."Path to Save Invoices" + 'Sales Invoice ' + ObjSalesInvoice."No." + '.pdf';

                    if FILE.Exists(Filename) then
                        FILE.Erase(Filename);

                    REPORT.SaveAsPdf(REPORT::"Sales - Invoice", Filename, ObjSalesInvoice);
                end;

                ObjCust.Reset;
                ObjCust.SetRange("No.", "Sales Invoice Header"."Bill-to Customer No.");
                if ObjCust.Find('-') then begin
                    ObjCust."Invoice No" := "Sales Invoice Header"."No.";
                    ObjCust."Invoice Due Date" := "Sales Invoice Header"."Due Date";
                    ObjCust.Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('The Invoices Were Successfully Generated. Browse to %1 to confirm.', SMTPSetup."Path to Save Invoices");
            end;

            trigger OnPreDataItem()
            var
                pdate: Text;
            begin
                SMTPSetup.Get;

                ObjCust.Reset;
                ObjCust.SetRange("No.");
                ObjCust.SetFilter("Invoice No", '<>%1', '');
                if ObjCust.Find('-') then begin
                    repeat
                        ObjCust."Invoice No" := '';
                        ObjCust."Invoice Due Date" := 0D;
                        ObjCust.Modify;
                    until ObjCust.Next = 0;
                end;

                pdate := "Sales Invoice Header".GetFilter("Sales Invoice Header"."Posting Date");

                if pdate = '' then
                    Error('The Invoice Posting Date must be selected!');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjSalesInvoice: Record "Sales Invoice Header";
        Filename: Text;
        SMTPSetup: Record "SMTP Mail Setup";
        ObjCust: Record Customer;
}

