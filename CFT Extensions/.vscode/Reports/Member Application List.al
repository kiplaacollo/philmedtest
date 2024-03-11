report 50453 MemberApplicationListReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'memberapplicationlistreport.rdl';


    dataset
    {
        dataitem(DataItemName; "BO Applications")
        {
            RequestFilterFields = "No", "Application Date";
            DataItemTableView = where("Full Name" = filter(<> ''));

            column(MemberNumber; DataItemName."No") { }
            column(MemberName; DataItemName."Full Name") { }
            column(MobileNumber; DataItemName."Mobile Number") { }
            column(IDNumber; DataItemName."ID Number") { }
            column(Status; DataItemName."Membership Status") { }
            column(PayrollNumber; DataItemName."Payroll Number") { }
            column(RegistrationDate; DataItemName."Registration Date") { }
            column(MemberClass; DataItemName."Member Class") { }
            column(DOB; DataItemName."Date of Birth") { }



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