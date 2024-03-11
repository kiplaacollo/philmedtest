table 50107 "Loan Products"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = true;

        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = true;
        }
        field(3; "Interest Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Armotized,"Reducing Balance","Straight Line",Discounted;
            OptionCaption = 'Armotized,Reducing Balance,Straight Line,Discounted';
        }
        field(4; "Max Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(5; "Max Installments"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = TRUE;
        }
        field(6; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Monthly,Quarterly,BiMonthly,Weekly,Daily;
            OptionCaption = 'Monthly,Quarterly,BiMonthly,Weekly,Daily';
        }
        field(7; "Min Guarantors"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(8; "Max Guarantors"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            Enabled = true;
        }
        field(9; "Recovery Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Check Off",Salary;
            OptionCaption = 'Check Off,Salary';
            Enabled = true;
        }
        field(10; "Min Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;

        }
        field(11; "Max Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(12; "Deposit Factor"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(13; "Qualify by Deposits"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(14; "Qualify by Salary"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;

        }
        field(15; "Qualify by Guarantors"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(16; "Qualify by Dividend"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(17; "Activity Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".code where("Global Dimension No." = const(1));
        }
        field(18; "Penalty Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(19; "Min Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(30; "Loan Book Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(false), "Account Type" = const(Posting));

        }
        field(31; "Interest Receivable Account"; Code[50])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(false), "Account Type" = const(Posting));
        }
        field(32; "Interest Income Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true), "Account Type" = const(Posting));

        }
        field(33; "Allow Self Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(34; "Penalty Income Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true), "Account Type" = const(Posting));
            Enabled = true;
        }
        field(35; "Penalty Receivable Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(false), "Account Type" = const(Posting));
            Enabled = true;
        }
        field(36; "Penalty Calculation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Principle,Interest,"Principle + Interest","Principle + Interest + Penalty";
            Enabled = true;
        }
        field(37; "Interest Receivable Suspense"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
            Description = 'This is for interest Accrued for the Loans defaulted for more than 90 days.It is Debited, on Interst Accrual and the credit Goes to the Interest Liability Ac. If Paid then Credited and bank Debited';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(false), "Account Type" = const(Posting));
        }
        field(38; "Interest Suspense Liability Ac"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'This is the Balancing Account for defaulted Interest. It is Credited on Accrual and if the client pays, It is debited and the Interest Income Account Credited';
            Enabled = true;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true), "Account Type" = const(Posting));
        }
        field(39; "Penalty Receivable Suspense"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'This is for Penalty Accrued for the Loans defaulted for more than 90 days.It is Debited, on Penalty Accrual and the credit Goes to the Penalty Liability Ac. If Paid then Credited and bank Debited';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(false), "Account Type" = const(Posting));
            Enabled = true;
        }
        field(40; "Penalty Suspense Liability Ac"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'This is the Balancing Account for defaulted Penalty. It is Credited on Accrual and if the client pays, It is debited and the Penalty Income Account Credited';
            Enabled = true;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true), "Account Type" = const(Posting));
        }
        field(41; "Write Off Provision Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'This is the G/L Where the write off Amount goes on write off.';
            Enabled = true;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true), "Account Type" = const(Posting));
        }
        field(42; "Write Off Recoveries Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'Where Any recoveries done for written off loans are reported';
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true), "Account Type" = const(Posting));
        }
        field(43; "Repayment Bounce Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(44; "Qualify by Collateral"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }



    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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