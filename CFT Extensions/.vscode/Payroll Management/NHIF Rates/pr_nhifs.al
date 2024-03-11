table 50421 "pr_nhifs"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "nhif_band"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "lower_limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "upper_limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; nhif_band)
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