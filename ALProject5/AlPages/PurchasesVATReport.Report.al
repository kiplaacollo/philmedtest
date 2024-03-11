report 50005 "Purchases VAT Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchasesVATReport.rdlc';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(VendorNo; "Buy-from Vendor No.")
            {
            }
            column(PostingDate; Format("Posting Date"))
            {
            }
            column(No; "No.")
            {
            }
            column(VendorInvoiceNo; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
            dataitem(Vendor; Vendor)
            {
                DataItemLink = "No." = FIELD ("Buy-from Vendor No.");
                RequestFilterFields = "No.";
                column(Name; Vendor.Name)
                {
                }
                column(KRAPIN; Vendor."VAT Registration No.")
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

