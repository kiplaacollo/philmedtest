report 50432 "Loan repayment Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoanrepaymentSchedule.rdlc';

    dataset
    {
        dataitem("Staff Loans"; "Staff Loans")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan  No.", "Issue Date";
            column(A; layer1)
            {
            }
            column(B; layer2)
            {
            }
            column(C; layer3)
            {
            }
            column(D; layer4)
            {
            }
            column(E; layer5)
            {
            }
            column(F; layer6)
            {
            }
            column(G; layer7)
            {
            }
            column(H; layer8)
            {
            }
            column(IssueDate_StaffLoans; "Staff Loans"."Issue Date")
            {
            }
            column(Installments_StaffLoans; "Staff Loans".Installments)
            {
            }
            column(Interest_StaffLoans; "Staff Loans".Interest)
            {
            }
            column(LoanAmount_StaffLoans; "Staff Loans"."Loan Amount")
            {
            }
            column(LoanNo_StaffLoans; "Staff Loans"."Loan  No.")
            {
            }
            column(StaffNo_StaffLoans; "Staff Loans"."Staff No")
            {
            }
            column(StaffName_StaffLoans; "Staff Loans"."Staff Name")
            {
            }
            column(Loans__Repayment_Method_; "Repayment Method")
            {
            }
            column(Loans__Repayment_Method_Caption; FieldCaption("Repayment Method"))
            {
            }
            column(Loanproducttype_StaffLoans; "Staff Loans"."Loan product type")
            {
            }
            column(INST; INST)
            {
            }
            dataitem("Loan Repayment Schedule"; "Loan Repayment Schedule")
            {
                DataItemLink = "Loan No." = FIELD ("Loan  No.");
                DataItemTableView = SORTING ("Loan No.", "Member No.", "Group Code") WHERE ("Principal Repayment" = FILTER (> 0));
                PrintOnlyIfDetail = false;
                RequestFilterFields = "Member No.", "Loan Category";
                column(ROUND__Monthly_Repayment__10_____; Round("Loan Repayment Schedule"."Monthly Repayment", 1, '>'))
                {
                }
                column(FORMAT__Repayment_Date__0_4_; Format("Loan Repayment Schedule"."Repayment Date", 0, 4))
                {
                }
                column(ROUND__Principal_Repayment__10_____; Round("Loan Repayment Schedule"."Principal Repayment", 1, '>'))
                {
                }
                column(ROUND__Monthly_Interest__10_____; Round("Loan Repayment Schedule"."Monthly Interest", 1, '>'))
                {
                }
                column(LoanBalance; Round("Loan Repayment Schedule"."Loan Balance", 1, '>'))
                {
                }
                column(Loan_Repayment_Schedule__Repayment_Code_; "Repayment Code")
                {
                }
                column(ROUND__Monthly_Repayment__10______Control1000000043; "Loan Repayment Schedule"."Principal Repayment")
                {
                }
                column(ROUND__Principal_Repayment__10______Control1000000014; "Loan Repayment Schedule"."Loan Application No")
                {
                }
                column(ROUND__Monthly_Interest__10______Control1000000015; "Loan Repayment Schedule".Paid)
                {
                }
                column(Loan_Repayment_Schedule_Loan_No_; "Loan No.")
                {
                }
                column(Loan_Repayment_Schedule_Member_No_; "Member No.")
                {
                }
                column(Loan_Repayment_Schedule_Repayment_Date; "Group Code")
                {
                }
                column(RepaymentCode; "Loan Repayment Schedule"."Actual Installment Paid")
                {
                }
                column(COMPANYNAME; compyname)
                {
                }
                column(COMPANYPICTURE; compyinfo.Picture)
                {
                }
                column(i; i)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    i := i + 1;

                    TotalPrincipalRepayment := Round(TotalPrincipalRepayment + "Loan Repayment Schedule"."Principal Repayment");

                    if i = 1 then
                        LoanBalance := ("Loan Repayment Schedule"."Loan Amount")
                    else begin
                        LoanBalance := ("Loan Repayment Schedule"."Loan Amount" - TotalPrincipalRepayment +
                        "Loan Repayment Schedule"."Principal Repayment");
                    end;
                    if "Loan Repayment Schedule"."Loan Balance" < 0 then begin
                        "Loan Repayment Schedule"."Loan Balance" := 0;
                        Modify;
                    end;
                    CumInterest := Round(CumInterest + "Loan Repayment Schedule"."Monthly Interest");
                    CumMonthlyRepayment := Round(CumMonthlyRepayment + "Loan Repayment Schedule"."Principal Repayment");
                    CumPrincipalRepayment := Round(CumPrincipalRepayment + "Loan Repayment Schedule"."Principal Repayment");
                    layer1 := 1000;
                    layer2 := 1500;
                    layer3 := 2000;
                    layer4 := 2500;
                    layer5 := 3000;
                    layer6 := 3500;
                    layer7 := 3500;
                    layer8 := 5000;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                INST := "Staff Loans".Installments;
            end;
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
        i: Integer;
        LoanBalance: Decimal;
        CumInterest: Decimal;
        CumMonthlyRepayment: Decimal;
        CumPrincipalRepayment: Decimal;
        j: Integer;
        LoanApp: Record "Staff Loans";
        GroupName: Text[70];
        TotalPrincipalRepayment: Decimal;
        Rate: Decimal;
        BankDetails: Text[250];
        Cust: Record Customer;
        EmployerName: Text;
        INST: Integer;
        compyinfo: Record "Company Information";
        compyname: Text;
        pic: Text;
        layer1: Decimal;
        layer2: Decimal;
        layer3: Decimal;
        layer4: Decimal;
        layer5: Decimal;
        layer6: Decimal;
        layer7: Decimal;
        layer8: Decimal;
}

