table 50223 "Defaulter Notifications Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Document No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Notification Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","First Defaulter Notification","Second Defaulter Notification","Third Defaulter Notification";
        }
        field(4; "Notification Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Date From"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Date To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Notification Type Period"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",All,Monthly;
        }
        field(8; Status; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No")
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
        recGeneralSetup: Record "Funds General Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        //Set Notification Doc No
        if "Document No" = '' then begin
            recGeneralSetup.Get();
            recGeneralSetup.TestField(recGeneralSetup."Defaulter Notification Nos");
            NoSeriesMngt.InitSeries(recGeneralSetup."Defaulter Notification Nos", recGeneralSetup."Defaulter Notification Nos", 0D, "Document No", recGeneralSetup."Defaulter Notification Nos");
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