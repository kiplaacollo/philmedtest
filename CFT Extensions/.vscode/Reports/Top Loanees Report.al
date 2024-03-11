report 50074 "Top Loanees Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Top Loanees.rdl';


    dataset
    {
        dataitem(CompanyInformation; "Company Information")
        {
            CalcFields = Picture;
            column(Name_CompanyInformation; CompanyInformation.Name)
            {

            }
            column(Address_CompanyInformation; CompanyInformation.Address)
            {

            }
            column(Address_2; CompanyInformation."Address 2")
            {

            }
            column(City; CompanyInformation.City)
            {

            }
            column(Phone_No_; CompanyInformation."Phone No.")
            {

            }
            column(Picture; CompanyInformation.Picture)
            {

            }

        }
        dataitem(DataItemName; Loans)
        {
            RequestFilterFields = "Loan Number", "Application Date";
            DataItemTableView = sorting("Loan Balance") order(Descending) where("Approval Status" = filter(approved), Posted = filter(true));
            column(Member_Number; DataItemName."Member Number")
            {

            }
            column(Full_Name; DataItemName."Full Name")
            {

            }
            column(Loan_Number; DataItemName."Loan Number")
            {

            }
            column(ED_Loan_Account_No; DataItemName."ED Loan Account No")
            {

            }
            column(Loan_Product; DataItemName."Loan Product")
            {

            }
            column(RM_Name; DataItemName."RM Name")
            {

            }
            column(Branch_Code; DataItemName."Branch Code")
            {

            }
            column(Approved_Amount; DataItemName."Approved Amount")
            {

            }
            column(Loan_Balance; DataItemName."Loan Balance")
            {

            }
        }
    }



    procedure FnUpdateLoanBalances(AsAt: Date)
    begin
        ObjLoans.Reset();
        ObjLoans.SetRange(ObjLoans."Loan Number");
        ObjLoans.SetFilter(ObjLoans."Date Filter", '..%1', AsAt);
        if ObjLoans.Find('-') then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."New Outstanding Loan");
                if ObjLoans."Loan Balance" <> ObjLoans."New Outstanding Loan" then begin
                    ObjLoans."Loan Balance" := ObjLoans."New Outstanding Loan";
                    ObjLoans.Modify(true);
                end;
            until ObjLoans.Next = 0;
        end;
    end;

    var
        myInt: Integer;
        ObjLoans: Record Loans;
}