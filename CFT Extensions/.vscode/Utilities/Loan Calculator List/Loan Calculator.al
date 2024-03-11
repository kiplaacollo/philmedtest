table 50202 "Loan Calculator"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No"; code[30])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(2; "Calculator Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Instalment From Requested Amount","Qualifying Amount From Proposed Instalment","Eligibility Calculator";
            OptionCaption = '"Instalment From Requested Amount","Qualifying Amount From Proposed Instalment","Eligibility Calculator";';
            Enabled = true;
        }
        field(3; "Loan Type"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Products".Code;
            Enabled = true;
            trigger OnValidate()
            var
                ObjLoanType: Record "Loan Products";
            begin
                if ObjLoanType.Get("Loan Type") then begin
                    "Product Description" := ObjLoanType.Description;
                    "Interest Rate" := ObjLoanType."Max Interest Rate";
                    "Loan Tenure" := ObjLoanType."Max Installments";
                    "Repayment Method" := ObjLoanType."Interest Calculation Method";
                end;
            end;
        }
        field(4; "Product Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            trigger OnValidate()
            var
                ObjLoanType: Record "Loan Products";
            begin
                ObjLoanType.Get("Loan Type");
                if "Interest Rate" < ObjLoanType."Min Interest Rate" then
                    Error('The Interest Rate for %1 can not be less than %2', "Loan Type", ObjLoanType."Min Interest Rate");
                if "Interest Rate" > ObjLoanType."Max Interest Rate" then
                    Error('The Interest Rate for %1 can not be more than %2', "Loan Type", ObjLoanType."Max Interest Rate");
            end;
        }
        field(6; "Loan Tenure"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(7; "Requested Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(8; "Qualifying Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(9; "Monthly Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(10; "No of Students"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Average Fee Per Term"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Gross Fee Income"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Annual Net Fee Income"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Maximum Profitability Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Net Appraised Monthly Income"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Existing EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Varthana EMI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Rent; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Salaries; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "All Other Expenses"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Expected Instalment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Repayment Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Amortized,"Reducing Balance","Straight Line",Discounted;
            OptionCaption = 'Amortized,"Reducing Balance","Straight Line",Discounted';
        }
        field(23; "Fee Collection Efficiency(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Expense Calculation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "12 Months","9 Months",Mixed;
            OptionCaption = '"12 Months","9 Months",Mixed';
        }
        field(25; "Business Permit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Cost Of Meals"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Rent_multi"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Salaries_multi"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "All Other Expenses_multi"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Business Permit_multi"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Cost Of Meals_multi"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Repayment Debut Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Daily,Weekly,Monthly,Quarterly;
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly';
        }
        field(35; "No of Repayment Holidays"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "First Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37; "Disbursement Details"; Boolean)
        {
            DataClassification = ToBeClassified;
        }





    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        "Document No" := 'CALC_00001';
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