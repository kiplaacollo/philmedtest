report 50109 "Receipt Report"
{
    // version Funds Management Module v1.1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Receipt Report.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            CalcFields = Picture;
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(Address2_CompanyInformation; "Company Information"."Address 2")
            {
            }
            column(City_CompanyInformation; "Company Information".City)
            {
            }
            column(PhoneNo_CompanyInformation; "Company Information"."Phone No.")
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
            dataitem("BO Receipt Header"; "BO Receipt Header.al")
            {
                RequestFilterFields = "No.";
                column(No_BOReceiptHeader; "BO Receipt Header"."No.")
                {
                }
                column(Paymode_BOReceiptHeader; "BO Receipt Header"."Pay mode")
                {
                }
                column(ChequeNo_BOReceiptHeader; "BO Receipt Header"."Cheque No")
                {
                }
                column(Amount_BOReceiptHeader; "BO Receipt Header".Amount)
                {
                }
                column(PostingDate_BOReceiptHeader; "BO Receipt Header"."Posting Date")
                {
                }
                column(PayingBankName_BOReceiptHeader; "BO Receipt Header"."Paying Bank Name")
                {
                }
                column(PostedBy_BOReceiptHeader; "BO Receipt Header"."Posted By")
                {
                }
                column(Remarks_BOReceiptHeader; "BO Receipt Header".Remarks)
                {
                }
                column(NumberText; NumberText[1])
                {
                }
                dataitem("BO Receipt Line"; "BO Receipt Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    column(No_BOReceiptLine; "BO Receipt Line"."No.")
                    {
                    }
                    column(TransactionType_BOReceiptLine; "BO Receipt Line"."Transaction Type")
                    {
                    }
                    column(LoanNo_BOReceiptLine; "BO Receipt Line"."Loan No")
                    {
                    }
                    column(ClientCode_BOReceiptLine; "BO Receipt Line"."Client Code")
                    {
                    }
                    column(ClientName_BOReceiptLine; "BO Receipt Line"."Client Name")
                    {
                    }
                    column(Amount_BOReceiptLine; "BO Receipt Line".Amount)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin

                    CheckReport.InitTextVariable();
                    CheckReport.FormatNoText(NumberText, Amount, '');
                end;
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
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
}

