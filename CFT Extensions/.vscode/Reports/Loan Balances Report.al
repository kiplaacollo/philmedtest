report 50104 LoanBalancesReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'loanbalancereport.rdl';


    dataset
    {
        dataitem(DataItemName; Loans)
        {
            RequestFilterFields = "Loan Number", "Application Date";
            DataItemTableView = where("Outstanding Loan" = filter(> 0), "Outstanding Interest" = filter(> 0), "posted" = const(TRUE));


            column(MemberNumber; "Member Number") { }
            column(MemberName; "Full Name") { }
            column(MobileNumber; "Mobile Number") { }
            column(LoanNumber; "Loan Number") { }
            column(LoanType; "Loan Product") { }
            column(RepaymentMethod; DataItemName."Interest Calculation Method") { }
            column(ApplicationDate; "Application Date") { }
            column(InstallmentPeriod; DataItemName.Installments) { }
            column(RequestedAmount; DataItemName."Applied Amount") { }
            column(ApprovedAmount; "Approved Amount") { }
            column(Repayment; DataItemName."Total Monthly Repayment") { }
            column(RepaymentStartDate; DataItemName."Repayment Debut Date") { }
            column(principalpaid; DataItemName."Principal Paid") { }
            column(interestpaid; DataItemName."Interest Paid") { }
            column(outstandingloan; DataItemName."Outstanding Loan") { }
            column(outstandinginterest; DataItemName."Outstanding Interest") { }
            column(lastpaydate; DataItemName."Last Payment Date") { }
            column(interestrate; DataItemName."Interest Rate") { }
            column(repaymentfrequency; DataItemName."Repayment Frequency") { }
            column(issueddate; DataItemName."Disbursement Date") { }

            column(CompanyPic; CompanyInfo.Picture)
            {

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

            end;

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