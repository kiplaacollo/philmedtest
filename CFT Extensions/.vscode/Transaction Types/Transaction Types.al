table 50999 "Transation types "
{
    Caption = 'Transation types ';

    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Deposit Contribution","Share Capital","Benevolent Fund",Loan,"Principal Repayment","Interest Due","Interest Paid","Penalty Paid","Penalty Charged","UnAllocated Funds","Interest Suspense Due","Interest Suspense Paid","Write Off","Write Off Recoveries","Penalty Suspense Charged","Penalty Suspense Paid","Fosa Transaction","Loan Repayment","Registration Fees";

            ;
        }
        field(2; "Posting Group Code"; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(3; "Loan Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Products";
        }
    }

    keys
    {
        key(Key1; "Transaction Type")
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


