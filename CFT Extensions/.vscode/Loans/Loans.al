table 50140 Loans
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Loan Number"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            // NotBlank = true;
            Caption = 'Loan Number';
            // FieldClass = Normal;
            // Enabled = true;
            // Numeric = false;
            // DateFormula = false;

        }
        field(2; "Member Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'loaded from BO applications- Tracking individual account Number for tracking member';
            Caption = 'Client Code';
            FieldClass = Normal;
            TableRelation = Customer where("Membership Status" = filter(Active), "Member Posting Group" = filter('BO' | 'FO'));
            trigger OnValidate()
            var
                ObjBOAccount: Record Customer;
            begin
                FnClearRecordFields();
                FnClearRelatedTables();
                ObjBOAccount.Reset();
                ObjBOAccount.SetRange("No.", "Member Number");
                if ObjBOAccount.Find('-') then begin
                    ObjBOAccount.CalcFields("New DepositContributionBalance", "New Share Capital Balance");
                    "Full Name" := ObjBOAccount."Full Name";
                    "ID Number" := ObjBOAccount."ID Number";
                    "Mobile Number" := ObjBOAccount."Mobile Number";
                    "Employer Code" := ObjBOAccount."Employer Code";
                    "Payroll Number" := ObjBOAccount."Payroll Number";
                    "Deposits Balance" := ObjBOAccount."New DepositContributionBalance";
                    "Share Capital Balance" := ObjBOAccount."New Share Capital Balance";
                    "Application No" := ObjBOAccount.No;
                    "Branch Code" := ObjBOAccount."Branch Code";
                    "Bank Code" := ObjBOAccount."Bank Code";
                    "Bank Name" := ObjBOAccount."Bank Name";
                    "Bank Branch" := ObjBOAccount."Bank Branch";
                    "Bank Branch Name" := ObjBOAccount."Bank Branch Name";
                    // "Bank Account No." := ObjBOAccount."Bank Account No";
                    "Swift Code" := ObjBOAccount."Swift Code";
                    // Validate("Deposits Balance");
                end;

            end;
        }
        field(3; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Full Name';
            NotBlank = true;
            Editable = true;
            Enabled = true;

        }
        field(4; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'ID Number';
            Description = 'Loaded Form BO Applications- National ID Number';
            FieldClass = Normal;
            Editable = false;

        }
        field(5; "Mobile Number"; Code[12])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile Number';
            Enabled = true;
            FieldClass = Normal;
            Editable = false;
        }
        field(6; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employer Code';
            Description = 'Loaded Form BO Applications- Employer code helps tracking loans from a specific employer';
            Enabled = true;
            Editable = false;

        }
        field(7; "Payroll Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payroll Number';
            Editable = false;

        }
        field(8; "Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Loan Balance';
            Description = 'Oustanding loan balances as at date of taken loan. Can be updated by either the provisioning report or the top 20 OLB Report and can be used as a flowfield';
            Editable = false;
        }
        field(9; "Deposits Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Deposit Contribution as at time of taking loan';
            Caption = 'Deposits Balance';
            Enabled = true;
            Editable = false;
            trigger OnValidate()
            begin
                "Max Qualification By Deposits" := "Deposits Factor" * "Deposits Balance";
            end;
        }
        field(10; "Share Capital Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Share Capital Balance';
            Description = 'Share Capital as at Time of Taking Loan';
            Enabled = true;
            Editable = false;
        }
        field(11; "Loan Product"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Loan Product';
            Description = 'Loan Product Code Being Applied';
            Enabled = true;
            Editable = true;
            TableRelation = "Loan Products".Code;
            trigger OnValidate()
            var
                ObjLoanProducts: Record "Loan Products";
            begin
                CLEAR("Interest rate");
                CLEAR(Installments);
                CLEAR("Recovery Mode");
                CLEAR("Interest Calculation Method");
                CLEAR("Repayment Frequency");
                ObjLoanProducts.Reset();
                ObjLoanProducts.SetRange(Code, "Loan Product");
                if ObjLoanProducts.Find('-') then begin
                    "Interest rate" := ObjLoanProducts."Max Interest Rate";
                    Installments := ObjLoanProducts."Max Installments";
                    "Recovery Mode" := ObjLoanProducts."Recovery Mode";
                    "Interest Calculation Method" := ObjLoanProducts."Interest Calculation Method";
                    "Repayment Frequency" := ObjLoanProducts."Repayment Frequency";
                    "Deposits Factor" := ObjLoanProducts."Deposit Factor";
                    Rec.Modify();

                end;

            end;

        }
        field(12; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Interest Rate';
            Description = 'Interest Rate for the Product';
            Enabled = true;
            trigger OnValidate()
            var
                ObjLoanProducts: Record "Loan Products";
            begin
                ObjLoanProducts.Get("Loan Product");
                if "Interest Rate" < ObjLoanProducts."Min Interest Rate" then
                    Error('The Interest Rate for %1 can not be less than %2', "Loan Product", ObjLoanProducts."Min Interest Rate");
                if "Interest Rate" > ObjLoanProducts."Max Interest Rate" then
                    Error('The Interest Rate for %1 can not be more than %2', "Loan Product", ObjLoanProducts."Max Interest Rate");

            end;
        }
        field(13; Installments; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Installments';
            Description = 'Installments Applied for the Loan Product';
            Enabled = true;
            trigger OnValidate()
            var
                ObjLoanProducts: Record "Loan Products";

            begin
                if ObjLoanProducts.get("Loan Product") then
                    Error('Maximum Installment is %1', ObjLoanProducts."Max Installments");

            end;

        }
        field(14; "Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Applied Amount';
            Description = 'Amount Requested by the Applicant';
            Enabled = true;
            trigger OnValidate()
            var
                ObjLoanProducts: Record "Loan Products";
            begin
                if ObjLoanProducts.Get("Loan Product") then begin
                    if "Applied Amount" > ObjLoanProducts."Max Loan Amount" then
                        Error('Maximum Loan Amount is %1', ObjLoanProducts."Max Loan Amount");
                    if "Applied Amount" < ObjLoanProducts."Min Loan Amount" then
                        Error('Minimum Loan Amount is %1', ObjLoanProducts."Min Loan Amount");
                end;

            end;
        }
        field(15; "System Recommended Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'System Recommended Amount';
            Description = 'Recommended Amount by the Appraisal Process';
            Enabled = true;
        }
        field(16; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved Amount';
            Description = 'Approved Amount by the System/Final Approver';
            Enabled = true;
        }
        field(17; "Gross Disbursed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Gross Disbursed Amount';
            Description = 'Amount to be Disbursed to Member Bank';
            Enabled = true;
            Editable = false;
        }
        field(18; "Total Upfront Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Upfront Deductions';
            Description = 'This includes all the charges due to the loan without the total offset charges';
            Enabled = true;
            Editable = false;
        }
        field(19; "Total Offset Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Offset Amount';
            Description = 'Total amount from the Loans begin offset. The Amount includes the Outstanding Loan,Oustanding Interest,Commission on Loan Offset';
            Enabled = true;
            Editable = false;
        }
        field(20; "Net Disbursed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Net Disbursed Amount';
            Description = 'Total amount from the Loans begin offset. The Amount includes the Outstanding Loan,Oustanding Interest,Commission on Loan Offset';
            Enabled = true;
            Editable = false;
        }
        field(21; "Total Guarantors"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Total Guarantors';
            Enabled = true;
            Editable = false;
            CalcFormula = count(Guarantors where("Is Substituted" = const(false)));
        }
        field(22; "Total Guaranteed Amount"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Total Guaranteed Amount';
            Enabled = true;
            CalcFormula = sum(Guarantors."Guaranteed Amount" where("Loan Number" = field("Loan Number")));
            Editable = false;

        }
        field(23; "Total Collateral Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Collateral Amount';
            Enabled = true;
        }
        field(24; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Application Date';
            Description = 'The Date the Loan is';
            Enabled = true;

        }
        field(25; "Appraisal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Appraisal Date';
            Description = 'The Final Appraisal Date';
            Enabled = true;
            Editable = false;
        }
        field(26; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Date';
            Enabled = true;
            Editable = false;
        }
        field(27; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Disbursement Date';
            Enabled = true;
            Editable = true;
        }
        field(28; "Repayment Debut Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Repayment Debut Date';
            Description = 'The First formal Date for the Loan Repayment';
            Enabled = true;
        }
        field(29; "Expected End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Expected End Date';
            Enabled = true;
            Editable = false;
        }
        field(30; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
            Enabled = true;
        }
        field(31; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
            Description = 'The user id for the user who initially captures the Loan product';
            Enabled = true;
            Editable = false;
        }
        field(32; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved By';
            Description = 'The Final Approver for the Loan approval process';
            Enabled = true;
        }
        field(33; "Disbursed By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Disbursed By';
            Description = 'The user id for the posting user';
            Enabled = true;
            Editable = false;
        }
        field(34; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            Caption = 'Approval Status';
            Enabled = true;
            trigger OnValidate()
            begin
                if "Approval Status" = "Approval Status"::Approved then begin
                    "Approval Date" := Today;
                    "Principal Repayment" := "Approved Amount" / Installments;
                    "Loan Status" := "Loan Status"::Approved;
                    "Loan Processing Fees" := FnGetProcessingFees();
                end;
            end;
        }
        field(35; "Loan Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,Appraisal,Approved,Disbursed;
            Caption = 'Loan Status';
            Enabled = true;

        }
        field(36; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reversed';
            Description = 'Marks the Loan as Reversed';
            Enabled = true;

        }
        field(37; "Reversed Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reversed Date';
            Description = 'The Date the Loan Reversal Happened';
            Enabled = true;
        }
        field(38; "Reversed By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reversed By';
            Description = 'The user id that is involved in making the Loan Reversal';
            Enabled = true;
            Editable = false;
        }
        field(39; Cleared; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cleared';
            Description = 'Marks the Loan after its cleared.To reverse this status, Approval process must be followed';
            Enabled = true;
            Editable = false;
        }
        field(40; "Date Cleared"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Cleared';
            Description = 'Marks the date a Loan is cleared';
            Enabled = true;
            Editable = false;
        }
        field(41; "Cleared By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cleared By';
            Description = 'The user id for the user who captures the final repayment for the Loan';
            Enabled = true;
            Editable = false;
        }
        field(42; "Clearing Process"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Check Off",Receipt,Transfer,Offset,Reversal;
            OptionCaption = 'Check Off, Receipt, Transfer, Offset, Reversal';
            FieldClass = Normal;
            Description = 'The Process that is used to Make the Loan final Repayment';
            Enabled = true;
            Editable = false;
        }
        field(43; "Recovery Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Check Off",Salary;
            OptionCaption = 'Check Off, Salary';
            Description = 'Check Off,Salary';
            Enabled = true;
        }
        field(44; "Guarantors Notified"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Guarantors Notified';
            Description = 'Checkbox for Tracking if Guarantors for a Loan have been Notified. Notification via SMS or Email Address';
            Enabled = true;
            Editable = false;

        }
        field(45; "Schedule Generated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Schedule Generated';
            Editable = false;
            Description = 'The check for the generation of a Schedule. A Loan cannot be posted without if this field is not marked True';
            Enabled = true;
        }
        field(46; "Mode of Disbursement"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Full,Tranches;
            OptionCaption = ',Full, Tranches';
            Enabled = true;
            trigger OnValidate()
            begin
                if "Mode of Disbursement" = "Mode of Disbursement"::Full then
                    "Gross Disbursed Amount" := "Approved Amount"
                else
                    "Gross Disbursed Amount" := 0;
            end;
        }
        field(47; "Principal Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Principal Repayment';
            Description = 'Tracks the Monthly Repayment';
            Enabled = true;
            Editable = false;
        }
        field(48; "Outstanding Penalty"; Decimal)
        {
            // Replaced by New Outstanding Penalty
            DataClassification = ToBeClassified;
            Caption = 'Outstanding Penalty';
            Description = 'Tracks the Penaly charged and is yet to be paid';
            Enabled = true;
            Editable = false;
        }
        field(49; "Total Monthly Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Monthly Repayment';
            Description = 'Tracks the Total Monthly Repayment for Amortized Loans';
            Enabled = true;
        }
        field(50; "Outstanding Loan"; Decimal)
        {
            // Replaced by New Outstanding Loan
            DataClassification = ToBeClassified;
            Caption = 'Outstanding Loan';
            Description = 'Tracks the outstanding Principal balance of a Loan as per the Date Filter (If Filtering date is not passed, the Default is TODAY)';
            Enabled = true;
            Editable = false;
        }
        field(51; "Outstanding Interest"; Decimal)
        {
            // Replaced by New Outstanding Balance
            DataClassification = ToBeClassified;
            Caption = 'Outstanding Interest';
            Description = 'Tracks the outstanding Accrued Interest balance of a Loan as per the Date Filter (If Filtering date is not passed, the Default is TODAY). Interest Accrued - Interest Paid';
            Enabled = true;
            Editable = false;
        }
        field(52; "Expected Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Expected Outstanding Balance';
            Description = 'Track the expected Principal Balance as per the Loan Schedule';
            Enabled = true;
            Editable = false;
        }
        field(53; "Loan Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Performing,Watch,Substandard,Doubtful,Loss;
            OptionCaption = 'Performing, Watch, Substandard, Doubtful, Loss';
            Description = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            Enabled = true;
            Editable = false;
        }
        field(54; "Loan Purpose"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Loan Purpose';
            Enabled = true;
            TableRelation = "Loan Purpose Setup Table".Code;
        }
        field(55; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks';
            Enabled = true;
        }
        field(56; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Basic Pay';
            Enabled = true;
            Editable = false;
        }
        field(57; "Total Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Allowance';
            Enabled = true;
            Editable = false;
        }
        field(58; "Gross Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Gross Salary';
            Enabled = true;
            Editable = false;

        }
        field(59; "1/3 Basic"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = '1/3 Basic';
            Enabled = true;
            Editable = false;
        }
        field(60; "Statutory Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Statutory Deductions';
            Enabled = true;
            Editable = false;
        }
        field(61; "Other Deductions"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Other Deductions';
            Enabled = true;
            Editable = false;
        }
        field(62; "Provident Fund"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Provident Fund';
            Enabled = true;
            Editable = false;
        }
        field(63; "Taxable Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Taxable Pay';
            Enabled = true;
            Editable = false;
            trigger OnValidate()
            begin

            end;
        }
        field(64; PAYE; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'PAYE';
            Enabled = true;
            Editable = false;
        }
        field(65; Relief; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Relief';
            Enabled = true;
            Editable = false;
        }
        field(66; "Net Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Net Pay';
            Enabled = true;
            Editable = false;
            trigger OnValidate()
            var
                CFactory: Codeunit "CFT Factory";
            begin
                CalcFields("New Gross Salary", "New Satutory Deductions", "New Other Deductions", "New Relief", "New Provident Fund", "New Guaranteed Amount");
                "Taxable Pay" := "New Gross Salary" - "New Provident Fund";
                Rec."Taxable Pay" := Rec."New Gross Salary" - Rec."New Provident Fund";
                "1/3 Basic" := 1 / 3 * "New Basic Pay";
                PAYE := 0;
                "Net Pay" := 0;
                "Gross Available Amount" := 0;
                "Net Available Amount" := 0;
                if "Taxable Pay" > 1408 then begin
                    PAYE := CFactory.FnCalculatePaye("Taxable Pay") - Relief;
                    "Net Pay" := "New Gross Salary" - ("New Satutory Deductions" + "New Other Deductions" + PAYE);
                    "Gross Available Amount" := "Net Pay" - "1/3 Basic";
                    "Net Available Amount" := "Gross Available Amount";
                end;
                QualifyBySalary();
                "Max Qualification By Guarantor" := "New Guaranteed Amount";
                "Max Qualification By Colateral" := "New Collateral Amount";
                "System Recommended Amount" := FnRecommendedAmount("Applied Amount", "Max Qualification By Deposits", "New Guaranteed Amount", "Max Qualification By Salary", "New Collateral Amount");
                "Approved Amount" := "System Recommended Amount";
                if "System Recommended Amount" < 0 then
                    "System Recommended Amount" := 0;
                if "Applied Amount" < "System Recommended Amount" then
                    "Approved Amount" := "Applied Amount"
                else
                    "Approved Amount" := "System Recommended Amount";
                "Appraisal Date" := Today;
                Rec.Modify();

            end;

        }
        field(67; "Gross Available Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Gross Available Amount';
            Enabled = true;
            Editable = false;
        }
        field(68; "Cleared Loans"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cleared Loans';
            Enabled = true;
        }
        field(69; "Net Available Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Net Available Amount';
            Enabled = true;
            Editable = false;
        }
        field(70; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Amortized,"Reducing Balance","Straight Line",Discounted;
            OptionCaption = 'Amortized,Reducing Balance,Straight Line,Discounted';
        }
        field(71; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Monthly,Quarterly,"Bi-Monthly",Weekly,Daily;
        }
        field(72; "Max Qualification By Salary"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Max Qualification By Salary';
            Enabled = true;
            Editable = false;
        }
        field(73; "Max Qualification By Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Max Qualification By Deposits';
            Enabled = true;
            Editable = false;
        }
        field(74; "Max Qualification By Guarantor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Max Qualification By Guarantor';
            Enabled = true;
            Editable = false;
        }
        field(75; "Max Qualification By Colateral"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Max Qualification By Colateral';
            Enabled = true;
            Editable = false;
        }
        field(76; "Max Qualification By Dividend"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Max Qualification By Dividend';
            Enabled = true;
            Editable = false;
        }
        field(77; "Deposits Factor"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Deposits Factor';
            Enabled = true;
            Editable = false;
        }
        field(78; "Amount in Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount in Arrears';
            Enabled = true;
            Description = 'Tracks the Loans Amount in Arrears and is dependent on the Defaulter Aging Report';
        }
        field(79; "Months in Arrears"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount in Arrears';
            Description = 'Tracks the Defaulted Months and is dependent on the Amount in Arrears';
            Enabled = true;
        }
        field(80; "Interest Paid"; Decimal)
        {
            // Replaced by New Interest Paid
            DataClassification = ToBeClassified;
            Caption = 'Interest Paid';
            Enabled = true;
        }
        field(81; "Interest Due"; Decimal)
        {
            // Replaced by New Interest Due
            DataClassification = ToBeClassified;
            Caption = 'Interest Due';
            Enabled = true;
        }
        field(82; "Principal Paid"; Decimal)
        {
            // Replaced by New Principal Paid
            DataClassification = ToBeClassified;
            Caption = 'Principal Paid';
            Enabled = true;
        }
        field(83; "Amount Disbursed"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Disburded';
            Description = 'Tracks the Amount Disbursed and that yet to be disbursed';
            Enabled = true;
        }
        field(84; "Fully Disbursed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fully Disbursed';
            Description = 'Mark Fully Disbursed Loans';
            Enabled = true;
        }
        field(85; "Initial Disbursement Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Initial Disbursement Created';
            Description = 'Mark Initial Loan Disbursement';
            Enabled = true;

        }
        field(86; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            caption = 'Posted';
            Description = 'Mark Loan as Posted';
            Enabled = true;
            Editable = false;
        }
        field(87; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Application No';
            Description = 'For Linking the Loans Table and the Revenue and School Expenses.';
            Enabled = true;
            Editable = false;
        }
        field(88; "Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Branch Code';
            Description = 'For the Clients Branch';
            Enabled = true;
        }
        field(89; "Provision Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "0 - 30 Days","31 - 60 Days","61 - 90 Days","91 - 120 Days","121 - 150 Days","151 - 270 Days","Above 270 Days";
            OptionCaption = '"0 - 30 Days","31 - 60 Days","61 - 90 Days","91 - 120 Days","121 - 150 Days","151 - 270 Days","Above 270 Days"';
        }
        field(90; "Loan Age"; Integer)
        {
            DataClassification = ToBeClassified;
            caption = 'Loan Age';
            Description = 'No of Days since Disbursement';
            Enabled = true;
        }
        field(91; "Last Total Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Total Repayment';
            Enabled = true;
        }
        field(92; "Last Principal Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Principal Repayment';
            Enabled = true;
        }
        field(93; "Last Interest Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Interest Paid';
            Enabled = true;
        }
        field(94; "Last Payment Date"; date)
        {
            // Replaced by Last Payment Date
            DataClassification = ToBeClassified;
            Caption = 'Last Payment';
            Enabled = true;
        }
        field(95; "Last Accrual Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Accrual Date';
            Enabled = true;
        }
        field(96; "Principal Paid As At Cutoff"; Integer)
        {
            // Replaced by New PrincipalPaid as at Cutoff
            DataClassification = ToBeClassified;
            Caption = 'Principal Paid As At Cutoff';
            Enabled = true;
        }
        field(97; "Interest Due As At Cutoff"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Interest Due As At Cutoff';
            Description = 'Interest due From the Loans Historical data';
            Enabled = true;
        }
        field(98; "Interest Paid as At Cutoff"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Interest Paid as At Cutoff';
            Description = 'Interest Paid From the Loans Historical data';
        }
        field(99; "Interest Accrued Buffer"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Interest Accrued Buffer';
            Description = 'Tracks Daily Accrued Interest from Table 50159';
            Enabled = true;
        }
        field(100; "Days in Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Days in Arrears';
            Enabled = true;
        }
        field(101; "UnAllocated Funds"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Penalty Charged"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Tracks the Penaly charged and is yet to be paid';
            Enabled = true;
            Editable = false;
        }
        field(103; "Penalty Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(104; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = false;
        }
        field(105; "Last UnAllocated Funds"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(106; "Month Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Net Disbursement on Topup"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(108; "Total Payable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(109; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(110; "Installment No"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(150; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(151; "Bank Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = false;
        }
        field(152; "Bank Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(153; "Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = false;
        }
        field(154; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(155; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(156; "Bank Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(157; "Bank Name 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = false;
        }
        field(158; "Bank Branch 2"; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(159; "Bank Branch Name 2"; Text[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = false;
        }
        field(160; "Bank Account No. 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(161; "Swift Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(162; "RM Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            trigger OnValidate()
            var
                ObjDimension: Record "Dimension Value";
            begin
                ObjDimension.Reset();
                ObjDimension.SetRange(ObjDimension.Code, "RM Code");
                if ObjDimension.FindSet then begin
                    "RM Name" := ObjDimension.Name;
                end;
            end;
        }
        field(163; "RM Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(164; "Fee Collection Rate(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(165; "Maximum Possible DBR(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(166; "Profitability Margin(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(167; "Appraised Obligations Monthly"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(168; "Offer Letter Addresee Details"; Text[250])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(169; "ABB Bank1 Details"; Text[150])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(170; "ABB Bank2 Details"; Text[150])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(171; "ABB Bank3 Details"; Text[150])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(174; "Total Annual Fee Income"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
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
            Enabled = true;
        }
        field(178; "Qualifying Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'The Amount One Can Qualify for';
            Enabled = true;
        }
        field(179; "Annual Net Fee Income"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(180; "Monthly Net Fee Income"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(181; "Profitability Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(182; "Monthly Maximum Profitablity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(183; "Net Appraised Monthly Income"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(184; "Max EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(185; "Max ABB Qualifying Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(186; "ABB Total Bank 1"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(187; "ABB Total Bank 2"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(188; "ABB Total Bank 3"; Decimal)
        {
            DataClassification = ToBeClassified;
            enabled = true;
        }
        field(189; "Cumulative ABB"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(190; "Max ABB EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(191; "Max Qualification By Cashflow"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(192; "BO Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            enabled = true;
            Description = 'Tracks Members whose Accruals are to be done on either 15th or 20th';
            TableRelation = "BO Group".Code;
        }
        field(193; "Loan Processing Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = false;
        }
        field(194; "Credit Life Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = false;
        }
        field(195; "Credit Life Type"; Option)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            OptionMembers = Spouse,"Non-Spouse";
            OptionCaption = 'Spouse,"Non-Spouse"';
        }
        field(196; "Credit Life Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            // Editable = false;
        }
        // Replaced by Outstanding Suspense Interest
        field(197; "Outstanding Suspense Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(198; "Outstanding Write Off"; Decimal)
        {
            DataClassification = ToBeClassified;
            enabled = true;
        }
        field(199; "Outstanding Suspense Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(200; "Total Write Off"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(201; "Total Write Off Recoveries"; Decimal)
        {
            DataClassification = ToBeClassified;
            enabled = true;
        }
        field(222; "ED Loan Account No"; Code[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = false;
        }
        field(223; "Term1 Details"; Text[50])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(224; "Term2 Details"; Text[50])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(225; "Term3 Details"; Text[50])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(226; "Term1 Cash Receipt"; Decimal)
        {
            DataClassification = ToBeClassified;
            enabled = true;
        }
        field(227; "Term2 Cash Receipt"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(228; "Term3 Cash Receipt"; Decimal)
        {
            DataClassification = ToBeClassified;
            enabled = true;
        }
        field(229; "Gross Fee Report"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(230; "Net Fee Receipt"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(231; "Maximum EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = TRUE;
        }
        field(232; "Existing EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(233; "Ed Partners EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(234; "Max Qualifying Cash Collection"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(235; "Loan Perfection Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(236; "Loan Prepayments"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'Loan Repayments on Disbursement';
        }
        field(237; "End Use Status"; Option)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            OptionMembers = Open,Pending,Done;
            OptionCaption = 'Open,Pending,Done';

        }
        field(238; "New Basic Pay"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Payslip.Amount where("Loan Number" = field("Loan Number"), "Payslip Item Type" = const("Basic pay")));
            Editable = false;
            Caption = 'Basic Pay';
        }
        field(239; "New Total Allowance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Payslip.Amount where("Loan Number" = field("Loan Number"), "Payslip Item Type" = const(Allowance)));
            Caption = 'Total Allowance';
        }
        field(240; "New Gross Salary"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Payslip.Amount where("Loan Number" = field("Loan Number"), "Payslip Item Type" = filter("Basic pay" | Allowance)));
            Caption = 'Gross Salary';

        }
        field(241; "New Provident Fund"; Decimal)
        {
            Editable = false;
            Caption = 'Provident Fund';
            FieldClass = FlowField;
            CalcFormula = sum(Payslip.Amount where("Loan Number" = field("Loan Number"), "Payslip Item Type" = const(Provident)));
        }
        field(242; "New Other Deductions"; Decimal)
        {
            Editable = false;
            Caption = 'Other Deductions';
            FieldClass = FlowField;
            CalcFormula = sum(Payslip.Amount where("Loan Number" = field("Loan Number"), "Payslip Item Type" = const("Other Deduction")));
        }
        field(243; "New Satutory Deductions"; Decimal)
        {
            Caption = 'Statutory Deductions';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Payslip.amount where("Loan Number" = field("Loan Number"), "Payslip Item Type" = const("Statutory Deduction")));
        }
        field(244; "New Guaranteed Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Guarantors Table"."Guaranteed Amount" where("Loan Number" = field("Loan Number")));
            Caption = 'Max Qualification by Guarantor';
        }
        field(245; "New Relief"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(Payslip.Amount where("Loan Number" = field("Loan Number"), "Payslip Item Type" = const(Relief)));
        }
        field(246; "New Collateral Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Loan Collateral Details"."Amount To Commit" where("Loan No" = field("Loan Number")));
            Caption = 'Max Qualification by Colateral';
        }
        field(247; "New Amount Disbursed"; Decimal)
        {
            Description = 'Tracks the Amount Disbursed and that yet to be disbursed';
            FieldClass = FlowField;
            CalcFormula = sum("Loan Disbursement"."Amount to Disburse" where("Loan No" = field("Loan Number"), Status = filter(Posted), "Posting Date" = field("Date Filter")));
        }
        field(248; "New OutstandinSuspense Penalty"; Decimal)
        // Replaces Outstanding Suspense Penalty
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed BO Ledger Entry".Amount where("Loan Number" = field("Loan Number"), "Transaction Type" = filter("Penalty Suspense Charged" | "Penalty Suspense Paid"), "Posting Date" = field("Date Filter")));
        }
        // Replaces Outstanding Suspense Rate
        field(249; "Outstanding Suspense Interest"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed BO Ledger Entry".Amount where("Loan Number" = field("Loan Number"), "Transaction Type" = filter("Interest Suspense Due" | "Interest Suspense Paid"), "Posting Date" = field("Date Filter")));
        }
        field(250; "New Outstanding Loan"; Decimal)
        {
            // Replaces Outstanding Loan
            // FieldClass = FlowField;
            // CalcFormula = sum("Detailed BO Ledger Entry".Amount where("Loan Number" = field("Loan Number"), "Transaction Type" = filter(Loan | "Principal Repayment" | "Write Off"), "Posting Date" = field("Date Filter")));
            // Description = 'Tracks the outstanding Principal balance of a Loan as per the Date Filter (If Filtering date is not passed, the Default is TODAY)';
            // Editable = false;
            // 
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Member Number"), "Transaction Type" = filter("Loan" | "Principal Repayment")));
        }
        field(251; "New Outstanding Penalty"; Decimal)
        {
            // Replaces Outstanding Penalty
            FieldClass = FlowField;
            CalcFormula = sum("Detailed BO Ledger Entry".Amount where("Loan Number" = field("Loan Number"), "Transaction Type" = filter("Penalty Charged" | "Penalty Paid"), "Posting Date" = field("Date Filter")));
            Editable = false;
            Description = 'Tracks the Penalty charged and is yet to be paid';
        }
        field(252; "New Interest Due"; Decimal)
        {
            // Replaces Interest Due
            FieldClass = FlowField;
            CalcFormula = sum("Detailed BO Ledger Entry".Amount where("Loan Number" = field("Loan Number"), "Transaction Type" = filter("Interest Due"), "Posting Date" = field("Date Filter")));
        }
        field(253; "New Interest Paid"; Decimal)
        {
            // Replaces Interest Paid
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed BO Ledger Entry".Amount where("Loan Number" = field("Loan Number"), "Transaction Type" = filter("Interest Paid"), "Posting Date" = field("Date Filter")));
        }
        field(254; "New Outstanding Interest"; Decimal)
        {
            // Replaces Outstanding Interest
            FieldClass = FlowField;
            CalcFormula = sum("Detailed BO Ledger Entry".Amount where("Loan Number" = field("Loan Number"), "Transaction Type" = filter("Interest Due" | "Interest Paid"), "Posting Date" = field("Date Filter")));
            Editable = false;
            Description = 'Tracks the outstanding Accrued Interest balance of a Loan as per the Date Filter (If Filtering date is not passed, the Default is TODAY). Interest Accrued - Interest Paid';
        }
        field(255; "New Principal Paid"; Decimal)
        {
            // Replaces Principal Paid
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed BO Ledger Entry".Amount where("Loan Number" = field("Loan Number"), "Transaction Type" = filter("Principal Repayment"), "Posting Date" = field("Date Filter")));
        }
        field(256; "New PrincipalPaid as at Cutoff"; Decimal)
        {
            // Replaces Principal Paid As At Cutoff
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed BO Ledger Entry".Amount where("Loan Number" = field("Loan Number"), "Transaction Type" = filter("Principal Repayment"), "Posting Date" = field("Date Filter")));
        }
        field(257; "New Last Payment Date"; Date)
        {
            // Replaces Last Payment Date
            FieldClass = FlowField;
            CalcFormula = max("Detailed BO Ledger Entry"."Posting Date" where("Loan Number" = field("Loan Number"), "Transaction Type" = filter("Principal Repayment" | "Interest Paid" | "Penalty Paid"), "Posting Date" = field("Date Filter"), Reversed = filter(false)));
        }
        field(258; "Loan Sector"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(259; "Level 1"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(260; "Level 2"; Text[70])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loans Sectors Lv2"."Level Two Name";
            trigger OnValidate()
            var
                loansectorlv2: Record "Loans Sectors Lv2";
            begin
                loansectorlv2.Reset();
                loansectorlv2.SetRange("Level Two Name", "Level 2");
                // if loansectorlv2.Get("Level 2") then begin
                if loansectorlv2.Find('-') then begin
                    "Loan Sector" := loansectorlv2."Sector Code";
                    "Level 1" := loansectorlv2."Level One Name";
                end;
            end;
        }
        field(261; "First Defaulter Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(262; "Second Defaulter Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(263; "Received Message"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(264; "Received Email"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(265; "Last Updated"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(266; "Third Defaulter Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }







    }

    keys
    {
        key(Key1; "Loan Number")
        {
            Clustered = true;
        }
        key(key2; "Loan Balance")
        {

        }
        key(key3; "ED Loan Account No")
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Loan Number", "ED Loan Account No", "Member Number", "Full Name", "Applied Amount", "Approved Amount", "UnAllocated Funds")
        {

        }
    }
    procedure QualifyBySalary()
    begin
        Clear("Max Qualification By Salary");
        if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then
            "Max Qualification By Salary" := "Net Available Amount" / ((1 / Installments) + ("Interest Rate" / 1200));
        if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then
            "Max Qualification By Salary" := "Net Available Amount" / ((1 / Installments) + ("Interest Rate" / 1200));
        if "Interest Calculation Method" = "Interest Calculation Method"::Amortized then
            "Max Qualification By Salary" := "Net Available Amount" * ((POWER((1 + "Interest rate" / 1200), Installments) - 1) / (("Interest rate" / 1200) * (POWER((1 + "Interest rate" / 1200), Installments))));
    end;

    procedure FnGetProcessingFees() Proc_fees: Decimal
    begin
        ObjLoanCharge.Reset();
        ObjLoanCharge.SetRange(ObjLoanCharge.Code, 'PROC_FEE');
        if ObjLoanCharge.Find('-') then begin
            if ObjLoanCharge."Use Percentage" then
                LoanFees := (ObjLoanCharge.Percentage * "Approved Amount") / 100
            else
                LoanFees := ObjLoanCharge.Amount;
        end;
        exit(LoanFees);
    end;

    procedure FnRecommendedAmount(RequestedAmount: Decimal; QShares: Decimal; QGuarantors: Decimal; QSalary: Decimal; Qcollateral: Decimal) RecommendedAmount: Decimal
    begin
        RecommendedAmount := RequestedAmount;
        if ObjLoanProducts.get("Loan Product") then begin
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
            if ((ObjLoanProducts."Qualify by Guarantors") and (ObjLoanProducts."Qualify by Salary") and (ObjLoanProducts."Qualify by Dividend")) then begin
                if RecommendedAmount > QSalary then
                    RecommendedAmount := QSalary;
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
                if RecommendedAmount > QGuarantors then
                    RecommendedAmount := QGuarantors;
            end;
        end;
        if RecommendedAmount < 0 then
            RecommendedAmount := 0;
        exit(RecommendedAmount);
    end;

    procedure FnClearRecordFields()
    begin
        CLEAR("Loan Product");
        VALIDATE("Loan Product");
        CLEAR("Applied Amount");
        CLEAR("Net Pay");
        CLEAR("Deposits Balance");
        CLEAR("Bank Code");
        CLEAR("Bank Name");
        CLEAR("Bank Branch");
        CLEAR("Bank Branch Name");
        CLEAR("Bank Account No.");
        CLEAR("Swift Code");
        CLEAR("Bank Code 2");
        CLEAR("Bank Name 2");
        CLEAR("Bank Branch 2");
        CLEAR("Bank Branch Name 2");
        CLEAR("Bank Account No. 2");
        CLEAR("Swift Code 2");
        CLEAR("ID Number");
    end;

    procedure FnClearRelatedTables()
    var
        ObjGuarantors: Record "Guarantors Table";
        ObjPayslip: Record Payslip;
    begin
        // Clear Guarantors Table
        ObjGuarantors.Reset();
        ObjGuarantors.SetRange("Loan Number", "Loan Number");
        ObjGuarantors.DeleteAll();
        // Clear Payslip Table
        ObjPayslip.Reset();
        ObjPayslip.SetRange("Loan Number", "Loan Number");
        ObjPayslip.DeleteAll();
    end;

    var
        myInt: Integer;

        ObjLoanCharge: Record "Loan Charge Setup";
        LoanFees: Decimal;
        ObjLoanProducts: Record "Loan Products";

    trigger OnInsert()
    var
        recBoGeneralSetup: Record "BO General Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;
        ObjLoanProducts: Record "Loan Products";
    begin
        if "Loan Number" = '' then begin
            recBoGeneralSetup.Get();
            recBoGeneralSetup.TestField(recBoGeneralSetup."BO Loan Nos");
            NoSeriesMngt.InitSeries(recBoGeneralSetup."BO Loan Nos", recBoGeneralSetup."BO Loan Nos", 0D, "Loan Number", recBoGeneralSetup."BO Loan Nos");
            "Created By" := UserId;
            "Application Date" := today;
            // 
            // 

        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        if "Loan Number" <> '' then
            Error('This Entry Can Not be Deleted.Contact Your System Administrator');
    end;

    trigger OnRename()
    begin

    end;

}