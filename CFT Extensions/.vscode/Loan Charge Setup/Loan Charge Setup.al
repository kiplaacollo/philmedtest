table 50152 "Loan Charge Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(4; Percentage; Decimal)
        {
            DataClassification = CustomerContent;
            Enabled = true;
        }
        field(5; "G/L Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
            Enabled = true;
        }
        field(6; "Use Percentage"; Boolean)
        {
            DataClassification = CustomerContent;
            Enabled = true;
        }
        field(7; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            Enabled = true;
        }
        field(8; "Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No." else
            if ("Account Type" = const(Customer)) Customer."No." else
            if ("Account Type" = const(Vendor)) Vendor."No." else
            if ("Account Type" = const("Bank Account")) "Bank Account"."No.";
            Enabled = true;
        }
        field(9; "Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Enabled = true;
        }
        field(10; "Charge Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }


    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
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