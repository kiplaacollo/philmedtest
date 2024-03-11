table 50431 "Staff Loans"
{

    fields
    {
        field(1; "Loan  No."; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Loan  No." <> xRec."Loan  No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Issue Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Staff No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = pr_employees.st_no;

            trigger OnValidate()
            begin
                Employees.Reset;
                Employees.SetRange(Employees.st_no, "Staff No");
                if Employees.Find('-') then begin
                    "Staff Name" := Employees.Name;
                    Validate("Staff Name");
                end;
            end;
        }
        field(5; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                membledger: Record "Member Ledger Entry";
            begin
                UpdateMemberLedgerEntry;
                issued := true;
            end;
        }
        field(6; "Repayment Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //UpdateMemberLedgerEntry;
                //GenerateRepaymentSchedule;
            end;
        }
        field(7; "Loan product type"; Code[26])
        {
            TableRelation = "Loan Product Setup"."Product type";

            trigger OnValidate()
            begin
                loanSetup.Reset;
                loanSetup.SetRange(loanSetup."Product type", "Loan product type");
                if loanSetup.Find('-') then begin
                    Installments := loanSetup.Installments;
                    Interest := loanSetup."Interest Rate";
                    "Repayment Method" := loanSetup."Repayment Method";
                end;

                issued := true;
                UpdateMemberLedgerEntry;
                GenerateRepaymentSchedule(Installments, Interest);
            end;
        }
        field(8; Installments; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                loanSetup.Reset;
                loanSetup.SetRange(loanSetup."Product type", "Loan product type");
                if loanSetup.Find('-') then
                    UpdateMemberLedgerEntry;
                GenerateRepaymentSchedule(Installments, loanSetup."Interest Rate");
            end;
        }
        field(9; Interest; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                UpdateMemberLedgerEntry;
                GenerateRepaymentSchedule(Installments, Interest);
            end;
        }
        field(10; "Repayment Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Straight Line,Amortised,Reducing Balance,Constants';
            OptionMembers = "Straight Line",Amortised,"Reducing Balance",Constants;
        }
        field(11; Repayment; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Staff Name"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Total Loan paid"; Decimal)
        {
            CalcFormula = - Sum ("Member Ledger Entry".Amount WHERE ("Loan No" = FIELD ("Loan  No."),
                                                                   "Document No." = FILTER ('PAYROLL'),
                                                                   "Transaction Type" = FILTER (Repayment)));
            FieldClass = FlowField;
        }
        field(15; "Outstanding loan"; Decimal)
        {
            CalcFormula = Sum ("Member Ledger Entry".Amount WHERE ("Transaction Type" = FILTER (Loan | Repayment),
                                                                  "Loan No" = FIELD ("Loan  No."),
                                                                  "Customer No." = FIELD ("Staff No")));
            FieldClass = FlowField;
        }
        field(16; "Total int Paid"; Decimal)
        {
            CalcFormula = - Sum ("Member Ledger Entry".Amount WHERE ("Loan No" = FIELD ("Loan  No."),
                                                                   "Document No." = FILTER ('PAYROLL'),
                                                                   "Transaction Type" = FILTER ("Interest Paid")));
            FieldClass = FlowField;
        }
        field(17; issued; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Offset; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Confirm('Do you want to mark this loan as offset?', false) = true then begin
                    membledge.Reset;
                    membledge.SetRange(membledge."Loan No", "Loan  No.");
                    if membledge.Find('-') then begin
                        repeat
                            membledge.Delete;
                        until membledge.Next = 0;
                    end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Loan  No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Loan  No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Loan Nos", xRec."No. Series", 0D, "Loan  No.", "No. Series");
        end;
    end;

    var
        Employees: Record pr_employees;
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        loanSetup: Record "Loan Product Setup";
        LoansR: Record "Staff Loans";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Integer;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        ScheduleBal: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[25];
        WhichDay: Integer;
        membledge: Record "Member Ledger Entry";
        iEntryNo: Integer;
        PayrollPeriods: Record pr_periods;

    [Scope('Internal')]
    procedure UpdateMemberLedgerEntry()
    var
        membledger: Record "Member Ledger Entry";
    begin
        //Update Member Ledger Entry
        membledger.Reset;
        membledger.SetRange(membledger."Transaction Type", membledger."Transaction Type"::Loan);
        membledger.SetRange(membledger."Loan No", "Loan  No.");
        if membledger.Find('-') then
            membledger.Delete;

        PayrollPeriods.Reset;
        PayrollPeriods.SetRange(PayrollPeriods.Active, true);
        if PayrollPeriods.FindLast then
            membledge.Reset;
        if membledge.Find('+') then begin
            iEntryNo := membledge."Entry No.";
        end;
        membledge.Init;
        membledge."Entry No." := iEntryNo + 1;
        membledge."Loan No" := "Loan  No.";
        membledge.Amount := "Loan Amount";
        membledge.Amount := "Loan Amount";
        membledge."Document No." := "Loan  No.";
        membledge.Description := 'loan issued ' + Format("Loan  No.");
        membledge."Posting Date" := PayrollPeriods.end_date;
        membledge."Amount (LCY)" := "Loan Amount";
        membledge."Customer No." := "Staff No";
        membledge.Validate(membledge."Customer No.");
        membledge."Transaction Type" := membledge."Transaction Type"::Loan;
        membledge.Insert;
        //MESSAGE('inserted successfully %1 loanamou %2',"Loan  No.","Loan Amount");
    end;

    [Scope('Internal')]
    procedure GenerateRepaymentSchedule(var installments: Integer; var interest: Integer)
    begin
        //Generate Repayment Schedule
        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
        if LoansR.Find('-') then begin

            TestField("Issue Date");
            TestField("Repayment Start Date");

            RSchedule.Reset;
            RSchedule.SetRange(RSchedule."Loan No.", "Loan  No.");
            RSchedule.DeleteAll;

            LoanAmount := LoansR."Loan Amount";//+LoansR."Capitalized Charges";
            InterestRate := interest;//LoansR.Interest;
            RepayPeriod := installments;//LoansR.Installments;
                                        //InitialInstal:=LoansR.Installments+"Grace Period - Principle (M)";
            LBalance := LoansR."Loan Amount";//+LoansR."Capitalized Charges";
                                             //LNBalance:=LoansR."Outstanding Balance";
            RunDate := "Repayment Start Date";

            InstalNo := 0;

            RunDate := CalcDate('-1M', RunDate);
            repeat
                InstalNo := InstalNo + 1;
                ScheduleBal := LBalance;

                // /
                RunDate := CalcDate('1M', RunDate);

                //MESSAGE('%1 rundate ',RunDate);


                //*******************If Amortised****************************//
                if "Repayment Method" = "Repayment Method"::Amortised then begin
                    //TESTFIELD(Installments);
                    //TESTFIELD(Interest);
                    //TESTFIELD(Installments);

                    TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                    LInterest := Round(LBalance * (1 / 100));

                    LPrincipal := TotalMRepay - LInterest;
                end;



                if "Repayment Method" = "Repayment Method"::"Straight Line" then begin
                    TestField(Installments);
                    LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                    if ("Loan product type" = 'INST') or ("Loan product type" = 'MAZAO') then begin
                        LInterest := 0;
                    end else begin
                        LInterest := Round((InterestRate / 1200) * LoanAmount, 1, '>');
                    end;

                    Repayment := LPrincipal;//+LInterest;
                    Modify;

                end;


                if "Repayment Method" = "Repayment Method"::"Reducing Balance" then begin
                    TestField(Interest);
                    TestField(Installments);
                    LPrincipal := Round(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := Round((InterestRate / 12 / 100) * LBalance, 1, '>');
                end;

                if "Repayment Method" = "Repayment Method"::Constants then begin
                    TestField(Repayment);
                    if LBalance < Repayment then
                        LPrincipal := LBalance
                    else
                        LPrincipal := Repayment;
                    LInterest := interest;
                end;

                LInterest := Round(LBalance * (1 / 100));
                LBalance := LBalance - LPrincipal;
                //Grace Period
                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Loan No." := "Loan  No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                RSchedule."Member No." := "Staff No";
                RSchedule."Loan Category" := "Loan product type";
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2DWY(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;

        Commit;
    end;
}

