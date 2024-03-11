report 50121 "BO Statement"
{
    // version Loans ManagementV1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'BO Statement.rdl';

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
            dataitem(Account; Customer)
            {
                RequestFilterFields = "No.";
                column(FullName_Account; Account."Full Name")
                {
                }
                column(IDNumber_Account; Account."ID Number")
                {
                }
                column(DateProcessed_Account; Account."Date Processed")
                {
                }
                column(MemberNumber_Account; Account."No.")
                {
                }
                column(MembershipStatus_Account; Account."Membership Status")
                {
                }
                dataitem(BOLedgEntry; "Detailed Cust. Ledg. Entry")
                {
                    //CalcFields = Amount, "Credit Amount", "Debit Amount";
                    DataItemLink = "Customer No." = FIELD("No.");
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
                    column(ShareCapitalRunningBalance; ShareCapitalRunningBalance)
                    {
                    }
                    column(DepositsRunningBalance; DepositsRunningBalance)
                    {
                    }
                    column(BenevolentRunningBalance; BenevolentRunningBalance)
                    {
                    }
                    column(LoanRunningBalance; LoanRunningBalance)
                    {

                    }
                    dataitem(Loans; Loans)
                    {
                        DataItemTableView = sorting("Loan Number") where(Posted = const(true), "Loan Number" = filter(<> ''));
                        DataItemLink = "Member Number" = field("Customer No."), "Date Filter" = field("Posting Date");
                        column(Member_Number; Loans."Member Number")
                        {

                        }
                        column(Loan_Number; Loans."Loan Number")
                        {

                        }
                        column(Loan_Product; Loans."Loan Product")
                        {

                        }
                        column(Date_Filter1; Loans."Date Filter")
                        {

                        }
                        column(Approved_Amount; Loans."Approved Amount")
                        {

                        }
                        column(New_Outstanding_Loan; Loans."New Outstanding Loan")
                        {

                        }
                        column(New_Outstanding_Interest; Loans."New Outstanding Interest")
                        {

                        }
                        column(Installments; Loans.Installments)
                        {

                        }
                        column(Principal_Repayment; "Principal Repayment")
                        {

                        }
                        column(Mode_of_Disbursement; Loans."Mode of Disbursement")
                        {

                        }

                        trigger OnAfterGetRecord()
                        begin
                            if BOLedgEntry."Transaction Type" = BOLedgEntry."Transaction Type"::"Share Capital" then
                                ShareCapitalRunningBalance := ShareCapitalRunningBalance + BOLedgEntry.Amount * -1;

                            if BOLedgEntry."Transaction Type" = BOLedgEntry."Transaction Type"::"Deposit Contribution" then
                                DepositsRunningBalance := DepositsRunningBalance + BOLedgEntry.Amount * -1;

                            if BOLedgEntry."Transaction Type" = BOLedgEntry."Transaction Type"::"Deposit Contribution" then
                                BenevolentRunningBalance := DepositsRunningBalance + BOLedgEntry.Amount * -1;

                            if BOLedgEntry."Transaction Type" = BOLedgEntry."Transaction Type"::Loan then
                                LoanRunningBalance := LoanRunningBalance + BOLedgEntry.Amount * -1;
                        end;

                        trigger OnPreDataItem()
                        begin
                            ShareCapitalRunningBalance := 0;
                            DepositsRunningBalance := 0;
                            LoanRunningBalance := 0;
                        end;
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

    var
        DepositsRunningBalance: Decimal;
        ShareCapitalRunningBalance: Decimal;
        BenevolentRunningBalance: Decimal;
        LoanRunningBalance: Decimal;
}

