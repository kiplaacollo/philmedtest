table 50122 "BO Accounts Kins"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "BO Application No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Full Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Relationship Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Wife,Husband,Brother,Sister,Father,Mother,Cousin,Nephew,Uncle,Aunt,Son,Daughter;

        }
        field(4; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Is Beneficiary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Is Dependant"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Phone Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Percentage Allocation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "BO Application No")
        {
            Clustered = true;
        }
        key(key2; "Full Name")
        {

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