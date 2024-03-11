table 50111 "cr transaction types"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Transaction Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Select from"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(5; "Loan Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(6; "Global Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = " ","Registration Fees","Share Capital","Deposit Contribution","Book Fee","Group Dividends","Benevolent Fund","Unallocated Funds","Monthly Subscription Charge","Monthly Subscription Paid","USSD Charge","USSD Charge Paid","Loan","Interest Due","Interest Paid","Penalty Charged","Penalty Paid","Principal Repayment","Loan Form Fee","Interest Suspense Due","Interest Suspense Paid","Fosa Transaction","Holiday Deposits","Write Off","Ledger Fee","Processing Fee","Dividend","Interest On Deposits","Colletion Fee","Loan Insurance Charged","Loan Insurance Paid";
        }
        field(7; "Recovery Since Founding Date"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(8; "Recovery Priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Minimum Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Chargeable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Income Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Activity Code"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = BO,FO;
        }
        field(13; "Balances Transaction Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Contra Global Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Registration Fees","Share Capital","Deposit Contribution","Book Fee","Group Dividends","Benevolent Fund","Unallocated Funds","Monthly Subscription Charge","Monthly Subscription Paid","USSD Charge","USSD Charge Paid","Loan","Interest Due","Interest Paid","Penalty Charged","Penalty Paid","Principal Repayment","Loan Form Fee","Interest Suspense Due","Interest Suspense Paid","Fosa Transaction","Holiday Deposits","Write Off","Ledger Fee","Processing Fee","Dividend","Interest On Deposits","Colletion Fee","Loan Insurance Charged","Loan Insurance Paid";
        }
        field(15; "Unallocated Funds Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "USSD Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Show on Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Show on pv"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Show on Accruals"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Show on Checkoff Advice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Process Checkoff"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Takes Balance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Appears in Transaction report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Fosa Transaction"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes,No;
        }
        field(25; Debit; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Credit; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Has to Mature"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Days to Mature"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Include Holidays"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
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