table 50110 "Loan Collateral Set-up"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[100])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Type; Option)
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            OptionMembers = Shares,Deposits,Collateral,"Fixed Deposit","Money Market","Tangible Asset","Children's Accounts",Land,Guarantors;

        }
        field(3; "Security Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; Category; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Cash,"Government Securities","Corporate Bonds",Equity,"Mortgage Securities","Fixed Deposit";
        }
        field(6; "Collateral Multiplier"; Decimal)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; Code, Type, "Security Description")
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