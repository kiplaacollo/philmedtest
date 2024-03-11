table 50434 "Loan Product Setup"
{

    fields
    {
        field(1; "Product type"; Code[26])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Interest Rate"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Installments; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Repayment Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Straight Line,Amortised,Reducing Balance,Constants';
            OptionMembers = "Straight Line",Amortised,"Reducing Balance",Constants;
        }
        field(5; "Loan Account"; Code[28])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(6; "Interest Account"; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Product type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

