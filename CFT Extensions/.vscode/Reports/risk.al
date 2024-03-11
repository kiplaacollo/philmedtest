report 50064 "Risk Classification Report"
{
    // version Loans ManagementV1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Loan Risk Classification Report.rdl';

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
            dataitem("Loan Provision Register"; "Loan Provision Register")
            {
                DataItemTableView = WHERE("Standard Classification" = FILTER(true));
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(CurrReport_PAGENO; CurrReport.PageNo)
                {
                }
                column(runningNo; runningNo)
                {
                }
                column(USERID; UserId)
                {
                }
                column(Classification; "Loan Provision Register".Classification)
                {
                }
                column(NoofAccounts; "Loan Provision Register"."No. of Accounts")
                {
                }
                column(OutstandingLoanPortfolio; "Loan Provision Register"."Outstanding Loan Portfolio")
                {
                }
                column(RequiredProvision; "Loan Provision Register"."Required Provision")
                {
                }
                column(RequiredProvisionAmount; RequiredProvisionAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Loan Provision Register".CalcFields("Outstanding Loan Portfolio");
                    RequiredProvisionAmount := ("Outstanding Loan Portfolio" * "Required Provision") / 100;
                end;

                trigger OnPreDataItem()
                begin
                    runningNo := 0;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        AsAt: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: Label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Loan_TypeCaptionLbl: Label 'Loan Type';
        Staff_No_CaptionLbl: Label 'Staff No.';
        Oustanding_BalanceCaptionLbl: Label 'Oustanding Balance';
        PerformingCaptionLbl: Label 'Performing';
        V1___30_Days_CaptionLbl: Label '(1 - 30 Days)';
        V0_Days_CaptionLbl: Label '(0 Days)';
        WatchCaptionLbl: Label 'Watch';
        V31___180_Days_CaptionLbl: Label '(31 - 180 Days)';
        SubstandardCaptionLbl: Label 'Substandard';
        V181___360_Days_CaptionLbl: Label '(181 - 360 Days)';
        DoubtfulCaptionLbl: Label 'Doubtful';
        Over_360_DaysCaptionLbl: Label 'Over 360 Days';
        LossCaptionLbl: Label 'Loss';
        TotalsCaptionLbl: Label 'Totals';
        CountCaptionLbl: Label 'Count';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        DateFilter: Text;
        runningNo: Integer;
        RequiredProvisionAmount: Decimal;
}

