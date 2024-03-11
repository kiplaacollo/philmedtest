report 50011 "Credit Note Test Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CreditNoteTestReport.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(No_Customer; Customer."No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CFTFactory.CorrectInvoice(Customer."No.", "Amount Paid");

                CFTFactory.FnGenerateInvoice(Customer."No.", Today, "Amount Paid", '3456', ReceiptCode, Processed);
            end;

            trigger OnPostDataItem()
            begin
                Message('Test Complete');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Amount Paid"; "Amount Paid")
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        "Amount Paid": Decimal;
        CFTFactory: Codeunit "CFT Factory";
        ReceiptCode: Code[10];
        Processed: Boolean;
}

