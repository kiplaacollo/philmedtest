table 50018 "SMS Messages"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Source; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Telephone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Date Entered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Time Entered"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Entered By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "SMS Message"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sent To Server"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Yes,Failed';
            OptionMembers = No,Yes,Failed;
        }
        field(9; "Date Sent to Server"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Time Sent To Server"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12; "Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Account No"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Customer.GET("Account No");
                //"Customer Category":=Customer."Customer Category";
            end;
        }
        field(14; "Batch No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Document No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "System Created Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Expected Disconnection Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Days To Disconnection"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Title; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; SourceId; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Customer Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,HSB,Enterprise,EOS,Merchant';
            OptionMembers = " ",HSB,Enterprise,EOS,Merchant;
        }
        field(22; "Expected end date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Days to end date"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Customer: Record Customer;
}

