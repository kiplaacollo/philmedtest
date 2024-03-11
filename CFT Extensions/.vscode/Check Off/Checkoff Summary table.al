table 52015 "Checkoff Summary Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(20; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Client Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Client Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Payroll Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Dev Prin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Dev Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Flexi Prin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Flexi Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Bridge Prin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Bridge Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Platinum Prin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Platinum Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Development Prin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Development Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Processing Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Registration Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Ordinary"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Junior; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Total; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Checkoff Adv Line".Amount where("Client Code" = field("Client Code"), "No." = field("No.")));
        }
        field(24; "Phone Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Entry No")
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
        checkoffsummary: Record "Checkoff Summary Table";
        checkoffline: Record "Checkoff Adv Line";

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