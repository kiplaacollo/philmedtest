table 50224 "Loan Notifications Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loan Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Member Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Amount In Arrears"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date Issued"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Notification Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","First Defaulter Notification","Second Defaulter Notification","Third Defaulter Notification";
        }
        field(10; "Notification Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Repayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Mobile Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Phone Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Received Message"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Received Email"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Last Date Notified"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Guaranteed Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Guarantors Table"."Guaranteed Amount" where("Loan Number" = field("Loan Number")));
        }
    }

    keys
    {
        key(Key1; "Document No", "Entry No")
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