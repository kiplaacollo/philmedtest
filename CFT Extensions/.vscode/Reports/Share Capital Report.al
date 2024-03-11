report 50101 ShareCapitalReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'sharecapitalreport.rdl';


    dataset
    {
        dataitem(DataItemName; Customer)
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
            column(ShareCapital; DataItemName."Share Capital") { }

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