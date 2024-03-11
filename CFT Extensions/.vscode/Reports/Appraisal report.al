report 50105 LoanApraisalReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Loans_Register; Loans)
        {
            RequestFilterFields = "Loan Number", "Date Filter";
            DataItemTableView = where("Loan Number" = filter(<> ''));
            column(Loan_No; Loans_Register."Loan Number")
            {

            }
            column(Member_Name; Loans_Register."Full Name")
            {

            }
            column(Member_No; Loans_Register."Member Number")
            {

            }
            column(Approved_Amount; Loans_Register."Approved Amount")
            {

            }

            column(Application_Date; Loans_Register."Application Date")
            {

            }
            column(Loan_Product; Loans_Register."Loan Product")
            {

            }
            column(Interest_Rate; Loans_Register."Interest Rate")
            {

            }
            column(Applied_Amount; Loans_Register."Applied Amount")
            {

            }
            column(Installments; Loans_Register.Installments)
            {

            }
            column(Principal_Repayment; Loans_Register."Principal Repayment")
            {

            }
            column(Total_Monthly_Repayment; Loans_Register."Total Monthly Repayment")
            {

            }
            column(Deposits_Balance; Loans_Register."Deposits Balance")
            {

            }
            column(Deposits_Factor; Loans_Register."Deposits Factor")
            {

            }
            column(Loan_Balance; Loans_Register."Loan Balance")
            {

            }
            column(Share_Capital_Balance; Loans_Register."Share Capital Balance")
            {

            }
            column(Max_Qualification_By_Deposits; Loans_Register."Max Qualification By Deposits")
            {

            }
            column(Third_Basic; Loans_Register."1/3 Basic")
            {

            }
            column(Net_Available_Amount; Loans_Register."Net Available Amount")
            {

            }
            column(QualifyBySalary; Loans_Register."Max Qualification By Salary")
            {

            }

            column(Loan_Number; Loans_Register."Loan Number")
            {

            }
            column(Loan_Product_active; Loans_Register."Loan Product")
            {

            }
            column(Active_Loan_amount; Loans_Register."Amount Disbursed")
            {

            }
            column(Active_Monthly_Repayment; Loans_Register."Total Monthly Repayment")
            {

            }
            column(Active_disbursment_date; Loans_Register."Disbursement Date")
            {

            }
            column(Active_installments; Loans_Register.Installments)
            {

            }
            column(Active_Outstanding; Loans_Register."Outstanding Loan")
            {

            }
            column(Active_interest; Loans_Register."Outstanding Interest")
            {

            }
            column(Active_total_outstanding; Loans_Register."Outstanding Loan")
            {

            }


            dataitem(guarantors_Appraisal; "Guarantors Table")
            {
                DataItemLink = "Loan Number" = FIELD("Loan Number"), "Loanee Number" = FIELD("Member Number");
                DataItemTableView = WHERE("Guarantor Number" = FILTER(<> ''));
                column(Guarantor_Number; guarantors_Appraisal."Guarantor Number")
                {

                }
                column(Guarantor_Full_Name; guarantors_Appraisal."Guarantor Full Name")
                {

                }
                column(Guarantor_Deposits; guarantors_Appraisal."Guarantor Deposits")
                {

                }
                column(Guaranteed_Amount; guarantors_Appraisal."Guaranteed Amount")
                {

                }


                dataitem("Loan Collateral Details"; "Loan Collateral Details")
                {
                    DataItemLink = "Loan No" = FIELD("Loan Number");
                    column(Type_LoanCollateralDetails; "Loan Collateral Details".Type)
                    {
                    }
                    column(AmountToCommit_LoanCollateralDetails; "Loan Collateral Details"."Amount To Commit")
                    {
                    }
                }

            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Appraisal.rdl';
        }
    }
}