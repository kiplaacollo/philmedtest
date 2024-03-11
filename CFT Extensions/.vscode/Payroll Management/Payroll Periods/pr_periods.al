table 50429 "pr_periods"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "period_code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "start_date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "end_date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "period_month"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "period_year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; period_code)
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