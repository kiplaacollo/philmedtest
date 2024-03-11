report 50009 "Receipt Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReceiptVoucher.rdlc';

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
            dataitem("Receipt Header"; "Receipt Header")
            {
                column(No; "No.")
                {
                }
                column(Dated; Date)
                {
                }
                column(ChequeNo; "Cheque No")
                {
                }
                column(PayingAcc; "Bank Code")
                {
                }
                column(AccName; "Bank Name")
                {
                }
                column(CreatedBy; "User ID")
                {
                }
                column(NumberText; NumberText[1])
                {
                }
                dataitem("Receipt Line"; "Receipt Line")
                {
                    DataItemLink = "Document No" = FIELD ("No.");
                    column(RecAcc; "Receipt Line"."Account Code")
                    {
                    }
                    column(RecAccName; "Receipt Line"."Account Name")
                    {
                    }
                    column(AmountReceived; Amount)
                    {
                    }
                }
                dataitem("Approval Entry"; "Approval Entry")
                {
                    DataItemLink = "Document No." = FIELD ("No.");
                    DataItemTableView = WHERE (Status = FILTER (Approved | Open | Created));
                    column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                    {
                    }
                    column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                    {
                    }
                    column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                    {
                    }
                    column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                    {
                    }
                    column(Status_ApprovalEntry; "Approval Entry".Status)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CheckReport.InitTextVariable();
                    CheckReport.FormatNoTextENU(NumberText, ("Receipt Header"."Amount Received"));
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
        CheckReport: Report "Check Translation Management";
        NumberText: array[2] of Text[100];
}

