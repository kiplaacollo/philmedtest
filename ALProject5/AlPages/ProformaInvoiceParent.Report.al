report 50012 "Proforma Invoice-Parent"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ProformaInvoiceParent.rdlc';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            CalcFields = Picture;
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
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
                column(ProformaAmount_ProFormaInvoiceHeader; "ProForma Invoice Header"."Pro-forma Amount")
                {
                }
                column(PackageName_ProFormaInvoiceHeader; "ProForma Invoice Header"."Package Name")
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
                    column(Amount_ProformaInvoiceLines; "Proforma Invoice Lines".Amount)
                    {
                    }
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

