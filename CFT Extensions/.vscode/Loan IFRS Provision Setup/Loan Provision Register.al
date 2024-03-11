table 50157 "Loan Provision Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            AutoIncrement = true;
        }
        field(2; Vintage; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "0 - 30 Days","31 - 60 Days","61 - 90 Days","91 - 120 Days","121 - 150 Days","151 - 270 Days","Above 270 Days";
            OptionCaption = '0 - 30 Days,"31 - 60 Days",61 - 90 Days,91 - 120 Days,121 - 150 Days,151 - 270 Days,Above 270 Days';
            Enabled = true;
        }
        field(3; "Provision Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(4; "Count"; Integer)
        {

            Enabled = true;
            DataClassification = ToBeClassified;

        }
        field(5; "Gross Carrying Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;

        }
        field(6; Classification; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            Enabled = true;
        }
        field(7; "No. of Accounts"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(8; "Outstanding Loan Portfolio"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(9; "Required Provision"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(10; "Standard Classification"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(11; "Balance Above 90 Days"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(20; "Expected Credit Loss"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
    }

    keys
    {
        key(Key1; "Entry No")
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