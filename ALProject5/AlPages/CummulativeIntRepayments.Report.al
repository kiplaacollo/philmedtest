report 50434 "Cummulative  Int Repayments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CummulativeIntRepayments.rdlc';

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
            dataitem(pr_employees; pr_employees)
            {
                RequestFilterFields = st_no, "Period Filter";
                column(No; pr_employees.st_no)
                {
                }
                column(Name; pr_employees.Name)
                {
                }
                column(BankName; pr_employees.bank_name)
                {
                }
                column(BranchName; pr_employees.branch_name)
                {
                }
                column(BankAccNo; pr_employees.bank_account_no)
                {
                }
                column(NSSFNo; pr_employees.nssf_no)
                {
                }
                column(NHIFNo; pr_employees.nhif_no)
                {
                }
                column(PINNo; pr_employees.pin_no)
                {
                }
                column(UserId; UserId)
                {
                }
                column(Department; pr_employees.department_code)
                {
                }
                column(Period; Period)
                {
                }
                dataitem("Member Ledger Entry"; "Member Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD (st_no);
                    DataItemTableView = WHERE ("Transaction Type" = FILTER ("Interest Paid"));
                    column(CustomerNo_MemberLedgerEntry; "Member Ledger Entry"."Customer No.")
                    {
                    }
                    column(MemberName_MemberLedgerEntry; "Member Ledger Entry"."Member Name")
                    {
                    }
                    column(PostingDate_MemberLedgerEntry; "Member Ledger Entry"."Posting Date")
                    {
                    }
                    column(Amount_MemberLedgerEntry; ("Member Ledger Entry".Amount) * -1)
                    {
                    }
                    column(LoanNo_MemberLedgerEntry; "Member Ledger Entry"."Loan No")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ccount := ccount + 1;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    Period := pr_employees.GetFilter("Period Filter");
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
        Period: Code[100];
        ccount: Integer;
}

