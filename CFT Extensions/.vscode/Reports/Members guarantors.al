report 50107 Members_guarantors
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Loan_Guarantee_Details; "Guarantors Table")
        {
            DataItemTableView = where("Guarantor Full Name" = filter(<> ''));

            RequestFilterFields = "Loan Number", "Loanee Number";

            column(Amount_Guaranteed; Loan_Guarantee_Details."Guaranteed Amount")
            {

            }
            column(Loanee_Number; Loan_Guarantee_Details."Loanee Number")
            {

            }
            column(Loanee_Name; Loan_Guarantee_Details."Loanee Full Name")
            {

            }
            column(guarantors_name; Loan_Guarantee_Details."Guarantor Full Name")
            {

            }
            column(Member_No; Loan_Guarantee_Details."Guarantor Number")
            {

            }
            column(Loan_No; Loan_Guarantee_Details."Loan Number")
            {

            }
            column(TotalOutstanding; Loan_Guarantee_Details."Outstanding Loan Balance")
            {

            }
            column(No; no)
            {

            }
            trigger OnAfterGetRecord()
            begin
                no := no + 1;
            end;

        }
    }


    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Members Guarantors.rdl';
        }
    }

    var
        no: Integer;
}