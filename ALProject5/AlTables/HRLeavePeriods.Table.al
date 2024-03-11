table 50443 "HR Leave Periods"
{

    fields
    {
        field(1; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
                Name := Format("Starting Date", 0, Text000);
            end;
        }
        field(2; Name; Text[10])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "New Fiscal Year"; Boolean)
        {
            Caption = 'New Fiscal Year';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Date Locked", false);
            end;
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Date Locked"; Boolean)
        {
            Caption = 'Date Locked';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Reimbursement Clossing Date"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Period Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Period Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label '<Month Text>';
}

