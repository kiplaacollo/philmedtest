table 50106 "Common Direct Posting GL"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Description"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = "Withholding Tax","Exit Fee","ReEntrance Fee","Bridge Fee","Excise Duty","Top up Comission","New ATM Fee"
            ," Replaced ATM Fee","Renewed ATM Fee","Dividend Processing Fee","External Loan Charge","FO Registration Fee","BO Registration Fee","Cheque Discounting Comission";

        }
        field(2; "G/L Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
            trigger OnValidate()
            var
                ObjGLAccount: Record "G/L Account";
            begin
                if ObjGLAccount.Get("G/L Account") then
                    "G/L Account Name" := ObjGLAccount.Name;
            end;


        }
        field(3; "G/L Account Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(4; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Is Percentage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Percentage Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Last Modified Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Last Modified By"; Code[100])
        {

        }

    }

    keys
    {
        key(Key1; "G/L Account")
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
        "Last Modified By" := UserId;
        "Last Modified Date Time" := CurrentDateTime;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}