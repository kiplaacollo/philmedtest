table 50756 "Pesawise Lines"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Tag ID"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
            Enabled = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(4; "Vendor ID"; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", "Vendor ID");
                if Vendor.Find('-') then begin
                    "vendor name" := Vendor.Name;
                    "Vendor ID" := Vendor."No.";
                end;
                //    Vendor.GET("Vendor ID");
                // "vendor name":=Vendor.Name;
            end;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; refence; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "vendor name"; Text[100])
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
        Vendor: Record Vendor;
}

