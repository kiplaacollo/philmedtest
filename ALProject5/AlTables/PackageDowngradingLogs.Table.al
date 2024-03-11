table 50015 "Package Downgrading Logs"
{

    fields
    {
        field(1; "Entry Id"; Integer)
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
        field(4; "Previous Package"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "DownGraded Package"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "splynx updated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Splynx Service ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'UpGrade,DownGrade,Change,Promotion';
            OptionMembers = UpGrade,DownGrade,Change,Promotion;
        }
        field(10; "Invalid Record"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Transaction Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Amount Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Existing overpayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Package Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Transaction Date" := Today;
    end;
}

