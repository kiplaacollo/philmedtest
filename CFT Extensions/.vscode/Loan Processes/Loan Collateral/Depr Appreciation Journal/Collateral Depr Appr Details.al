table 50156 "Collateral Depr Appr Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Collateral Register"."Document No";
        }
        field(3; "Registered to"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "BO Accounts"."Member Number";
        }
        field(4; "Valuation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Appreciation,Depreciation;
        }
        field(5; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Valuation Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Voided; Boolean)
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