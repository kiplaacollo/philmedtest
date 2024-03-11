report 50004 "Sales VAT Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesVATReport.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Posting Date";
            column(CustomerNo; "Sell-to Customer No.")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(No; "No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
            column(ESDSignature_SalesInvoiceHeader; "Sales Invoice Header"."ESD Signature")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = FIELD ("Sell-to Customer No.");
                RequestFilterFields = "No.";
                column(Name; Customer.Name)
                {
                }
                column(KRAPIN; Customer."VAT Registration No.")
                {
                }
            }
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
        DocumentTotals: Codeunit "Document Totals";
}

