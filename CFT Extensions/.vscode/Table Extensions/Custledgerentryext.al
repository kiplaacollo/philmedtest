tableextension 50097 "Cust Ledger Entry Ext" extends "Cust. Ledger Entry"
{
    fields
    {

        // Add changes to table fields here

        field(50000; "Transaction Type"; Option)
        {

            OptionMembers = " ","Deposit Contribution","Share Capital","Benevolent Fund",Loan,"Principal Repayment","Interest Due","Interest Paid","Penalty Paid","Penalty Charged","UnAllocated Funds","Interest Suspense Due","Interest Suspense Paid","Write Off","Write Off Recoveries","Penalty Suspense Charged","Penalty Suspense Paid","Fosa Transaction";

        }

        field(50002; "Reversal Date"; Date)
        {
        }
        field(50003; "Transaction Date"; Date)
        {
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }

        field(50004; "Created On"; DateTime)
        {
        }
        field(500010; "Loan Product"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Loan Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Paid From Prepayments"; Boolean)
        {
            DataClassification = ToBeClassified;
        }



    }

    keys
    {
        key(Key5; "Transaction Type")
        {

        }
    }
}


