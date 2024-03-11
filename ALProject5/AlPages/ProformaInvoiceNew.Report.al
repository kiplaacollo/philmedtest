report 50013 "Proforma Invoice-New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ProformaInvoiceNew.rdlc';

    dataset
    {
        dataitem("ProForma Invoice Header"; "ProForma Invoice Header")
        {
            RequestFilterFields = "Document No";
            column(DocumentNo_ProFormaInvoiceHeader; "ProForma Invoice Header"."Document No")
            {
            }
            column(CustomerNo_ProFormaInvoiceHeader; "ProForma Invoice Header"."Customer No")
            {
            }
            column(CustomerName_ProFormaInvoiceHeader; "ProForma Invoice Header"."Customer Name")
            {
            }
            column(CustomerBalance_ProFormaInvoiceHeader; "ProForma Invoice Header"."Customer Balance")
            {
            }
            column(DateGenerated_ProFormaInvoiceHeader; "ProForma Invoice Header"."Date Generated")
            {
            }
            column(ProformaAmount_ProFormaInvoiceHeader; Round("ProForma Invoice Header"."Pro-forma Amount", 1, '='))
            {
            }
            column(PackageName_ProFormaInvoiceHeader; "ProForma Invoice Header"."Package Name")
            {
            }
            column(OtherAssociatedAcounts_ProFormaInvoiceHeader; "ProForma Invoice Header"."Other Associated Acounts")
            {
            }
            dataitem("Proforma Invoice Lines"; "Proforma Invoice Lines")
            {
                DataItemLink = "Document No" = FIELD ("Document No");
                column(DocumentNo_ProformaInvoiceLines; "Proforma Invoice Lines"."Document No")
                {
                }
                column(Description_ProformaInvoiceLines; "Proforma Invoice Lines".Description)
                {
                }
                column(Rate_ProformaInvoiceLines; "Proforma Invoice Lines".Rate)
                {
                }
                column(Quantity_ProformaInvoiceLines; "Proforma Invoice Lines".Quantity)
                {
                }
                column(Amount_ProformaInvoiceLines; Round("Proforma Invoice Lines".Amount, 1, '='))
                {
                }
                column(PackageName_ProformaInvoiceLines; "Proforma Invoice Lines"."Package Name")
                {
                }
                column(CustomerBalance_ProformaInvoiceLines; "Proforma Invoice Lines"."Customer Balance")
                {
                }
                column(CustomerNo_ProformaInvoiceLines; "Proforma Invoice Lines"."Customer No")
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
}

