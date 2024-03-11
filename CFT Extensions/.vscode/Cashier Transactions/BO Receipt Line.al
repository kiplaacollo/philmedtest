table 50030 "BO Receipt Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Deposit Contribution","Share Capital","Benevolent Fund",Loan,"Principal Repayment","Interest Due","Interest Paid","Penalty Paid","Penalty Charged","UnAllocated Funds","Interest Suspense Due","Interest Suspense Paid","Write Off","Write Off Recoveries","Penalty Suspense Charged","Penalty Suspense Paid","Fosa Transaction";
            OptionCaption = ' ,Deposit Contribution,Share Capital,Benevolent Fund,Loan,Principal Repayment,Interest Due,Interest Paid,Penalty Paid,Penalty Charged,Prepayments,Interest Suspense Due,Interest Suspense Paid,Write Off,Write Off Recoveries,Penalty Suspense Charged,Penalty Suspense Paid,Fosa Transaction';
        }
        field(3; "Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan Number" where("Approval Status" = filter(Approved), "Member Number" = field("Client Code"));
            trigger OnValidate()
            begin
                ObjLoans.Reset();
                ObjLoans.SetRange(ObjLoans."Loan Number", "Loan No");
                if ObjLoans.Find('-') then
                    "Loan Product" := ObjLoans."Loan Product";
            end;
        }
        field(4; "Client Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "BO Accounts"."Member Number";
            trigger OnValidate()
            begin
                BOAccounts.Reset();
                BOAccounts.SetRange(BOAccounts."Member Number", "Client Code");
                if BOAccounts.Find('-') then begin
                    "Client Name" := BOAccounts."Full Name";
                end;
            end;
        }
        field(5; "Client Name"; Text[70])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(8; "Loan Product"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "ED Loan Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Loans."ED Loan Account No";
        }
        field(10; Payoff; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Recovery From UnAllocated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Savings Product"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Ordinary,Junior;

        }
        field(13; "Saving Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Products Setup";
        }

    }

    keys
    {
        key(Key1; "No.", "Entry No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        BOReceiptHeader: Record "BO Receipt Header.al";
        ObjLoans: Record Loans;
        BOAccounts: Record "BO Accounts";
        foaccounts: Record Customer;

    trigger OnInsert()
    begin
        BOReceiptHeader.Reset();
        BOReceiptHeader.SetRange(BOReceiptHeader."No.", "No.");
        if BOReceiptHeader.Find('-') then begin
            "Client Code" := BOReceiptHeader."Client Code";
            "Client Name" := BOReceiptHeader."Client Name";

        end;
        // foaccounts.Reset();
        // foaccounts.SetRange("BO No",);
        // if foaccounts.Find('-') then begin
        //     "Saving Product" := foaccounts."FO Account Type";
        // end;
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