table 50029 "BO Receipt Header.al"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Client Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Member Posting Group" = filter('BO'));
            trigger OnValidate()
            begin
                FnClearReceiptLines("No.");
                BOAccounts.Reset();
                BOAccounts.SetRange(BOAccounts."No.", "Client Code");
                if BOAccounts.Find('-') then begin
                    "Client Name" := BOAccounts."Full Name";
                end;
            end;
        }
        field(3; "Client Name"; Text[70])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Pay Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Cash,Cheque,RTGS;
        }
        field(5; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Paying Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            var
                BankAccount: Record "Bank Account";
            begin
                BankAccount.Reset();
                BankAccount.SetRange(BankAccount."No.", "Paying Bank");
                if BankAccount.Find('-') then begin
                    "Paying Bank Name" := BankAccount.Name;
                end;

            end;
        }
        field(11; "Paying Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Payoff; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Payoff Loan No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan Number" where("Member Number" = field("Client Code"));
        }
        field(17; "Cutoff Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Reversed by"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; Prepayments; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Detailed BO Ledger Entry".Amount where("UnAllocated Account No" = field("Client Code"), "Transaction Type" = filter("UnAllocated Funds")));
        }
        field(50006; "Recover All time Balances"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Loan Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan Number" where("Member Number" = field("Client Code"));
            trigger OnValidate()
            var
                loans: Record Loans;
            begin
                loans.Reset();
                loans.SetRange(loans."Loan Number", "Loan Number");
                if loans.Find('-') then begin
                    "Loan Product" := loans."Loan Product";
                end;
            end;
        }
        field(50008; "Clear Specific Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Loan Product"; Code[100])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    procedure FnClearReceiptLines(No: Code[20])
    begin
        BOReceiptLine.Reset();
        BOReceiptLine.SetRange(BOReceiptLine."No.", No);
        if BOReceiptLine.FindSet() then begin
            BOReceiptLine.DeleteAll();
        end;
    end;

    var
        myInt: Integer;
        BOGenSetup: Record "BO General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BOReceiptLine: Record "BO Receipt Line";
        BOAccounts: Record Customer;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            BOGenSetup.Get();
            BOGenSetup.TestField(BOGenSetup."BO Member Receipt");
            NoSeriesMgt.InitSeries(BOGenSetup."BO Member Receipt", BOGenSetup."BO Member Receipt", 0D, "No.", BOGenSetup."BO Member Receipt");
        end;
        "Transaction Date" := Today;
        "Captured By" := UserId;
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