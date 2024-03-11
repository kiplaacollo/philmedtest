tableextension 52005 "Gen. Journal Line ext" extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Deposit Contribution","Share Capital","Benevolent Fund",Loan,"Principal Repayment","Interest Due","Interest Paid","Penalty Paid","Penalty Charged","UnAllocated Funds","Interest Suspense Due","Interest Suspense Paid","Write Off","Write Off Recoveries","Penalty Suspense Charged","Penalty Suspense Paid","Fosa Transaction","Loan Repayment","Registration Fees";
        }
        field(50002; "Loan Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Loans."Loan Number" where("Member Number" = field("Account No."));
        }
        field(50003; "Loan Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Interest; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Principal; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pending,Verified,Approved,Canceled;
        }
        field(50007; "User ID"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; Charge; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource."No.";
        }
        field(50010; "Calculate VAT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "VAT Value Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; Bank; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; Branch; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Invoice to Post"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Prepayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Trace ID"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Group Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Account Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Unallocated Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "BO Accounts"."Member Number";
        }
        field(50022; "Paid From Prepayments"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50023; "FOSA Product Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Products Setup".Code;
            // trigger OnValidate()
            // var
            //     loandisbursement: Record "Loan Disbursement";
            // begin
            //     case "Account Type" of
            //         "Account Type"::Member:
            //             GetFOProductCode;

            //     end;
            // end;
        }
        modify("Account No.")
        {
            TableRelation = if ("Account Type" = const(Member)) "BO Accounts"."Member Number";
            trigger OnBeforeValidate()
            begin
                case "Account Type" of
                    "Account Type"::Member:
                        GetFOProductCode;
                end;
            end;
        }


    }
    procedure GetFOProductCode()
    var
        BOAccounts: Record "BO Accounts";
        loandisbursement: Record "Loan Disbursement";
    begin
        BOAccounts.Get("Account No.");
        "FOSA Product Code" := BOAccounts."FO Account Type";
        // loandisbursement.Get(loandisbursement."Client No");
    end;

    [IntegrationEvent(true, false)]
    procedure OnMoveGenJournalLine(ToRecordID: RecordID)
    begin
    end;


    var
        myInt: Integer;
}
enumextension 50024 Member extends "Gen. Journal Account Type"
{
    value(50024; Member)
    {

    }
}
enumextension 50025 Members extends "Gen. Journal Source Type"
{
    value(50025; Member)
    {

    }
}