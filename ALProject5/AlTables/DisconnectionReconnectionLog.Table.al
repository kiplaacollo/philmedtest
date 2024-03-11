table 50025 "Disconnection/Reconnection Log"
{

    fields
    {
        field(1; EntryNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(3; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Disconnection,Reconnection';
            OptionMembers = Disconnection,Reconnection;
        }
        field(5; Synced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Disconnection/Reconnection Dat"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Time Added"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Time Updated"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Needs Manual Action"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Customer Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,HSB,Enterprise,EOS,Merchant';
            OptionMembers = " ",HSB,Enterprise,EOS,Merchant;
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

