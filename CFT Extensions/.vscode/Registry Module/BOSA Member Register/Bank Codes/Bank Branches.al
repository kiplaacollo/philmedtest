table 50028 "Bank Branches"
{
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(10; "Bank Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Codes"."Bank Code";
            trigger OnValidate()
            var
                BankCodes: Record "Bank Codes";
            begin
                if BankCodes.Get("Bank Code") then "Bank Name" := BankCodes."Bank Name";
            end;
        }
        field(11; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Branch Physical Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Branch Postal Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Branch Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Branch Phone No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Branch Mobile No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Branch Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Bank Code")
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "Branch Code", "Branch Name")
        {

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