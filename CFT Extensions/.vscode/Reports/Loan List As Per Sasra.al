report 50103 LoanListAsPerSasra
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'loanlist_as_per_sasra.rdl';


    dataset
    {
        dataitem(DataItemName; Loans)
        {
            RequestFilterFields = "Loan Number", "Application Date";

            column(MemberNumber; "Member Number") { }
            column(MemberName; "Full Name") { }
            column(MobileNumber; "Mobile Number") { }
            column(LoanNumber; "Loan Number") { }
            column(LoanType; "Loan Product") { }
            column(RepaymentMethod; DataItemName."Interest Calculation Method") { }
            column(ApplicationDate; "Application Date") { }
            column(InstallmentPeriod; DataItemName.Installments) { }
            column(ApprovedAmount; "Approved Amount") { }
            column(Repayment; DataItemName."Total Monthly Repayment") { }
            column(RepaymentStartDate; DataItemName."Repayment Debut Date") { }
            column(principalpaid; DataItemName."Principal Paid") { }
            column(interestpaid; DataItemName."Interest Paid") { }
            column(lastpaydate; DataItemName."Last Payment Date") { }
            column(interestrate; DataItemName."Interest Rate") { }
            column(repaymentfrequency; DataItemName."Repayment Frequency") { }
            column(issueddate; DataItemName."Disbursement Date") { }
            column(category; DataItemName."Loan Category") { }

            column(CompanyPic; CompanyInfo.Picture)
            {

            }

        }




    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;


    var
        CompanyInfo: Record "Company Information";
}