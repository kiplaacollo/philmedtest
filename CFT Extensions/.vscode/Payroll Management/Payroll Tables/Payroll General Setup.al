table 50428 "Payroll General Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; id; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; nssf_bands; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; minimum_taxable; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Paying Bank"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(5; "Payroll Liabilities Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting));
        }
        field(6; "NSSF Employer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting));
        }
        field(7; "NSSF Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Maximum Morgage Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Maximum Pension Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Personal Relief"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Housing Employer Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting));
        }
        field(13; "Housing Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; id)
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