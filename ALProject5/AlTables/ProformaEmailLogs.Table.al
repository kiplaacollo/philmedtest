table 50027 "Pro-forma Email Logs"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Proforma INV Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Sent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Time Sent"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Email; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Disconnection Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Days to Disconnection"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Customer Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Max,Biz,EOS,Spots';
            OptionMembers = " ",HSB,Enterprise,EOS,Merchant;
        }
        field(15; Skipped; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Source; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Title; Code[100])
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
        key(Key2; "Proforma INV Number")
        {
        }
        key(Key3; Source)
        {
        }
    }

    fieldgroups
    {
    }
}

