report 50110 "Loans Repayment Schedule"
{
    // version Loans ManagementV1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Loans Repayment Schedule.rdl';
    PaperSourceDefaultPage = Upper;
    PaperSourceFirstPage = Upper;

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
            dataitem(Loans; Loans)
            {
                PrintOnlyIfDetail = false;
                RequestFilterFields = "Loan Number", "Approval Date";
                column(Loans_Loans__Issued_Date_; "Approval Date")
                {
                }
                column(Loans_Installments__Grace_Period___Principle__M__; Installments)
                {
                }
                column(Loans_Loans_Interest; "Interest rate")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(EmployerName; EmployerName)
                {
                }
                column(Loans_Loans__Approved_Amount_; "Approved Amount")
                {
                }
                column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                {
                }
                column(GrossDisbursedAmount_Loans; Loans."Gross Disbursed Amount")
                {
                }
                column(AmountDisbursed_Loans; Loans."Amount Disbursed")
                {
                }
                column(Loans_Loans__Loan_Product_Type_Name_; "Loan Product")
                {
                }
                column(Loans_Loans__Loan__No__; "Loan Number")
                {
                }
                column(LoanAccountNo_Loans; Loans."ED Loan Account No")
                {
                }
                column(Loans_Loans__Client_Name_; "Full Name")
                {
                }
                column(Loans_Loans__Client_Code_; "Member Number")
                {
                }
                column(Loans__Repayment_Method_; "Interest Calculation Method")
                {
                }
                column(MonthlyRepayment; "Applied Amount")
                {
                }
                column(Intallments__Months_Caption; Intallments__Months_CaptionLbl)
                {
                }
                column(Disbursment_DateCaption; Disbursment_DateCaptionLbl)
                {
                }
                column(Current_InterestCaption; Current_InterestCaptionLbl)
                {
                }
                column(Loan_AmountCaption; Loan_AmountCaptionLbl)
                {
                }
                column(Loan_ProductCaption; Loan_ProductCaptionLbl)
                {
                }
                column(Loan_No_Caption; Loan_No_CaptionLbl)
                {
                }
                column(Account_No_Caption; Account_No_CaptionLbl)
                {
                }
                column(EmployerCode_Loans; "Employer Code")
                {
                }
                column(Loans__Repayment_Method_Caption; FieldCaption("Interest Calculation Method"))
                {
                }
                column(Loans_NewRepaymentPeriod; Installments)
                {
                }
                column(INST; INST)
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(CompanyInfo_Address; CompanyInfo.Address)
                {
                }
                column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfo__E_Mail_; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfo_City; CompanyInfo.City)
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(CompanyName; CompanyInformation.Name)
                {
                }
                column(CompanyAddress; CompanyInformation.Address)
                {
                }
                column(Address2; CompanyInformation."Address 2")
                {
                }
                column(PostCode; CompanyInformation."Post Code")
                {
                }
                column(City; CompanyInformation.City)
                {
                }
                column(Country; CompanyInformation."Country/Region Code")
                {
                }
                column(CompanyPhoneNo; CompanyInformation."Phone No.")
                {
                }
                column(CompanyFaxNo; CompanyInformation."Fax No.")
                {
                }
                column(E_mail; CompanyInformation."E-Mail")
                {
                }
                column(CPic; CompanyInformation.Picture)
                {
                }
                column(TrunchAmount_LoansRegister; "Approved Amount")
                {
                }
                column(TotalMonthlyRepayment_Loans; Loans."Total Monthly Repayment")
                {
                }
                column(DisbursementDate_Loans; Loans."Disbursement Date")
                {
                }
                dataitem("Loan Repayment schedule"; "Loan Repayment Shedule")
                {
                    DataItemLink = "Loan No." = FIELD("Loan Number");
                    DataItemTableView = SORTING("Loan No.", "Client No.", "Repayment Date");
                    PrintOnlyIfDetail = false;
                    RequestFilterFields = "Client No.", "Loan Category";
                    column(ROUND__Monthly_Repayment__10_____; "Monthly Repayment")
                    {
                    }
                    column(FORMAT__Repayment_Date__0_4_; "Repayment Date")
                    {
                    }
                    column(ROUND__Principal_Repayment__10_____; "Principal Repayment")
                    {
                    }
                    column(ROUND__Monthly_Interest__10_____; "Monthly Interest")
                    {
                    }
                    column(LoanBalance; "Loan Balance")
                    {
                    }
                    column(Loan_Repayment_Schedule__Repayment_Code_; "Repayment Code")
                    {
                    }
                    column(ROUND__Monthly_Repayment__10______Control1000000043; "Monthly Repayment")
                    {
                    }
                    column(ROUND__Principal_Repayment__10______Control1000000014; "Principal Repayment")
                    {
                    }
                    column(ROUND__Monthly_Interest__10______Control1000000015; "Monthly Interest")
                    {
                    }
                    column(Monthly_RepaymentCaption; Monthly_RepaymentCaptionLbl)
                    {
                    }
                    column(InterestCaption; InterestCaptionLbl)
                    {
                    }
                    column(Principal_RepaymentCaption; Principal_RepaymentCaptionLbl)
                    {
                    }
                    column(Due_DateCaption; Due_DateCaptionLbl)
                    {
                    }
                    column(Loan_BalanceCaption; Loan_BalanceCaptionLbl)
                    {
                    }
                    column(Loan_RepaymentCaption; Loan_RepaymentCaptionLbl)
                    {
                    }
                    column(TotalCaption; TotalCaptionLbl)
                    {
                    }
                    column(Loan_Repayment_Schedule_Loan_No_; "Loan No.")
                    {
                    }
                    column(Loan_Repayment_Schedule_Member_No_; "Client No.")
                    {
                    }
                    column(Loan_Repayment_Schedule_Repayment_Date; "Repayment Date")
                    {
                    }
                    column(RepaymentCode; "Instalment No")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust.No, Loans."Employer Code");
                        if Cust.Find('-') then begin
                            EmployerName := Cust."Account Name";

                        end;

                        i := i + 1;

                        TotalPrincipalRepayment := (TotalPrincipalRepayment + "Principal Repayment");

                        if i = 1 then
                            LoanBalance := ("Loan Amount")
                        else begin
                            LoanBalance := ("Loan Amount" - TotalPrincipalRepayment + "Principal Repayment");
                        end;

                        CumInterest := (CumInterest + "Monthly Interest");
                        CumMonthlyRepayment := (CumMonthlyRepayment + "Monthly Repayment");
                        CumPrincipalRepayment := (CumPrincipalRepayment + "Principal Repayment");
                    end;

                    trigger OnPreDataItem()
                    begin
                        LastFieldNo := FieldNo("Client No.");
                        i := 0;
                        j := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    BankDetails := '';
                    if LoanCategory.Get("Loan Product") then
                        //BankDetails:=LoanCategory."Bank Account Details";

                        // IF "New Repayment Period" > 0 THEN BEGIN
                        // INST:="New Repayment Period" ;
                        // END ELSE BEGIN
                        INST := Installments;
                    //END;
                end;

                trigger OnPreDataItem()
                begin
                    CompanyInformation.Get();
                    CompanyInformation.CalcFields(CompanyInformation.Picture);
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        Duration: Integer;
        MemberLoan: Record "BO Applications";
        IssuedDate: Date;
        LoanCategory: Record "Loan Products";
        i: Integer;
        LoanBalance: Decimal;
        CumInterest: Decimal;
        CumMonthlyRepayment: Decimal;
        CumPrincipalRepayment: Decimal;
        j: Integer;
        LoanApp: Record Loans;
        GroupName: Text[70];
        TotalPrincipalRepayment: Decimal;
        Rate: Decimal;
        BankDetails: Text[250];
        Cust: Record "BO Applications";
        Intallments__Months_CaptionLbl: Label 'Intallments (Months)';
        Disbursment_DateCaptionLbl: Label 'Disbursment Date';
        Current_InterestCaptionLbl: Label 'Current Interest';
        Loan_AmountCaptionLbl: Label 'Loan Amount';
        Loan_ProductCaptionLbl: Label 'Loan Product';
        Loan_No_CaptionLbl: Label 'Loan No.';
        Account_No_CaptionLbl: Label 'Account No.';
        Monthly_RepaymentCaptionLbl: Label 'Monthly Repayment';
        InterestCaptionLbl: Label 'Interest';
        Principal_RepaymentCaptionLbl: Label 'Principal Repayment';
        Due_DateCaptionLbl: Label 'Due Date';
        Loan_BalanceCaptionLbl: Label 'Loan Balance';
        Loan_RepaymentCaptionLbl: Label 'Loan Repayment';
        TotalCaptionLbl: Label 'Total';
        EmployerName: Text;
        INST: Integer;
        CompanyInfo: Record "Company Information";
        CompanyInformation: Record "Company Information";
}

