table 50034 "Savings Products Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Basic Information';

        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Global Dimension 1"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Account Prefix"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Product Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Dormancy Period(M)"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Maximum Withdrawable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Minimum Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Maximum Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Is Default Account"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Check Controls';
        }
        field(23; "Can Earn Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Requires Initial Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Can Allow Loan Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Can Fix Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Requires Closure Notice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Is Current Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Charges and Commission';
        }
        field(51; "Account Opening Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Tax on Interest %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Maintenance Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Re-activation Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Pre-Mature Withdrawal Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Minimum Savings Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Description = 'Account Durations';
        }
        field(71; "Minimum Interest Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Minimum Withdrawal Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Closure Notice Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Product Control GL"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Direct Posting" = const(false), Blocked = const(false), "Account Type" = const(Posting));
            Description = 'G/L Accounts';
        }
        field(140; "Modified by"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(141; "Date Modified"; Date)
        {
            DataClassification = ToBeClassified;
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