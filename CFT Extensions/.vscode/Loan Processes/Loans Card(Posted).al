page 50147 "Loans Card(Posted)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Loans;
    SourceTableView = where("Approval Status" = const(Approved), Posted = const(true));

    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                Editable = false;
                field("ED Loan Account No"; Rec."ED Loan Account No")
                {
                    Caption = 'Loan Number';
                    Visible = false;
                }
                field("Member Number"; Rec."Member Number")
                {
                    Importance = Promoted;
                    Caption = 'Client Code';
                }
                field("Full Name"; Rec."Full Name")
                {
                    Importance = Promoted;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Caption = 'MOE Number';
                }
                field("Mobile Number"; Rec."Mobile Number")
                {

                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    Importance = Additional;
                }
                field("RM Code"; Rec."RM Code")
                {

                }
                field("RM Name"; Rec."RM Name")
                {
                    Editable = false;
                }
            }
            group("Loan Information")
            {
                Editable = false;
                field("Loan Product"; Rec."Loan Product")
                {
                    ShowMandatory = true;
                    Importance = Promoted;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {

                }
                field(Installments; Rec.Installments)
                {

                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {

                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {

                }
                field("Deposits Factor"; Rec."Deposits Factor")
                {
                    Visible = false;
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    Importance = Promoted;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Importance = Promoted;
                }
                field("Total Offset Amount"; Rec."Total Offset Amount")
                {

                }
                field("Total Upfront Deductions"; Rec."Total Upfront Deductions")
                {

                }
                field("Total Collateral Amount"; Rec."Total Collateral Amount")
                {
                    Importance = Additional;
                }
            }

            group("Guarantor Details")
            {
                part(GuarantorDetails; "Guarantors(New)")
                {
                    SubPageLink = "Loan Number" = field("Loan Number");
                }
            }
            group("Loans Collateral")
            {
                part(loanscollateral; "Loan Collateral Security")
                {
                    SubPageLink = "Loan No" = field("Loan Number");
                }
            }
            group("Credit Ratios")
            {
                Editable = false;
                field("Fee Collection Rate(%)"; Rec."Fee Collection Rate(%)")
                {

                }
                field("Maximum Possible DBR(%)"; Rec."Maximum Possible DBR(%)")
                {

                }
                field("Profitability Margin"; Rec."Profitability Margin")
                {

                }
                field("Appraised Obligations Monthly"; Rec."Appraised Obligations Monthly")
                {

                }
            }
            group("Bank Details")
            {
                Editable = false;
                group("Main Bank")
                {
                    field("Bank Code"; Rec."Bank Code")
                    {

                    }
                    field("Bank Name"; Rec."Bank Name")
                    {

                    }
                    field("Bank Branch"; Rec."Bank Branch")
                    {

                    }
                    field("Bank Branch Name"; Rec."Bank Branch Name")
                    {

                    }
                    field("Bank Account No."; Rec."Bank Account No.")
                    {

                    }
                    field("Swift Code"; Rec."Swift Code")
                    {

                    }
                }
                group("Alternative Bank")
                {
                    field("Bank Code 2"; Rec."Bank Code 2")
                    {

                    }
                    field("Bank Name 2"; Rec."Bank Name 2")
                    {

                    }
                    field("Bank Branch 2"; Rec."Bank Branch 2")
                    {

                    }
                    field("Bank Branch Name 2"; Rec."Bank Branch Name 2")
                    {

                    }
                    field("Bank Account No. 2"; Rec."Bank Account No. 2")
                    {

                    }
                    field("Swift Code 2"; Rec."Swift Code 2")
                    {

                    }
                }
                group("ABB Bank Details")
                {
                    field("ABB Bank1 Details"; Rec."ABB Bank1 Details")
                    {

                    }
                    field("ABB Bank2 Details"; Rec."ABB Bank2 Details")
                    {

                    }
                    field("ABB Bank3 Details"; Rec."ABB Bank3 Details")
                    {

                    }
                }
            }
            group("Audit Information")
            {
                Editable = false;
                field("Application Date"; Rec."Application Date")
                {

                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {

                }
                field("Guarantors Notified"; Rec."Guarantors Notified")
                {

                }
                field("Created By"; Rec."Created By")
                {

                }
                field("Approval Status"; Rec."Approval Status")
                {

                }
                field("End Use Status"; Rec."End Use Status")
                {
                    StyleExpr = ColorVar;
                }
            }
            group("Disbursement Information")
            {
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {

                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {

                }
                field("Repayment Debut Date"; Rec."Repayment Debut Date")
                {

                }
                field("Gross Disbursed Amount"; Rec."Gross Disbursed Amount")
                {

                }
                field("Total Monthly Repayment"; Rec."Total Monthly Repayment")
                {
                    Editable = false;
                }
                field("BO Group"; Rec."BO Group")
                {

                }
            }
        }
        area(FactBoxes)
        {
            part(AppraisalStatistics; "Appraisal Statistics")
            {
                SubPageLink = "Loan Number" = field("Loan Number");
            }
            part(CustomerStatistics; "BO Statistics")
            {
                SubPageLink = "No." = field("Member Number");
            }
        }
    }

    actions
    {
        area(Processing)
        {


            action("Repayment Schedule")
            {
                Image = TaskList;

                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    clearRepaymentSchedule();
                    //Error('Loan Number Is %1', rec."Loan Number");
                    FnGenerateRepaymentSchedule(rec."Loan Number", false);
                    Message('Loan Repayment Schedule entries generated successfully.');
                end;
            }
            action("Repayment Schedule Report")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    loans.Reset();
                    loans.SetRange(loans."Loan Number", Rec."Loan Number");
                    if loans.FindFirst() then begin
                        Report.RunModal(Report::"Loans Repayment Schedule", true, false, loans);
                    end;
                end;
            }


        }
    }

    procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50]; Rescheduled: Boolean)
    begin
        //Start
        loanRec.RESET;
        loanRec.SETRANGE(loanRec."Loan Number", LoanNumber);
        IF loanRec.FIND('-') THEN BEGIN


            QCounter := 0;
            QCounter := 3;
            GrPrinciple := 0;
            GrInterest := 0;
            InitialGraceInt := 0;

            loanRec.TESTFIELD(loanRec."Disbursement Date");
            loanRec.TESTFIELD(loanRec."Repayment Debut Date");

            IF Rescheduled = FALSE THEN BEGIN
                RSchedule.RESET;
                RSchedule.SETRANGE(RSchedule."Loan No.", loanRec."Loan Number");
                RSchedule.DELETEALL;

                LoanAmount := loanRec."Approved Amount";
                InterestRate := loanRec."Interest Rate";
                RepayPeriod := loanRec.Installments;
                InitialInstal := loanRec.Installments;
                LBalance := loanRec."Approved Amount";
                RunDate := loanRec."Repayment Debut Date";
                LoanRec.TESTFIELD(loanRec."Interest Rate");
                LoanRec.TESTFIELD(loanRec.Installments);
                Product := loanRec."Loan Product";
            END;


            // IF Rescheduled = TRUE THEN
            // BEGIN
            //     RSchedule.RESET;
            //     RSchedule.SETRANGE(RSchedule."Loan No.",loanRec."Loan Number");
            //     RSchedule.DELETEALL;

            //   RSchedule.RESET;
            //   RSchedule.SETRANGE("Loan No", LoanNumber);
            //   IF ObjReschedule.FIND('-') THEN
            //     BEGIN
            //       LoanAmount:=loanRec."Loan Amount";
            //       InterestRate:=ObjReschedule."Interest Rate";
            //       RepayPeriod:=ObjReschedule."No of Installments";
            //       InitialInstal:=ObjReschedule."No of Installments";
            //       LBalance:=ObjReschedule."Loan Amount";
            //       RunDate:=ObjReschedule."Reschedule Start Date";
            //       Product := ObjReschedule."Loan Product";
            //     END;
            // END;

            InstalNo := 0;

            //Repayment Frequency
            IF LoanRec."Repayment Frequency" = LoanRec."Repayment Frequency"::Daily THEN
                RunDate := CALCDATE('-1D', RunDate)
            ELSE
                IF LoanRec."Repayment Frequency" = LoanRec."Repayment Frequency"::Weekly THEN
                    RunDate := CALCDATE('-1W', RunDate)
                ELSE
                    IF LoanRec."Repayment Frequency" = LoanRec."Repayment Frequency"::Monthly THEN
                        RunDate := CALCDATE('-1M', RunDate)
                    ELSE
                        IF LoanRec."Repayment Frequency" = LoanRec."Repayment Frequency"::Quarterly THEN
                            RunDate := CALCDATE('-1Q', RunDate);
            //Repayment Frequency


            REPEAT
                InstalNo := InstalNo + 1;
                //Repayment Frequency
                IF LoanRec."Repayment Frequency" = LoanRec."Repayment Frequency"::Daily THEN
                    RunDate := CALCDATE('1D', RunDate)
                ELSE
                    IF LoanRec."Repayment Frequency" = LoanRec."Repayment Frequency"::Weekly THEN
                        RunDate := CALCDATE('1W', RunDate)
                    ELSE
                        IF LoanRec."Repayment Frequency" = LoanRec."Repayment Frequency"::Monthly THEN
                            RunDate := CALCDATE('1M', RunDate)
                        ELSE
                            IF LoanRec."Repayment Frequency" = LoanRec."Repayment Frequency"::Quarterly THEN
                                RunDate := CALCDATE('1Q', RunDate);

                IF LoanRec."Interest Calculation Method" = LoanRec."Interest Calculation Method"::Amortized THEN BEGIN
                    LoanRec.TESTFIELD(LoanRec."Interest Rate");
                    LoanRec.TESTFIELD(LoanRec.Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - POWER((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;
                END;

                IF LoanRec."Interest Calculation Method" = LoanRec."Interest Calculation Method"::"Straight Line" THEN BEGIN
                    LoanRec.TESTFIELD(LoanRec."Interest Rate");
                    LoanRec.TESTFIELD(LoanRec.Installments);
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                END;

                IF LoanRec."Interest Calculation Method" = LoanRec."Interest Calculation Method"::"Reducing Balance" THEN BEGIN
                    LoanRec.TESTFIELD(LoanRec."Interest Rate");
                    LoanRec.TESTFIELD(LoanRec.Installments);
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LBalance;
                END;

                IF LoanRec."Interest Calculation Method" = LoanRec."Interest Calculation Method"::Discounted THEN BEGIN
                    LoanRec.TESTFIELD(LoanRec."Interest Rate");
                    LoanRec.TESTFIELD(LoanRec.Installments);
                    LPrincipal := LoanAmount;
                    LInterest := (InterestRate / 12 / 100) * LBalance;
                    LoanAmount := LPrincipal + LInterest;
                END;

                //Grace Period
                IF GrPrinciple > 0 THEN BEGIN
                    LPrincipal := 0
                END ELSE BEGIN
                    LBalance := LBalance - LPrincipal;
                END;

                IF GrInterest > 0 THEN
                    LInterest := 0;

                //GrPrinciple:=GrPrinciple-1;
                //GrInterest:=GrInterest-1;
                EVALUATE(RepayCode, FORMAT(InstalNo));

                RSchedule.INIT;
                //RSchedule."Repayment Code":=RepayCode;
                RSchedule."Interest Rate" := InterestRate;
                RSchedule."Loan No." := LoanRec."Loan Number";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := RunDate;
                RSchedule."Client No." := LoanRec."Member Number";
                RSchedule."Loan Category" := loanRec."Loan Product";
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := LBalance;
                RSchedule.INSERT;
                WhichDay := DATE2DWY(RSchedule."Repayment Date", 1);
            UNTIL LBalance < 1;
            COMMIT;
        END;
        //End
    end;

    procedure clearRepaymentSchedule()
    begin
        RSchedule.Reset();
        RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan Number");
        if RSchedule.FindSet() then begin
            RSchedule.DeleteAll();
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."End Use Status" = Rec."End Use Status"::Open then
            ColorVar := 'Unfavorable'
        else
            if Rec."End Use Status" = Rec."End Use Status"::Pending then
                ColorVar := 'Ambiguous'
            else
                ColorVar := 'Favorable';
    end;

    var
        myInt: Integer;
        ColorVar: Text;

        RSchedule: Record 50150;
        loanRec: Record Loans;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        Product: Code[20];
        InstalNo: Integer;
        RepayCode: Integer;
        LInterest: Decimal;
        WhichDay: Integer;
        LPrincipal: Decimal;
        GrInterest: Decimal;
        QCounter: Integer;
        GrPrinciple: Decimal;
        InitialGraceInt: Integer;
        TotalMRepay: Decimal;
        loans: Record Loans;
}