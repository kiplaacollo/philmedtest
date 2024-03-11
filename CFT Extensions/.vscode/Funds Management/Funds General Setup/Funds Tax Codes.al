table 50016 "Fund Tax Codes"
{
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Tax Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Account Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(13; "Account No"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" else
            if ("Account Type" = const(Customer)) Customer else
            if ("Account Type" = const(Vendor)) Vendor;
        }
        field(14; Percentage; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "W/Tax",VAT,Excise,Legal,Others,Retention;
        }
        field(16; "Account Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(17; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Tax Code")
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