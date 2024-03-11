report 50111 "BO Loan Statement V1.0"
{
    // version Loans ManagementV1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'BO Loan Statement V1.0.rdl';

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
            dataitem(Loans; Loans)
            {
                RequestFilterFields = "Member Number", "Loan Number";
                column(LoanNumber_Loans; Loans."ED Loan Account No")
                {
                }
                column(MemberNumber_Loans; Loans."Member Number")
                {
                }
                column(FullName_Loans; Loans."Full Name")
                {
                }
                column(IDNumber_Loans; Loans."ID Number")
                {
                }
                dataitem(BOLedgEntry; "Detailed Cust. Ledg. Entry")
                {
                    CalcFields = Amount, "Credit Amount", "Debit Amount";
                    DataItemLink = "Customer No." = FIELD("Member Number");
                    DataItemTableView = WHERE(Amount = FILTER(<> 0));
                    column(BONo_BOLedgEntry; BOLedgEntry."Customer No.")
                    {
                    }
                    column(PostingDate_BOLedgEntry; BOLedgEntry."Posting Date")
                    {
                    }
                    column(DocumentN_BOLedgEntry; BOLedgEntry."Document No.")
                    {
                    }
                    column(Amount_BOLedgEntry; BOLedgEntry.Amount)
                    {
                    }
                    column(DebitAmount_BOLedgEntry; BOLedgEntry."Debit Amount")
                    {
                    }
                    column(CreditAmount_BOLedgEntry; BOLedgEntry."Credit Amount")
                    {
                    }
                    column(TransactionType_BOLedgEntry; BOLedgEntry."Transaction Type")
                    {
                    }
                    column(Description_BOLedgEntry; BOLedgEntry.Description)
                    {
                    }


                    trigger OnAfterGetRecord()
                    begin
                        // RunningBalance := RunningBalance+BOLedgEntry.Amount;
                        BOLedgEntry.SetFilter("Posting Date", DateFilter);
                        // if BOLedgEntry."Loan Number" <> '' then
                        // BOLedgEntry.SetFilter(BOLedgEntry."Loan Number",LoanNo);

                        if BOLedgEntry.Amount <> 0 then begin
                            //FnAmountPaid(BOLedgEntry."Document No.",BOLedgEntry."Customer No.");
                        end;

                    end;
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
        RunningBalance: Decimal;
        TotalAmount: Decimal;
        //  ObjBOAccountStatement: Record "BO Account Statement";
        CFTFactory: Codeunit "CFT Factory";
        TotalCredits: Decimal;
        DateFilter: Text;
        LoanNo: Code[50];





}

