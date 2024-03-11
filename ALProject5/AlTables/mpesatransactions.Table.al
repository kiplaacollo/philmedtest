table 50008 mpesa_transactions
{

    fields
    {
        field(1; id; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; mpesa_ref; Code[100])
        {
            Caption = 'Mpesa Reference No.';
            DataClassification = ToBeClassified;
        }
        field(3; trans_time; DateTime)
        {
            Caption = 'Transaction Time';
            DataClassification = ToBeClassified;
        }
        field(4; trans_amt; Decimal)
        {
            Caption = 'Transaction Amount';
            DataClassification = ToBeClassified;
        }
        field(5; short_code; Code[100])
        {
            Caption = 'Short Code';
            DataClassification = ToBeClassified;
        }
        field(6; acc_no; Code[100])
        {
            Caption = 'Account No';
            DataClassification = ToBeClassified;
        }
        field(7; phone_no; Code[100])
        {
            Caption = 'Phone Number';
            DataClassification = ToBeClassified;
        }
        field(8; payer; Code[100])
        {
            Caption = 'Payer';
            DataClassification = ToBeClassified;
        }
        field(9; trans_type; Code[100])
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
        }
        field(10; org_balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; created_at; DateTime)
        {
            Caption = 'Created At';
            DataClassification = ToBeClassified;
        }
        field(12; updated_at; DateTime)
        {
            Caption = 'Update At';
            DataClassification = ToBeClassified;
        }
        field(13; processed; Boolean)
        {
            Caption = 'Processed';
            DataClassification = ToBeClassified;
        }
        field(14; is_non_customer; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CFTFactory: Codeunit "CFT Factory";
        TestCustomers: Record "Allowed Customers";
}

