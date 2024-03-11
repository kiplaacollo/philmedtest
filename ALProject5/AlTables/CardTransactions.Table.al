table 50024 "Card Transactions"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; cft_ref; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "customer No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; usd_amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; transaction_id; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; created_at; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Receipt No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
        key(Key2; transaction_id)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CFTFactory.FnGenerateInvoice("customer No", created_at, amount, transaction_id, "Receipt No", posted, 'CARD');
    end;

    var
        CFTFactory: Codeunit "CFT Factory";
        TestCustomers: Record "Allowed Customers";
}

