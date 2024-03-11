table 50142 Payslip
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Loan Number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loanee Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Payslip Item"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payslip Items Setup Table"."Payslip Item";
            trigger OnValidate()
            var
                ObjPayslipSetup: Record "Payslip Items Setup Table";
            begin
                ObjPayslipSetup.SetRange("Payslip Item", "Payslip Item");
                if ObjPayslipSetup.Find('-') then begin
                    "Payslip Item Type" := ObjPayslipSetup."Payslip Item Type";
                    Taxable := ObjPayslipSetup.Taxable;
                end;

            end;
        }
        field(5; "Payslip Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Basic pay",Allowance,"Statutory Deduction","Other Deduction",Provident,Relief;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                totaltax: Decimal;
                payslip: Record Payslip;
                loans: Record Loans;
                totalDeductions: Decimal;
                paye: Decimal;
                CFTFactory: Codeunit "CFT Factory";
            begin
                totaltax := 0;
                payslip.Reset();
                payslip.SetRange(payslip."Loan Number", "Loan Number");
                if payslip.Find('-') then begin
                    repeat
                        totaltax := totaltax + payslip.Amount;
                    until payslip.Next = 0;
                end;

                totalDeductions := 0;
                paye := 0;
                paye := CFTFactory.FnCalculatePaye(totaltax);
                if loans.Get("Loan Number") then begin
                    loans.CalcFields(loans."New Gross Salary", loans."New Provident Fund", loans."New Satutory Deductions", loans."New Other Deductions", loans."New Basic Pay");

                    loans."Taxable Pay" := totaltax;
                    loans.PAYE := paye;
                    totalDeductions := (loans.PAYE + loans."New Satutory Deductions" + loans."New Other Deductions" + loans."New Provident Fund");
                    loans."Net Pay" := (loans."New Gross Salary" - totalDeductions);
                    // 
                    // loans."1/3 Basic" := (1 / 3 * loans."New Basic Pay");
                    // loans."Gross Available Amount" := loans."Net Pay" - loans."1/3 Basic";
                    // loans."Net Available Amount" := loans."Gross Available Amount";
                    // if loans."Interest Calculation Method" = loans."Interest Calculation Method"::"Straight Line" then
                    //     loans."Max Qualification By Salary" := loans."Net Available Amount" / ((1 / loans.Installments) + (loans."Interest Rate" / 1200));
                    // if loans."Interest Calculation Method" = loans."Interest Calculation Method"::"Reducing Balance" then
                    //     loans."Max Qualification By Salary" := loans."Net Available Amount" / ((1 / loans.Installments) + (loans."Interest Rate" / 1200));
                    // if loans."Interest Calculation Method" = loans."Interest Calculation Method"::Amortized then
                    //     loans."Max Qualification By Salary" := loans."Net Available Amount" * ((POWER((1 + loans."Interest rate" / 1200), loans.Installments) - 1) / ((loans."Interest rate" / 1200) * (POWER((1 + loans."Interest rate" / 1200), loans.Installments))));
                    // loans."Appraisal Date" := Today;
                    loans.Modify();
                    Rec."Loanee Number" := loans."Member Number";
                end;


            end;
        }
        field(7; Taxable; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No", "Loan Number", "Loanee Number")
        {
            Clustered = true;
        }
    }
    procedure QualifyBySalary()
    begin

        if loans."Interest Calculation Method" = loans."Interest Calculation Method"::"Reducing Balance" then
            loans."Max Qualification By Salary" := loans."Net Available Amount" / ((1 / loans.Installments) + (loans."Interest Rate" / 1200));
    end;

    var
        myInt: Integer;
        loans: record Loans;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}