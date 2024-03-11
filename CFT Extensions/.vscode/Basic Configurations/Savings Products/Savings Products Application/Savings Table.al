table 50552 "Savings Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Savings No"; Code[100])
        {
            DataClassification = ToBeClassified;


        }
        field(2; "BO Application No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Savings Product"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Products Setup";
        }
        field(4; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Joint,Group,Corporate;
        }
        field(6; "Monthly Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Savings No")
        {
            Clustered = true;
        }
        key(key2; "BO Application No")
        {

        }
    }

    var
        myInt: Integer;
        recBoGeneralSetup: Record "BO General Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "Savings No" = '' then begin
            recBoGeneralSetup.Get();
            recBoGeneralSetup.TestField(recBoGeneralSetup."Savings Account Nos");
            NoSeriesMngt.InitSeries(recBoGeneralSetup."Savings Account Nos", recBoGeneralSetup."BO Application Nos", 0D, "Savings No", recBoGeneralSetup."Savings Account Nos");
        end;
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