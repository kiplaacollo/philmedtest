table 50111 "Loan Management General Setup"
{

    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; "Loan Interest Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(3; "Loan Interest Journal Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Loan Interest Journal Template"));
        }
        field(4; "Loan Penalty Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(5; "Loan Penalty Journal Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Loan Penalty Journal Template"));
        }
        field(6; "Default Client Posting Group"; Code[10])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(7; "Default OverPay Posting Group"; Code[10])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(8; "Disbursement Date Determinant"; Integer)
        {
            MaxValue = 31;
            MinValue = 1;
        }
        field(9; "Loan Bill Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(10; "Loan Bill Journal Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Loan Bill Journal Template"));
        }
        field(11; "Cheque Clearance Days"; DateFormula)
        {
        }
        field(12; "Billing Day"; Integer)
        {
        }
        field(13; "Loan Prepay Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(14; "Loan Prepay Journal Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Loan Interest Journal Template"));
        }
        field(15; "Loans Manager Base Calendar"; Code[20])
        {
            TableRelation = "Base Calendar".Code;
        }
        field(16; "Maximum Profitability Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Maximum Possible DBR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "ABB EMI Ratio(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

