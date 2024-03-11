table 50140 Loans
{
    DrillDownPageID = 50209;
    LookupPageID = 50209;

    fields
    {
        field(1; "Loan Number"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "Loan Number" <> xRec."Loan Number" then begin
                    ObjGeneralSetup.GET;
                    NoSeriesMgt.TestManual(ObjGeneralSetup."BO Loan Nos");
                    //"No. Series" := '';
                end;
            end;
        }
        field(2; "Member Number"; Code[20])
        {
            Caption = 'Client Code';
            DataClassification = ToBeClassified;
            Description = 'Loaded form BO Applications - Tracking Individual Account Number for Tracking Member';
            TableRelation = Table50121.Field18 WHERE (Field23 = FILTER ("1"));

            trigger OnValidate()
            begin
                ObjBOAccount.RESET;
                ObjBOAccount.SETRANGE("Member Number", "Member Number");
                if ObjBOAccount.FIND('-') then begin
                    ObjBOAccount.CALCFIELDS("Deposit Contribution Balance", "Share Capital Balance");
                    "Full Name" := ObjBOAccount."Full Name";
                    "ID Number" := ObjBOAccount."MOEST Registration No";
                    "Mobile Number" := ObjBOAccount."Mobile Number";
                    "Employer Code" := ObjBOAccount."Employer Code";
                    "Payroll Number" := ObjBOAccount."Payroll Number";
                    "Deposits Balance" := ObjBOAccount."Deposit Contribution Balance";
                    "Share Capital Balance" := ObjBOAccount."Share Capital Balance";
                    "Application No" := ObjBOAccount.No;
                    "Branch Code" := ObjBOAccount."Branch Code";
                    "Bank Code" := ObjBOAccount."Bank Code";
                    "Bank Name" := ObjBOAccount."Bank Name";
                    "Bank Branch" := ObjBOAccount."Bank Branch";
                    "Bank Branch Name" := ObjBOAccount."Bank Branch Name";
                    "Bank Account No." := ObjBOAccount."Bank Account No.";
                    "Swift Code" := ObjBOAccount."Swift Code";
                    "Bank Code 2" := ObjBOAccount."Bank Code 2";
                    "Bank Name 2" := ObjBOAccount."Bank Name 2";
                    "Bank Branch 2" := ObjBOAccount."Bank Branch 2";
                    "Bank Branch Name 2" := ObjBOAccount."Bank Branch Name 2";
                    "Bank Account No. 2" := ObjBOAccount."Bank Account No. 2";
                    "Swift Code2" := ObjBOAccount."Swift Code 2";
                    Modify;
                end;

                FnClearLoanOffsetDetails();

                FnClearDocumentAttachments("Member Number");
                FnUpdateAttachments("Member Number");

                FnClearRecordFields();
                FnClearRelatedTables();
                FnPoupalatePayslip();
                FnRunUpdateSchoolRevenue_Expenditure();
                CFactory.FnValidateMember("Member Number");
            end;
        }
        field(3; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(4; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Loaded form BO Applications - National ID Number';
            Editable = false;
        }
        field(5; "Mobile Number"; Code[12])
        {
            DataClassification = ToBeClassified;
            Description = 'Loaded form BO Applications - Used for Sending SMS Alerts to Member';
            Editable = false;
        }
        field(6; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Loaded form BO Applications - Employer Code helps tracking Loans from a specific Employer.This is also use during generation of Checkoff Advice and Checkoff Processing';
            Editable = false;
        }
        field(7; "Payroll Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Outstanding Loan Balances as at Date of Taking Loan. Normal field that can be updated by either the Provisioning report or the Top 20 OLB Report and can be used as a flowfield in other tables.';
            Editable = false;
        }
        field(9; "Deposits Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Deposit Contribution as at time of Taking Loan';
            Editable = false;

            trigger OnValidate()
            begin
                "Max Qualification By Deposits" := "Deposits Factor" * "Deposits Balance";
            end;
        }
        field(10; "Share Capital Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Share Capital as at time of Taking Loan';
            Editable = false;
        }
        field(11; "Loan Product"; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Loan Product code being Applied';
            TableRelation = Table50107.Field1;

            trigger OnValidate()
            begin
                Clear("Interest rate");
                Clear(Installments);
                Clear("Recovery Mode");
                Clear("Interest Calculation Method");
                Clear("Repayment Frequency");

                ObjLoanProducts.RESET;
                ObjLoanProducts.SETRANGE(Code, "Loan Product");
                if ObjLoanProducts.FIND('-') then begin
                    "Interest rate" := ObjLoanProducts."Max Interest Rate";
                    Installments := ObjLoanProducts."Max Installments";
                    "Recovery Mode" := ObjLoanProducts."Recovery Mode";
                    "Interest Calculation Method" := ObjLoanProducts."Interest Calculation Method";
                    "Repayment Frequency" := ObjLoanProducts."Repayment Frequency";
                    "Deposits Factor" := ObjLoanProducts."Deposit Factor";
                    Modify;
                end
            end;
        }
        field(12; "Interest rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Interest Rate for the Product';

            trigger OnValidate()
            begin
                ObjLoanProducts.GET("Loan Product");
                if "Interest rate" < ObjLoanProducts."Min Interest Rate" then
                    Error('The Interest Rate for %1 can not be less than %2', "Loan Product", ObjLoanProducts."Min Interest Rate");

                if "Interest rate" > ObjLoanProducts."Max Interest Rate" then
                    Error('The Interest Rate for %1 can not be more than %2', "Loan Product", ObjLoanProducts."Max Interest Rate");
            end;
        }
        field(13; Installments; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Installments applied for the Loan Product';

            trigger OnValidate()
            begin
                if ObjLoanProducts.GET("Loan Product") then begin
                    if Installments > ObjLoanProducts."Max Installments" then
                        Error(txtInstallmentsError, ObjLoanProducts."Max Installments");
                end;
            end;
        }
        field(14; "Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Amount Requested by the Applicant';

            trigger OnValidate()
            begin
                if ObjLoanProducts.GET("Loan Product") then begin
                    if "Applied Amount" > ObjLoanProducts."Max Loan Amount" then
                        Error(txtLoanAmountError, ObjLoanProducts."Max Loan Amount");
                    if "Applied Amount" < ObjLoanProducts."Min Loan Amount" then
                        Error(txtLoanMinAmountError, ObjLoanProducts."Min Loan Amount");
                end;
            end;
        }
        field(15; "System Recommended Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Recommended amount by the Appraisal process';
            Editable = false;
        }
        field(16; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Approved Amount by the System / Final Approver';
        }
        field(17; "Gross Disbursed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Amount to be disbursed to Member Bank';
            Editable = true;
        }
        field(18; "Total Upfront Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'This includes all the charges due to the Loan without Total Offset Amount';
            Editable = false;
        }
        field(19; "Total Offset Amount"; Decimal)
        {
            CalcFormula = Sum (Table50164.Field12 WHERE (Field1 = FIELD ("Loan Number")));
            Description = 'Total amount from the Loans begin offset. The Amount includes the Outstanding Loan,Oustanding Interest,Commission on Loan Offset';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Net Disbursed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Net Amount Disbursed to Member Bank.This amount is less the Total Diductions due to the Loan';
            Editable = false;
        }
        field(21; "Total Guarantors"; Integer)
        {
            CalcFormula = Count (Table50141 WHERE (Field11 = CONST (false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Total Guaranteed Amount"; Decimal)
        {
            CalcFormula = Sum (Table50141.Field9 WHERE (Field2 = FIELD ("Loan Number")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Total Collateral Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'The Date the Loan is applied';
            Editable = true;
        }
        field(25; "Appraisal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'The Final Appraisal Date';
            Editable = false;
        }
        field(26; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'The Date Loan is disbursed to Ledgers';

            trigger OnValidate()
            begin
                "Month Code" := Format("Disbursement Date", 0, '<Month Text,3> <Year4>');
                Modify;
            end;
        }
        field(28; "Repayment Debut Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'The First formal Date for the Loan Repayment';
        }
        field(29; "Expected End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'The Last formal Date for the Loan Repayment';
            Editable = false;
        }
        field(30; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(31; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'The user id for the user who initially captures the Loan product';
            Editable = false;
        }
        field(32; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'The Final Approver for the Loan approval process';
            Editable = false;
        }
        field(33; "Disbursed By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'The user id for the posting user';
        }
        field(34; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Open,Pending Approval,Approved';
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;

            trigger OnValidate()
            begin
                if "Approval Status" = "Approval Status"::Approved then begin
                    "Approval Date" := Today;
                    "Principle Repayment" := "Approved Amount" / Installments;
                    "Loan Status" := "Loan Status"::Approved;
                    ObjBOAccount.RESET;
                    ObjBOAccount.SETRANGE(ObjBOAccount."Member Number", "Member Number");
                    if ObjBOAccount.FIND('-') then begin
                        ObjBOAccount."Approval Status" := ObjBOAccount."Approval Status"::"2";
                        ObjBOAccount.MODIFY;
                    end;

                    if "Credit Life Rate" <> 0 then begin
                        "Credit Life Fees" := Round((("Credit Life Rate") / 100 * (Round((Installments / 12), 1, '>')) * "Approved Amount"), 0.01, '=');
                        "Loan Processing Fees" := FnGetProcessingFees();
                        //FnCalcLoanCharges("Approved Amount");
                        Modify;
                    end;
                end else
                    if "Approval Status" = "Approval Status"::Rejected then begin
                        ObjBOAccount.RESET;
                        ObjBOAccount.SETRANGE(ObjBOAccount."Member Number", "Member Number");
                        if ObjBOAccount.FIND('-') then begin
                            ObjBOAccount."Approval Status" := ObjBOAccount."Approval Status"::"3";
                            ObjBOAccount."Rejected Loan" := "Loan Number";
                            ObjBOAccount.MODIFY;
                        end;
                    end;
            end;
        }
        field(35; "Loan Status"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'New,Appraisal,Approved,Disbursed';
            Editable = true;
            OptionCaption = 'New,Appraisal,Approved,Disbursed,Rejected';
            OptionMembers = New,Appraisal,Approved,Disbursed,Rejected;
        }
        field(36; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Marks the Loan as Reversed';
            Editable = true;
        }
        field(37; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'The Date the Loan Reversal Happened';
            Editable = false;
        }
        field(38; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'The user id that is involved in making the Loan Reversal';
            Editable = false;
        }
        field(39; Cleared; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Marks the Loan after it''s cleared.To reverse this status, Approval process must be followed';
            Editable = false;
        }
        field(40; "Date Cleared"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Marks the date a Loan is cleared';
            Editable = false;
        }
        field(41; "Cleared By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'The user id for the user who captures the final repayment for the Loan';
            Editable = false;
        }
        field(42; "Clearing Process"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'The Process that is used to Make the Loan final Repayment';
            Editable = false;
            OptionCaption = ' ,Check Off,Receipt,Transfer,Offset,Reversal';
            OptionMembers = " ","Check Off",Receipt,Transfer,Offset,Reversal;
        }
        field(43; "Recovery Mode"; Option)
        {
            DataClassification = ToBeClassified;
            Description = ' ,Check Off,Salary';
            OptionCaption = ' ,Check Off,Salary';
            OptionMembers = " ","Check Off",Salary;
        }
        field(44; "Guarantors Notified"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Checkbox for Tracking if Guarantors for a Loan have been Notified. Notification via SMS or Email Address';
            Editable = false;
        }
        field(45; "Schedule Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'The check for the generation of a Schedule. A Loan cannot be posted without if this field is not marked True';
            Editable = false;
        }
        field(46; "Mode of Disbursement"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Full,Tranches';
            OptionMembers = " ",Full,Tranches;

            trigger OnValidate()
            begin
                if "Mode of Disbursement" = "Mode of Disbursement"::Full then
                    "Gross Disbursed Amount" := "Approved Amount"
                else
                    "Gross Disbursed Amount" := 0;
            end;
        }
        field(47; "Principle Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Tracks the Monthly Repayment';
            Editable = false;
        }
        field(48; "Outstanding Penalty"; Decimal)
        {
            CalcFormula = Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("9" | "8"),
                                                       Field4 = FIELD ("Date Filter")));
            Description = 'Tracks the Penaly charged and is yet to be paid';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Total Monthly Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Tracks the Total Monthly Repayment for Amortized Loans';
        }
        field(50; "Outstanding Loan"; Decimal)
        {
            CalcFormula = Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("4" | "5" | "13"),
                                                       Field4 = FIELD ("Date Filter")));
            Description = 'Tracks the outstanding Principal balance of a Loan as per the Date Filter (If Filtering date is not passed, the Default is TODAY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Outstanding Interest"; Decimal)
        {
            CalcFormula = Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("6" | "7"),
                                                       Field4 = FIELD ("Date Filter")));
            Description = 'Tracks the outstanding Accrued Interest balance of a Loan as per the Date Filter (If Filtering date is not passed, the Default is TODAY). Interest Accrued - Interest Paid';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "Expected Outstanding Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Track the expected Principal Balance as per the Loan Schedule';
            Editable = false;
        }
        field(53; "Loan Category"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            Editable = false;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(54; "Loan Purpose"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Table50167.Field2;
        }
        field(55; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Basic Pay"; Decimal)
        {
            CalcFormula = Sum (Table50142.Field6 WHERE (Field2 = FIELD ("Loan Number"),
                                                       Field5 = CONST (1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Total Allowance"; Decimal)
        {
            CalcFormula = Sum (Table50142.Field6 WHERE (Field2 = FIELD ("Loan Number"),
                                                       Field5 = CONST (2)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(58; "Gross Salary"; Decimal)
        {
            CalcFormula = Sum (Table50142.Field6 WHERE (Field2 = FIELD ("Loan Number"),
                                                       Field5 = FILTER ("1" | "2")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "1/3 Basic"; Decimal)
        {
            Editable = false;
        }
        field(60; "Statutory Deductions"; Decimal)
        {
            CalcFormula = Sum (Table50142.Field6 WHERE (Field2 = FIELD ("Loan Number"),
                                                       Field5 = CONST (3)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Other Deductions"; Decimal)
        {
            CalcFormula = Sum (Table50142.Field6 WHERE (Field2 = FIELD ("Loan Number"),
                                                       Field5 = CONST (4)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Provident Fund"; Decimal)
        {
            CalcFormula = Sum (Table50142.Field6 WHERE (Field2 = FIELD ("Loan Number"),
                                                       Field5 = CONST (5)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Taxable Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(64; PAYE; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(65; Relief; Decimal)
        {
            CalcFormula = Sum (Table50142.Field6 WHERE (Field2 = FIELD ("Loan Number"),
                                                       Field5 = CONST (6)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Net Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                CFactory: Codeunit "ESD Text File Generator";
                ObjCollectionSummary: Record Table50171;
            begin
                /*CALCFIELDS("Gross Salary","Statutory Deductions","Other Deductions",Relief,"Provident Fund","Total Guaranteed Amount");
                "Taxable Pay":="Gross Salary"-"Provident Fund";
                "1/3 Basic":=1/3*"Basic Pay";
                PAYE:=0;
                "Net Pay":=0;
                "Gross Available Amount":=0;
                "Net Available Amount":=0;
                IF "Taxable Pay" > 1408 THEN
                BEGIN
                PAYE:=CFactory.FnCalculatePaye("Taxable Pay")-Relief;
                "Net Pay":="Gross Salary"-("Statutory Deductions"+"Other Deductions"+PAYE);
                "Gross Available Amount":="Net Pay"-"1/3 Basic";
                "Net Available Amount":="Gross Available Amount"; //TODO Less Release by Offset
                END;
                QaulifyBySalary();
                "Max Qualification By Guarantor":="Total Guaranteed Amount";
                "System Recommended Amount":=FnRecommendedAmount("Applied Amount","Deposits Balance","Total Guaranteed Amount","Max Qualification By Salary");
                "Approved Amount":="System Recommended Amount";
                "Appraisal Date":=TODAY;*/

                VarTotalAnnualFeeIncome := 0;
                VarGrossAnnualFeeIncome := 0;
                VarTotalExpenses := 0;
                VarAnnualNetFeeIncome := 0;
                VarMonthlyNetFeeIncome := 0;
                VarMaximuProfitability := 0;
                VarMaximumMonthlyProfitability := 0;
                VarNetAppraisedMonthlyIncome := 0;
                VarMaximumEMI := 0;
                VarMaximumEligible := 0;
                VarQualifyingLoanAmount := 0;
                VarABBTotalBank1 := 0;
                VarABBTotalBank2 := 0;
                VarABBTotalBank3 := 0;
                VarTotalAverage := 0;
                VarABBEMIAmount := 0;
                VarMaximumABBEligible := 0;
                VarMaximumABBQualification := 0;

                ObjLoanRevenueDetails.RESET;
                ObjLoanRevenueDetails.SETRANGE(ObjLoanRevenueDetails."Loan No", "Loan Number");
                if ObjLoanRevenueDetails.FINDSET then begin
                    ObjLoanRevenueDetails.CALCSUMS(ObjLoanRevenueDetails."Total Income");
                    VarTotalAnnualFeeIncome := ObjLoanRevenueDetails."Total Income";
                    if VarTotalAnnualFeeIncome <> 0 then
                        "Total Annual Fee Income" := VarTotalAnnualFeeIncome
                    else
                        "Total Annual Fee Income" := 0;
                end;

                VarGrossAnnualFeeIncome := Round(VarTotalAnnualFeeIncome * "Fee Collection Rate(%)" / 100, 0.01, '=');
                if VarGrossAnnualFeeIncome <> 0 then
                    "Gross Annual Fee Income" := VarGrossAnnualFeeIncome;


                ObjLoanExpensesDetails.RESET;
                ObjLoanExpensesDetails.SETRANGE(ObjLoanExpensesDetails."Loan No", "Loan Number");
                if ObjLoanExpensesDetails.FINDSET then begin
                    ObjLoanExpensesDetails.CALCSUMS(ObjLoanExpensesDetails."Annual Expense");
                    VarTotalExpenses := ObjLoanExpensesDetails."Annual Expense";
                    if VarTotalExpenses <> 0 then
                        "Total School Expenses" := VarTotalExpenses
                    else
                        "Total School Expenses" := 0;
                end;

                ObjLoanGeneralSetup.Get;
                VarAnnualNetFeeIncome := VarGrossAnnualFeeIncome - "Total School Expenses";

                if VarAnnualNetFeeIncome <> 0 then
                    "Annual Net Fee Income" := VarAnnualNetFeeIncome
                else
                    "Annual Net Fee Income" := 0;

                VarMonthlyNetFeeIncome := VarAnnualNetFeeIncome / 12;
                if VarMonthlyNetFeeIncome <> 0 then
                    "Monthly Net Fee Income" := VarMonthlyNetFeeIncome else
                    "Monthly Net Fee Income" := 0;

                VarMaximuProfitability := Round((ObjLoanGeneralSetup."Maximum Profitability Margin" / 100) * VarGrossAnnualFeeIncome, 0.01, '=');
                if VarMaximuProfitability <> 0 then
                    "Profitability Magin" := VarMaximuProfitability
                else
                    "Profitability Magin" := 0;

                VarMaximumMonthlyProfitability := Round(VarMaximuProfitability / 12, 0.01, '=');
                if VarMaximumMonthlyProfitability <> 0 then
                    "Monthly Maximum Profitability" := VarMaximumMonthlyProfitability
                else
                    "Monthly Maximum Profitability" := 0;

                if VarMonthlyNetFeeIncome < VarMaximumMonthlyProfitability then begin
                    VarNetAppraisedMonthlyIncome := VarMonthlyNetFeeIncome
                end else
                    if VarMaximumMonthlyProfitability < VarMonthlyNetFeeIncome then begin
                        VarNetAppraisedMonthlyIncome := VarMaximumMonthlyProfitability
                    end;

                if VarNetAppraisedMonthlyIncome <> 0 then
                    "Net Appraised Monthly Income" := VarNetAppraisedMonthlyIncome
                else
                    "Net Appraised Monthly Income" := 0;

                VarMaximumEMI := Round((("Maximum Possible DBR(%)" / 100) * VarNetAppraisedMonthlyIncome) - "Appraised Obligations Monthly", 0.01, '=');
                if VarMaximumEMI <> 0 then
                    "Max EMI" := VarMaximumEMI
                else
                    "Max EMI" := 0;

                VarMaximumEligible := VarMaximumEMI;
                if "Interest Calculation Method" = "Interest Calculation Method"::Amortized then
                    VarQualifyingLoanAmount := Round(VarMaximumEligible * ((Power((1 + "Interest rate" / 1200), Installments) - 1) / (("Interest rate" / 1200) * (Power((1 + "Interest rate" / 1200), Installments)))), 1, '=');
                if VarQualifyingLoanAmount <> 0 then
                    "Qualifying Amount" := VarQualifyingLoanAmount
                else
                    "Qualifying Amount" := 0;


                ObjABB1.RESET;
                ObjABB1.SETRANGE(ObjABB1."Loan No", "Loan Number");
                if ObjABB1.FINDSET then begin
                    ObjABB1.CALCSUMS(ObjABB1.Average);
                    VarABBTotalBank1 := ObjABB1.Average;
                    if VarABBTotalBank1 <> 0 then
                        "ABB Total Bank 1" := VarABBTotalBank1
                    else
                        "ABB Total Bank 1" := 0;
                end;

                ObjABB2.RESET;
                ObjABB2.SETRANGE(ObjABB2."Loan No", "Loan Number");
                if ObjABB2.FINDSET then begin
                    ObjABB2.CALCSUMS(ObjABB2.Average);
                    VarABBTotalBank2 := ObjABB2.Average;
                    if VarABBTotalBank2 <> 0 then
                        "ABB Total Bank 2" := VarABBTotalBank2
                    else
                        "ABB Total Bank 2" := 0;
                end;

                ObjABB3.RESET;
                ObjABB3.SETRANGE(ObjABB3."Loan No", "Loan Number");
                if ObjABB3.FINDSET then begin
                    ObjABB3.CALCSUMS(ObjABB3.Average);
                    VarABBTotalBank3 := ObjABB3.Average;
                    if VarABBTotalBank3 <> 0 then
                        "ABB Total Bank 3" := VarABBTotalBank3
                    else
                        "ABB Total Bank 3" := 0;
                end;
                BankCount := 0;
                if (VarABBTotalBank1 > 0) then
                    BankCount := BankCount + 1;
                if (VarABBTotalBank2 > 0) then
                    BankCount := BankCount + 1;
                if (VarABBTotalBank3 > 0) then
                    BankCount := BankCount + 1;

                if BankCount > 0 then
                    VarTotalAverage := (VarABBTotalBank1 + VarABBTotalBank2 + VarABBTotalBank3) / BankCount;

                VarTotalAverage := VarTotalAverage / 12;
                VarABBEMIAmount := Round((VarTotalAverage - (ObjLoanGeneralSetup."ABB EMI Ratio(%)" / 100) * VarTotalAverage) - "Appraised Obligations Monthly", 0.01, '=');
                VarMaximumABBEligible := VarABBEMIAmount;
                if "Interest Calculation Method" = "Interest Calculation Method"::Amortized then
                    VarMaximumABBQualification := Round(VarMaximumABBEligible * ((Power((1 + "Interest rate" / 1200), Installments) - 1) / (("Interest rate" / 1200) * (Power((1 + "Interest rate" / 1200), Installments)))), 1, '=');

                //-------Cash Collection Model;
                ObjCollectionSummary.RESET;
                ObjCollectionSummary.SETRANGE(ObjCollectionSummary."Loan No", "Loan Number");
                if ObjCollectionSummary.FINDSET then begin
                    ObjCollectionSummary.CALCSUMS(ObjCollectionSummary."First Term", ObjCollectionSummary."Second Term", ObjCollectionSummary."Third Term");
                    "Term1 Cash Receipt" := ObjCollectionSummary."First Term";
                    "Term2 Cash Receipt" := ObjCollectionSummary."Second Term";
                    "Term3 Cash Receipt" := ObjCollectionSummary."Third Term";

                    "Gross Fee Receipt" := "Term1 Cash Receipt" + "Term2 Cash Receipt" + "Term3 Cash Receipt";
                    "Net Fee Receipt" := ("Profitability Margin(%)" * "Gross Fee Receipt") / 100;
                    "Maximum EMI" := ("Maximum Possible DBR(%)" * "Net Fee Receipt") / 1200;
                    "Existing EMI" := "Appraised Obligations Monthly";
                    "Ed Partners EMI" := "Maximum EMI" - "Existing EMI";
                    VarCashEMIAmount := "Ed Partners EMI";
                    VarCashCollectionQualification := Round(VarCashEMIAmount * ((Power((1 + "Interest rate" / 1200), Installments) - 1) / (("Interest rate" / 1200) * (Power((1 + "Interest rate" / 1200), Installments)))), 1, '=');
                    if VarCashCollectionQualification <> 0 then
                        "Max Qualifying Cash Collection" := VarCashCollectionQualification;
                end;
                //-------Cash Collection Model;



                if VarMaximumABBQualification <> 0 then
                    "Max ABB Qualifying Amount" := VarMaximumABBQualification
                else
                    "Max ABB Qualifying Amount" := 0;
                "Max ABB EMI" := VarMaximumABBEligible;
                "Net Pay" := VarTotalAverage;
                "Max Qualification By Cashflow" := VarQualifyingLoanAmount;

                if VarMaximumABBQualification <> 0 then begin
                    if VarQualifyingLoanAmount < VarMaximumABBQualification/*VarMaximumABBEligible*/ then
                        "System Recommended Amount" := VarQualifyingLoanAmount
                    else
                        "System Recommended Amount" := VarMaximumABBQualification;
                    // MESSAGE('System Recommended on ABB %1 for amt %2',"System Recommended Amount",VarMaximumABBQualification)
                end else
                    if VarCashCollectionQualification > 0 then begin
                        if "System Recommended Amount" >= VarCashCollectionQualification then
                            "System Recommended Amount" := VarCashCollectionQualification
                        else
                            "System Recommended Amount" := VarQualifyingLoanAmount;
                        // MESSAGE('System Recommended on Cash %1 for Cash %2',"System Recommended Amount",VarCashCollectionQualification);
                    end;
                if "System Recommended Amount" < 0 then
                    "System Recommended Amount" := 0;

                if "Applied Amount" < "System Recommended Amount" then
                    "Approved Amount" := "Applied Amount"
                else
                    "Approved Amount" := "System Recommended Amount";
                "Appraisal Date" := Today;
                "Cumulative ABB" := VarTotalAverage;

                Rec.Modify;

            end;
        }
        field(67; "Gross Available Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(68; "Cleared Loans"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Net Available Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Amortized,Reducing Balance,Straight Line,Discounted';
            OptionMembers = " ",Amortized,"Reducing Balance","Straight Line",Discounted;
        }
        field(71; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = ' ,Monthly,Quarterly,Bi-Monthly,Weekly,Daily';
            OptionMembers = " ",Monthly,Quarterly,"Bi-Monthly",Weekly,Daily;
        }
        field(72; "Max Qualification By Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(73; "Max Qualification By Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(74; "Max Qualification By Guarantor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(75; "Max Qualification By Colateral"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(76; "Max Qualification By Dividend"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(77; "Deposits Factor"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(78; "Amount in Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Tracks the Loans Amount in Arrears and is dependent on the Defaulter Aging Report';
        }
        field(79; "Months in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Tracks the Defaulted Months and is dependent on the Amount in Arrears';
        }
        field(80; "Interest Paid"; Decimal)
        {
            CalcFormula = - Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                        Field46 = FILTER ("7"),
                                                        Field4 = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(81; "Interest Due"; Decimal)
        {
            CalcFormula = Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("6"),
                                                       Field4 = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(82; "Principal Paid"; Decimal)
        {
            CalcFormula = - Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                        Field46 = FILTER ("5"),
                                                        Field4 = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(83; "Amount Disbursed"; Decimal)
        {
            CalcFormula = Sum ("Loan Disbursement"."Amount to Disburse" WHERE ("Loan No" = FIELD ("Loan Number"),
                                                                              Status = FILTER (Posted),
                                                                              "Posting Date" = FIELD ("Date Filter")));
            Description = 'Tracks the Amount Disbursed and that yet to be disbursed';
            FieldClass = FlowField;
        }
        field(84; "Fully Disbursed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Mark Fully Disbursed Loans';
        }
        field(85; "Initial Disbursement Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Mark Initial Loan Disbursement';
        }
        field(86; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Mark Loan as Posted';
            Editable = false;
        }
        field(87; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'For Linking the Loans Table and the Revenue and School Expenses.';
            Editable = false;
            TableRelation = Table50121.Field1;
        }
        field(88; "Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'For the Clients Branch';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(89; "Provision Category"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'For  Periodic Categorization';
            OptionCaption = ' ,0 - 30 Days,31 - 60 Days,61 - 90 Days,91 - 120 Days,121 - 150 Days,151 - 270 Days,Above 270 Days';
            OptionMembers = " ","0 - 30 Days","31 - 60 Days","61 - 90 Days","91 - 120 Days","121 - 150 Days","151 - 270 Days","Above 270 Days";
        }
        field(90; "Loan Age"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'No of Days since Disbursement';
        }
        field(91; "Last Total Repayment"; Decimal)
        {
            CalcFormula = - Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                        Field46 = FILTER ("5" | "7" | "8"),
                                                        Field4 = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(92; "Last Principal Repayment"; Decimal)
        {
            CalcFormula = Max (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("5"),
                                                       Field4 = FIELD ("Date Filter"),
                                                       Field54 = FILTER ('')));
            FieldClass = FlowField;
        }
        field(93; "Last Interest Paid"; Decimal)
        {
            CalcFormula = Max (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("7"),
                                                       Field4 = FIELD ("Date Filter"),
                                                       Field54 = FILTER ('')));
            FieldClass = FlowField;
        }
        field(94; "Last Payment Date"; Date)
        {
            CalcFormula = Max (Table50124.Field4 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("5" | "7" | "8"),
                                                       Field4 = FIELD ("Date Filter"),
                                                       Field48 = FILTER (false)));
            FieldClass = FlowField;
        }
        field(95; "Last Accrual Date"; Date)
        {
            CalcFormula = Max (Table50124.Field4 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("6" | "11"),
                                                       Field48 = FILTER (false)));
            FieldClass = FlowField;
        }
        field(96; "Principal Paid As At Cutoff"; Decimal)
        {
            CalcFormula = - Sum (Table50158.Field11 WHERE (Field7 = FIELD ("Loan Number"),
                                                         Field3 = FILTER ("5"),
                                                         Field2 = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(97; "Interest Due as At Cuttoff"; Decimal)
        {
            CalcFormula = Sum (Table50158.Field11 WHERE (Field7 = FIELD ("Loan Number"),
                                                        Field3 = FILTER ("6"),
                                                        Field2 = FIELD ("Date Filter")));
            Description = 'Interest due From the Loans Historical data';
            FieldClass = FlowField;
        }
        field(98; "Interest Paid as At Cutoff"; Decimal)
        {
            CalcFormula = - Sum (Table50158.Field11 WHERE (Field7 = FIELD ("Loan Number"),
                                                         Field3 = FILTER ("7"),
                                                         Field2 = FIELD ("Date Filter")));
            Description = 'Interest Paid From the Loans Historical data';
            FieldClass = FlowField;
        }
        field(99; "Interest Accrued Buffer"; Decimal)
        {
            CalcFormula = Sum (Table50159.Field6 WHERE (Field8 = CONST (false),
                                                       Field2 = FIELD ("Loan Number"),
                                                       Field4 = FIELD ("Date Filter")));
            Description = 'Tracks Daily Accrued Interest from Table 50159';
            FieldClass = FlowField;
        }
        field(100; "Days in Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(101; "UnAllocated Funds"; Decimal)
        {
            CalcFormula = - Sum (Table50124.Field7 WHERE (Field54 = FIELD ("Member Number"),
                                                        Field46 = FILTER ("10")));
            Caption = 'Prepayments';
            FieldClass = FlowField;
        }
        field(102; "Penalty Charged"; Decimal)
        {
            CalcFormula = Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("9"),
                                                       Field4 = FIELD ("Date Filter")));
            Description = 'Tracks the Penaly charged and is yet to be paid';
            Editable = false;
            FieldClass = FlowField;
        }
        field(103; "Penalty Paid"; Decimal)
        {
            CalcFormula = - Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                        Field46 = FILTER ("8"),
                                                        Field4 = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(104; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(105; "Last UnAllocated Funds"; Decimal)
        {
            CalcFormula = Max (Table50124.Field7 WHERE (Field9 = FIELD ("Member Number"),
                                                       Field46 = FILTER ("10"),
                                                       Field4 = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(106; "Month Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Net Disbursement On Topup"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(108; "Total Payable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Installment No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(150; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Pro-forma Email Logs"."Time Sent";

            trigger OnValidate()
            begin
                if BankCodes.Get("Bank Code") then
                    "Bank Name" := BankCodes.Email;
            end;
        }
        field(151; "Bank Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(152; "Bank Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Invoice Tracker".Field11 WHERE (Field11 = FIELD ("Bank Code"));

            trigger OnValidate()
            begin
                BankBranches.Reset;
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Code");
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Branch");
                if BankBranches.FindFirst then begin
                    BankBranches.TestField(BankBranches."Branch Name");
                    "Bank Branch Name" := (BankBranches."Branch Name");
                end;
                if "Bank Branch" = '' then
                    "Bank Branch Name" := '';
            end;
        }
        field(153; "Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(154; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(155; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(156; "Bank Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Pro-forma Email Logs"."Time Sent";

            trigger OnValidate()
            begin
                if BankCodes.Get("Bank Code 2") then
                    "Bank Name 2" := BankCodes.Email;
            end;
        }
        field(157; "Bank Name 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(158; "Bank Branch 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Invoice Tracker".Field11 WHERE (Field10 = FIELD ("Bank Code 2"));

            trigger OnValidate()
            begin
                BankBranches.Reset;
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Code 2");
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Branch 2");
                if BankBranches.FindFirst then begin
                    BankBranches.TestField(BankBranches."Branch Name");
                    "Bank Branch Name 2" := (BankBranches."Branch Name");
                end;
                if "Bank Branch 2" = '' then
                    "Bank Branch Name 2" := '';
            end;
        }
        field(159; "Bank Branch Name 2"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(160; "Bank Account No. 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(161; "Swift Code2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(162; "RM Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3));

            trigger OnValidate()
            begin
                ObjDimension.Reset;
                ObjDimension.SetRange(ObjDimension.Code, "RM Code");
                if ObjDimension.FindSet then begin
                    "RM Name" := ObjDimension.Name;
                end;
            end;
        }
        field(163; "RM Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(164; "Fee Collection Rate(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(165; "Maximum Possible DBR(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(166; "Profitability Margin(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(167; "Appraised Obligations Monthly"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(168; "Offer Letter Addresee Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(169; "ABB Bank1 Details"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(170; "ABB Bank2 Details"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(171; "ABB Bank3 Details"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(174; "Total Annual Fee Income"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'School Loan Approval Fields';
        }
        field(175; "Gross Annual Fee Income"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Indicates the total fee collection Amount';
        }
        field(176; "Total School Expenses"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'For Total School Expenses Amount';
        }
        field(178; "Qualifying Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'The Amount One Can Qualify for';
        }
        field(179; "Annual Net Fee Income"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(180; "Monthly Net Fee Income"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(181; "Profitability Magin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(182; "Monthly Maximum Profitability"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(183; "Net Appraised Monthly Income"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(184; "Max EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(185; "Max ABB Qualifying Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(186; "ABB Total Bank 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(187; "ABB Total Bank 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(188; "ABB Total Bank 3"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(189; "Cumulative ABB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Max ABB EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(191; "Max Qualification By Cashflow"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(192; "BO Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Tracks Members whose Accruals are to be done on either 15th or 20th';
            TableRelation = Table50120.Field1;
        }
        field(193; "Loan Processing Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(194; "Credit Life Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(195; "Credit Life Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Spouse,Non-Spouse';
            OptionMembers = " ",Spouse,"Non-Spouse";

            trigger OnValidate()
            begin
                ObjGeneralSetup.GET();
                if "Credit Life Type" <> "Credit Life Type"::" " then begin
                    if "Credit Life Type" = "Credit Life Type"::Spouse then
                        "Credit Life Rate" := ObjGeneralSetup."Credit Life (Spouse) %"
                    else
                        "Credit Life Rate" := ObjGeneralSetup."Credit Life (Non-Spouse)%";
                end else
                    "Credit Life Rate" := 0;
            end;
        }
        field(196; "Credit Life Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(197; "Outstanding Suspense Interest"; Decimal)
        {
            CalcFormula = Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("11" | "12"),
                                                       Field4 = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(198; "Outstanding Write Off"; Decimal)
        {
            CalcFormula = - Sum (Table50163.Field8 WHERE (Field3 = FIELD ("Member Number"),
                                                        Field9 = FIELD ("Loan Number"),
                                                        Field5 = FILTER ("1" | "2")));
            FieldClass = FlowField;
        }
        field(199; "Outstanding Suspense Penalty"; Decimal)
        {
            CalcFormula = Sum (Table50124.Field7 WHERE (Field44 = FIELD ("Loan Number"),
                                                       Field46 = FILTER ("15" | "16"),
                                                       Field4 = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(200; "Total Write Off"; Decimal)
        {
            CalcFormula = - Sum (Table50163.Field8 WHERE (Field3 = FIELD ("Member Number"),
                                                        Field9 = FIELD ("Loan Number"),
                                                        Field5 = FILTER ("1")));
            FieldClass = FlowField;
        }
        field(201; "Total Write Off Recoveries"; Decimal)
        {
            CalcFormula = Sum (Table50163.Field8 WHERE (Field3 = FIELD ("Member Number"),
                                                       Field9 = FIELD ("Loan Number"),
                                                       Field5 = FILTER ("2")));
            FieldClass = FlowField;
        }
        field(222; "ED Loan Account No"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(223; "Term1 Details"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(224; "Term2 Details"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(225; "Term3 Details"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(226; "Term1 Cash Receipt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(227; "Term2 Cash Receipt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(228; "Term3 Cash Receipt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(229; "Gross Fee Receipt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(230; "Net Fee Receipt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(231; "Maximum EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(232; "Existing EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(233; "Ed Partners EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(234; "Max Qualifying Cash Collection"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(235; "Loan Perfection Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(236; "Loan Prepayments"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Loan Repayments on Disbursement';
        }
        field(237; "End Use Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Done';
            OptionMembers = Open,Pending,Done;
        }
    }

    keys
    {
        key(Key1; "Loan Number")
        {
            Clustered = true;
        }
        key(Key2; "Loan Balance")
        {
        }
        key(Key3; "ED Loan Account No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loan Number", "ED Loan Account No", "Member Number", "Full Name", "Applied Amount", "Approved Amount", "UnAllocated Funds")
        {
        }
    }

    trigger OnDelete()
    begin
        if "Loan Number" <> '' then
            Error('This Entry Can not be Deleted. Contact your system Administrator!!');
    end;

    trigger OnInsert()
    begin
        if "Loan Number" = '' then begin
            ObjGeneralSetup.GET;
            ObjGeneralSetup.TESTFIELD(ObjGeneralSetup."BO Loan Nos");
            NoSeriesMgt.InitSeries(ObjGeneralSetup."BO Loan Nos", ObjGeneralSetup."BO Loan Nos", 0D, "Loan Number", ObjGeneralSetup."BO Loan Nos");
            FnLoadDefaultInformation();
        end;
    end;

    var
        ObjBOAccount: Record Table50121;
        ObjLoanProducts: Record Table50107;
        txtInstallmentsError: Label 'Maximum Installments is %1';
        txtLoanAmountError: Label 'Maximum Loan Amount is %1';
        ObjGeneralSetup: Record Table50101;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjGuarantors: Record Table50141;
        ObjPayslip: Record Table50142;
        CFactory: Codeunit "ESD Text File Generator";
        BankBranches: Record "Invoice Tracker";
        BankCodes: Record "Pro-forma Email Logs";
        ObjDimension: Record "Dimension Value";
        ObjCust: Record Table50125;
        ObjLoanRevenueDetails: Record Table50144;
        ObjLoanExpensesDetails: Record Table50145;
        ObjLoanCollateral: Record Table50143;
        ObjLoanGeneralSetup: Record "Loan Management General Setup";
        ObjABB1: Record Table50147;
        ObjABB2: Record Table50148;
        ObjABB3: Record Table50149;
        VarTotalAnnualFeeIncome: Decimal;
        VarGrossAnnualFeeIncome: Decimal;
        VarTotalExpenses: Decimal;
        VarAnnualNetFeeIncome: Decimal;
        VarMonthlyNetFeeIncome: Decimal;
        VarMaximuProfitability: Decimal;
        VarMaximumMonthlyProfitability: Decimal;
        VarNetAppraisedMonthlyIncome: Decimal;
        VarMaximumEMI: Decimal;
        VarMaximumEligible: Decimal;
        VarQualifyingLoanAmount: Decimal;
        VarABBTotalBank1: Decimal;
        VarABBTotalBank2: Decimal;
        VarABBTotalBank3: Decimal;
        VarTotalAverage: Decimal;
        VarABBEMIAmount: Decimal;
        VarMaximumABBEligible: Decimal;
        VarMaximumABBQualification: Decimal;
        BankCount: Integer;
        DimensionValue: Record "Dimension Value";
        VarCashEMIAmount: Decimal;
        VarCashCollectionQualification: Decimal;
        txtLoanMinAmountError: Label 'Minimum Loan Amount is %1';

    local procedure FnLoadDefaultInformation()
    begin
        "Created By" := UserId;
        "Application Date" := Today;
    end;

    local procedure FnClearRelatedTables()
    begin
        //----1.Clear Guarantors Table------------------------------
        ObjGuarantors.RESET;
        ObjGuarantors.SETRANGE("Loan Number", "Loan Number");
        ObjGuarantors.DELETEALL;
        //----2.Clear Collaterals Table-----------------------------


        //----3.Clear Loans To Offset-------------------------------

        //----4.Clear Payslip Table---------------------------------
        ObjPayslip.RESET;
        ObjPayslip.SETRANGE("Loan Number", "Loan Number");
        ObjPayslip.DELETEALL;

        //-----5. Clear ABB Tables----------------------
        ObjABB1.RESET;
        ObjABB1.SETRANGE("Loan No", "Loan Number");
        ObjABB1.DELETEALL;

        ObjABB2.RESET;
        ObjABB2.SETRANGE("Loan No", "Loan Number");
        ObjABB2.DELETEALL;

        ObjABB3.RESET;
        ObjABB3.SETRANGE("Loan No", "Loan Number");
        ObjABB3.DELETEALL;

        //-----6. Clear Revenue & Expenses Tables----------------------------
        ObjLoanCollateral.RESET;
        ObjLoanCollateral.SETRANGE("Loan No", "Loan Number");
        ObjLoanCollateral.DELETEALL;

        ObjLoanRevenueDetails.RESET;
        ObjLoanRevenueDetails.SETRANGE("Loan No", "Loan Number");
        ObjLoanRevenueDetails.DELETEALL;

        ObjLoanExpensesDetails.RESET;
        ObjLoanExpensesDetails.SETRANGE("Loan No", "Loan Number");
        ObjLoanExpensesDetails.DELETEALL;
    end;

    local procedure FnPoupalatePayslip()
    var
        ObjPayslipSetup: Record Table50108;
        EntryNo: Integer;
    begin
        ObjPayslip.RESET;
        if ObjPayslip.FINDLAST then
            EntryNo := ObjPayslip."Entry No" + 1;

        ObjPayslipSetup.RESET;
        ObjPayslipSetup.SETRANGE(Default, true);
        if ObjPayslipSetup.FINDSET(true, true) then begin
            repeat
                ObjPayslip.INIT;
                ObjPayslip."Entry No" := EntryNo;
                ObjPayslip."Loan Number" := "Loan Number";
                ObjPayslip."Loanee  Number" := "Member Number";
                ObjPayslip."Payslip Item" := ObjPayslipSetup."Payslip Item";
                ObjPayslip.VALIDATE(ObjPayslip."Payslip Item");
                ObjPayslip.INSERT(true);
                EntryNo := EntryNo + 1;
            until ObjPayslipSetup.NEXT = 0;
        end
    end;

    local procedure QaulifyBySalary()
    begin
        Clear("Max Qualification By Salary");
        if "Interest Calculation Method" = "Interest Calculation Method"::"Straight Line" then
            "Max Qualification By Salary" := "Net Available Amount" / ((1 / Installments) + ("Interest rate" / 1200));

        if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then
            "Max Qualification By Salary" := "Net Available Amount" / ((1 / Installments) + ("Interest rate" / 1200));

        if "Interest Calculation Method" = "Interest Calculation Method"::Amortized then
            "Max Qualification By Salary" := "Net Available Amount" * ((Power((1 + "Interest rate" / 1200), Installments) - 1) / (("Interest rate" / 1200) * (Power((1 + "Interest rate" / 1200), Installments))));
    end;

    local procedure FnRecommendedAmount(RequestedAmount: Decimal; QShares: Decimal; QGuarantors: Decimal; QSalary: Decimal) RecommendedAmount: Decimal
    begin
        RecommendedAmount := RequestedAmount;
        if ObjLoanProducts.GET("Loan Product") then begin
            if ObjLoanProducts."Qualify by Deposits" then begin
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
            end;

            if ObjLoanProducts."Qualify by Guarantors" then begin
                if RecommendedAmount > QGuarantors then
                    RecommendedAmount := QGuarantors;
            end;

            if ObjLoanProducts."Qualify by Salary" then begin
                if RecommendedAmount > QSalary then
                    RecommendedAmount := QSalary;
            end;

            if ((ObjLoanProducts."Qualify by Deposits") and (ObjLoanProducts."Qualify by Guarantors")) then begin
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
                if RecommendedAmount > QGuarantors then
                    RecommendedAmount := QGuarantors;
            end;

            if ((ObjLoanProducts."Qualify by Deposits") and (ObjLoanProducts."Qualify by Salary")) then begin
                if RecommendedAmount > QSalary then
                    RecommendedAmount := QSalary;
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
            end;

            if ((ObjLoanProducts."Qualify by Guarantors") and (ObjLoanProducts."Qualify by Salary")) then begin
                if RecommendedAmount > QSalary then
                    RecommendedAmount := QSalary;
                if RecommendedAmount > QGuarantors then
                    RecommendedAmount := QGuarantors;
            end;

            if ((ObjLoanProducts."Qualify by Guarantors") and (ObjLoanProducts."Qualify by Salary") and (ObjLoanProducts."Qualify by Deposits")) then begin
                if RecommendedAmount > QSalary then
                    RecommendedAmount := QSalary;
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
                if RecommendedAmount > QGuarantors then
                    RecommendedAmount := QGuarantors;
            end;
        end;
        if RecommendedAmount > RequestedAmount then
            RecommendedAmount := RequestedAmount;

        if RecommendedAmount < 0 then
            RecommendedAmount := 0;
        exit(RecommendedAmount);
    end;

    local procedure FnClearRecordFields()
    begin
        Clear("Loan Product");
        Validate("Loan Product");
        Clear("Applied Amount");
        Clear("Net Pay");
        Clear("Deposits Balance");
        Clear("Bank Code");
        Clear("Bank Name");
        Clear("Bank Branch");
        Clear("Bank Branch Name");
        Clear("Bank Account No.");
        Clear("Swift Code");
        Clear("Bank Code 2");
        Clear("Bank Name 2");
        Clear("Bank Branch 2");
        Clear("Bank Branch Name 2");
        Clear("Bank Account No. 2");
        Clear("Swift Code2");
        Clear("ID Number");
    end;

    local procedure FnRunUpdateSchoolRevenue_Expenditure()
    var
        ObjRevenueII: Record Table50132;
        ObjLoanSchoolRevenue: Record Table50144;
        ObjExpensesII: Record Table50133;
        ObjLoanSchoolExpenses: Record Table50145;
    begin
        //============================================================================School Revenue
        ObjRevenueII.RESET;
        ObjRevenueII.SETRANGE(ObjRevenueII."Document No", "Application No");
        if ObjRevenueII.FINDSET then begin
            ObjLoanSchoolRevenue.RESET;
            ObjLoanSchoolRevenue.SETRANGE(ObjLoanSchoolRevenue."Loan No", "Loan Number");
            if ObjLoanSchoolRevenue.FIND('-') then
                ObjLoanSchoolRevenue.DELETEALL;
            repeat
                ObjLoanSchoolRevenue.INIT;
                ObjLoanSchoolRevenue."Loan No" := "Loan Number";
                ObjLoanSchoolRevenue.Class := ObjRevenueII.Class;
                ObjLoanSchoolRevenue.Streams := ObjRevenueII.Streams;
                ObjLoanSchoolRevenue."Termly Fee" := ObjRevenueII."Termly Fee";
                ObjLoanSchoolRevenue."Term One Fees" := ObjRevenueII."Term One Fees";
                ObjLoanSchoolRevenue."Term Two Fees" := ObjRevenueII."Term Two Fees";
                ObjLoanSchoolRevenue."Term Three Fees" := ObjRevenueII."Term Three Fees";
                ObjLoanSchoolRevenue."Annual Fee" := ObjRevenueII."Annual Fee";
                ObjLoanSchoolRevenue."Total Student" := ObjRevenueII."Total Student";
                ObjLoanSchoolRevenue."Total Income" := ObjRevenueII."Total Income";
                ObjLoanSchoolRevenue."Entry No" := ObjRevenueII."Entry No";
                ObjLoanSchoolRevenue.INSERT;
            until ObjRevenueII.NEXT = 0;
        end;

        //============================================================================Total Expenses
        ObjExpensesII.RESET;
        ObjExpensesII.SETRANGE(ObjExpensesII."Document No", "Application No");
        if ObjExpensesII.FINDSET then begin
            ObjLoanSchoolExpenses.RESET;
            ObjLoanSchoolExpenses.SETRANGE(ObjLoanSchoolExpenses."Loan No", "Loan Number");
            if ObjLoanSchoolExpenses.FIND('-') then
                ObjLoanSchoolExpenses.DELETEALL;

            repeat
                ObjLoanSchoolExpenses.INIT;
                ObjLoanSchoolExpenses."Loan No" := "Loan Number";
                ObjLoanSchoolExpenses."Expense Head" := ObjExpensesII."Expense Head";
                ObjLoanSchoolExpenses."Entry No" := ObjExpensesII."Entry No";
                ObjLoanSchoolExpenses."Annual Expense" := ObjExpensesII."Annual Expense";
                ObjLoanSchoolExpenses."Monthly Expense" := ObjExpensesII."Monthly Expense";
                ObjLoanSchoolExpenses."Expense Type" := ObjExpensesII."Expense Type";
                ObjLoanSchoolExpenses.INSERT;
            until ObjExpensesII.NEXT = 0;
        end;
    end;

    local procedure FnGetProcessingFees() Proc_fees: Decimal
    var
        ObjLoanCharge: Record Table50152;
        LoanFees: Decimal;
    begin
        ObjLoanCharge.RESET;
        ObjLoanCharge.SETRANGE(ObjLoanCharge.Code, 'PROC_FEE');
        if ObjLoanCharge.FIND('-') then begin
            if ObjLoanCharge."Use Percentage" then
                LoanFees := (ObjLoanCharge.Percentage * "Approved Amount") / 100
            else
                LoanFees := ObjLoanCharge.Amount;
        end;
        exit(LoanFees);
    end;

    local procedure FnClearLoanOffsetDetails()
    var
        ObjLoanOffsetDetails: Record Table50164;
    begin
        ObjLoanOffsetDetails.RESET;
        ObjLoanOffsetDetails.SETRANGE(ObjLoanOffsetDetails."Loan No.", "Loan Number");
        if ObjLoanOffsetDetails.FINDSET then
            ObjLoanOffsetDetails.DELETEALL;
    end;

    local procedure FnUpdateAttachments(ClientCode: Code[20])
    var
        RecRef: RecordRef;
        RecID: RecordID;
        VarTableNo: Integer;
        RecRefII: RecordRef;
        RecIDII: RecordID;
        VarTableNoII: Integer;
        ObjBOAccounts: Record Table50121;
        ClientNumber: Code[20];
        ObjDocumentAttachment: Record "Document Attachment";
        ObjDocumentAttachmentII: Record "Document Attachment";
    begin
        ObjBOAccounts.RESET;
        ObjBOAccounts.SETRANGE(ObjBOAccounts."Member Number", ClientCode);
        if ObjBOAccounts.FIND('-') then
            ClientNumber := ObjBOAccounts.No;

        RecRefII.Close();
        RecRefII.Open(DATABASE::Table50121);
        if RecRefII.Find('-') then begin
            RecIDII := RecRefII.RecordId;
            VarTableNoII := RecIDII.TableNo;
        end;

        ObjDocumentAttachment.Reset;
        ObjDocumentAttachment.SetRange(ObjDocumentAttachment."Table ID", VarTableNoII);
        ObjDocumentAttachment.SetRange(ObjDocumentAttachment."No.", ClientNumber);
        if ObjDocumentAttachment.Find('-') then begin
            repeat

                RecRef.Close();
                RecRef.Open(DATABASE::Loans);
                if RecRef.Find('-') then begin
                    RecID := RecRef.RecordId;
                    VarTableNo := RecID.TableNo;
                end;

                ObjDocumentAttachmentII.Init;
                ObjDocumentAttachmentII."Line No." := ObjDocumentAttachment."Line No.";
                ObjDocumentAttachmentII."Table ID" := VarTableNo;
                ObjDocumentAttachmentII.ID := ObjDocumentAttachment.ID;
                ObjDocumentAttachmentII."No." := "Loan Number";
                ObjDocumentAttachmentII."Line No." := ObjDocumentAttachment."Line No.";
                ObjDocumentAttachmentII."Attached Date" := ObjDocumentAttachment."Attached Date";
                ObjDocumentAttachmentII."File Name" := ObjDocumentAttachment."File Name";
                ObjDocumentAttachmentII."File Type" := ObjDocumentAttachment."File Type";
                ObjDocumentAttachmentII."Document Reference ID" := ObjDocumentAttachment."Document Reference ID";
                ObjDocumentAttachmentII."File Extension" := ObjDocumentAttachment."File Extension";
                ObjDocumentAttachmentII."Attached By" := ObjDocumentAttachment."Attached By";
                ObjDocumentAttachmentII."Attached Date" := ObjDocumentAttachment."Attached Date";
                ObjDocumentAttachmentII.User := ObjDocumentAttachment.User;
                ObjDocumentAttachmentII."Document Type" := ObjDocumentAttachment."Document Type";
                ObjDocumentAttachmentII.Insert;
            until ObjDocumentAttachment.Next = 0;
        end;
    end;

    local procedure FnClearDocumentAttachments(ClientCode: Code[20])
    var
        ObjDocumentAttachment: Record "Document Attachment";
        ObjDocumentAttachmentII: Record "Document Attachment";
        ObjBOAccounts: Record Table50121;
        RecRef: RecordRef;
        RecID: RecordID;
        VarTableNo: Integer;
        ClientNumber: Code[20];
    begin
        ObjBOAccounts.RESET;
        ObjBOAccounts.SETRANGE(ObjBOAccounts."Member Number", ClientCode);
        if ObjBOAccounts.FIND('-') then
            ClientNumber := ObjBOAccounts.No;

        ObjDocumentAttachment.Reset;
        ObjDocumentAttachment.SetRange(ObjDocumentAttachment."Table ID", RecordId.TableNo);
        ObjDocumentAttachment.SetRange(ObjDocumentAttachment."No.", "Loan Number");
        if ObjDocumentAttachment.Find('-') then begin
            ObjDocumentAttachment.DeleteAll;
        end;
    end;

    local procedure FnCalcLoanCharges(RunningBal: Decimal) RunBal: Decimal
    var
        VarAmount: Decimal;
        LCharges: Record Table50152;
        VarRunBal: Decimal;
        TotalCharges: Decimal;
    begin
        VarRunBal := RunningBal;
        TotalCharges := 0;
        if RunningBal > 0 then begin
            LCharges.RESET;
            LCharges.SETRANGE(LCharges.Code);
            if LCharges.FIND('-') then begin
                repeat
                    if LCharges."Use Percentage" = true then
                        VarAmount := (LCharges.Percentage * VarRunBal) / 100
                    else
                        VarAmount := LCharges.Amount;

                    TotalCharges := TotalCharges + VarAmount;

                until LCharges.NEXT = 0;
            end;

            "Total Upfront Deductions" := TotalCharges + "Credit Life Fees" + "Loan Perfection Charges" + "Loan Prepayments";
            Modify;
        end;
    end;
}

