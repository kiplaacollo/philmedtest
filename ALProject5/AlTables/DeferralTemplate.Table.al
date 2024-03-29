table 1700 "Deferral Template"
{
    Caption = 'Deferral Template';
    LookupPageID = "Deferral Template List";
    ReplicateData = false;

    fields
    {
        field(1; "Deferral Code"; Code[10])
        {
            Caption = 'Deferral Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Deferral Account"; Code[20])
        {
            Caption = 'Deferral Account';
            NotBlank = true;
            TableRelation = "G/L Account" WHERE ("Account Type" = CONST (Posting),
                                                 Blocked = CONST (false));
        }
        field(4; "Deferral %"; Decimal)
        {
            Caption = 'Deferral %';
            DecimalPlaces = 0 : 5;
            InitValue = 100;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Deferral %" <= 0) or ("Deferral %" > 100) then
                    Error(DeferralPercentageErr);
            end;
        }
        field(5; "Calc. Method"; Option)
        {
            Caption = 'Calc. Method';
            OptionCaption = 'Straight-Line,Equal per Period,Days per Period,User-Defined';
            OptionMembers = "Straight-Line","Equal per Period","Days per Period","User-Defined";
        }
        field(6; "Start Date"; Option)
        {
            Caption = 'Start Date';
            OptionCaption = 'Posting Date,Beginning of Period,End of Period,Beginning of Next Period';
            OptionMembers = "Posting Date","Beginning of Period","End of Period","Beginning of Next Period";
        }
        field(7; "No. of Periods"; Integer)
        {
            BlankZero = true;
            Caption = 'No. of Periods';
            MinValue = 1;

            trigger OnValidate()
            begin
                if "No. of Periods" < 1 then
                    Error(NumberofPeriodsErr);
            end;
        }
        field(8; "Period Description"; Text[100])
        {
            Caption = 'Period Description';
        }
        field(9; "Defferal Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Defferal,Other';
            OptionMembers = " ",Defferal,Other;
        }
    }

    keys
    {
        key(Key1; "Deferral Code")
        {
            Clustered = true;
        }
        key(Key2; "Deferral Account")
        {
            MaintainSIFTIndex = false;
        }
        key(Key3; "Defferal Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        GLAccount: Record "G/L Account";
        Item: Record Item;
        Resource: Record Resource;
    begin
        GLAccount.SetRange("Default Deferral Template Code", "Deferral Code");
        if GLAccount.FindFirst then
            Error(CannotDeleteCodeErr, "Deferral Code", GLAccount.TableCaption, GLAccount."No.");

        Item.SetRange("Default Deferral Template Code", "Deferral Code");
        if Item.FindFirst then
            Error(CannotDeleteCodeErr, "Deferral Code", Item.TableCaption, Item."No.");

        Resource.SetRange("Default Deferral Template Code", "Deferral Code");
        if Resource.FindFirst then
            Error(CannotDeleteCodeErr, "Deferral Code", Resource.TableCaption, Resource."No.");
    end;

    var
        CannotDeleteCodeErr: Label '%1 cannot be deleted because it is set as the default deferral template code for %2 %3.', Comment = '%1=Value of code that is attempting to be deleted;%2=Table caption;%3=Value for the code in the table';
        DeferralPercentageErr: Label 'The deferral percentage must be greater than 0 and less than 100.';
        NumberofPeriodsErr: Label 'You must specify one or more periods.';
}

