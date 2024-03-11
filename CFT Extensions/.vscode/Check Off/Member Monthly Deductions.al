table 52010 "Member Monthly Deductions"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Client Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(2; "Transaction Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "cr transaction types table"."Transaction Type" where("Process Checkoff" = filter(true));
            trigger OnValidate()
            var
            // crtransactiontypes:Record "cr transaction types table";
            begin

            end;
        }
        field(3; "Fosa Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Fosa Account No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Client Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
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