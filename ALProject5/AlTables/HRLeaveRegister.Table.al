table 50447 "HR Leave Register"
{

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "From Entry No."; Integer)
        {
            Caption = 'From Entry No.';
            DataClassification = ToBeClassified;
        }
        field(3; "To Entry No."; Integer)
        {
            Caption = 'To Entry No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                LoginMgt.LookupUserID("User ID");
            end;
        }
        field(7; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

