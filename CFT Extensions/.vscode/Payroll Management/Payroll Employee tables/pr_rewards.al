table 50710 "pr_rewards"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "rm_band"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "lower_limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "upper_limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "chargable amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; rm_band)
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