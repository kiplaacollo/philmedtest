table 50438 "HR Leave Types"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[40])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Days; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Accrue Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Unlimited Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Both,Male,Female;
        }
        field(7; Balance; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Ignore,"Carry Forward","Convert to Cash";
        }
        field(8; "Inclusive of Holidays"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Inclusive of Saturday"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Inclusive of Sunday"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Off/Holidays Days Leave"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Max Carry Forward Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Inclusive of Non Working Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(15; "Carry Forward Allowed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Fixed Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Upload Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Code)
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