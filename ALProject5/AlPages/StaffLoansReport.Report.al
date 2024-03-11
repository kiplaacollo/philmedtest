report 50465 "Staff Loans Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StaffLoansReport.rdlc';

    dataset
    {
        dataitem("Staff Loans"; "Staff Loans")
        {
            RequestFilterFields = "Loan product type";
            column(LoanNo_StaffLoans; "Staff Loans"."Loan  No.")
            {
            }
            column(IssueDate_StaffLoans; "Staff Loans"."Issue Date")
            {
            }
            column(StaffNo_StaffLoans; "Staff Loans"."Staff No")
            {
            }
            column(LoanAmount_StaffLoans; "Staff Loans"."Loan Amount")
            {
            }
            column(Loanproducttype_StaffLoans; "Staff Loans"."Loan product type")
            {
            }
            column(Installments_StaffLoans; "Staff Loans".Installments)
            {
            }
            column(Interest_StaffLoans; "Staff Loans".Interest)
            {
            }
            column(StaffName_StaffLoans; "Staff Loans"."Staff Name")
            {
            }
            column(Outstandingloan_StaffLoans; "Staff Loans"."Outstanding loan")
            {
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

