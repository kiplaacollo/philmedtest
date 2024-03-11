table 50557 "BO Accounts Kins Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "BO Application No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Full Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Relationship Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Wife,Husband,Brother,Sister,Father,Mother,Cousin,Nephew,Uncle,Aunt,Son,Daughter;

        }
        field(5; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Is Beneficiary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Is Dependant"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Phone Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Percentage Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "BO Application No", No)
        {
            Clustered = true;
        }
        // key(key2; "Full Name")
        // {

        // }
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