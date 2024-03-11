table 50100 "Route Plan"
{
    Caption = 'Route Plan';
    DrillDownPageId = "Route Plans";
    LookupPageId = "Route Plans";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent".Code;
        }
        field(4; "Route No."; Integer)
        {
            Caption = 'Route No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Daily Sales Target"; Decimal)
        {
            Caption = 'Daily Sales Target';

        }
        field(6; "Daily Customer Target"; Integer)
        {
            Caption = 'Daily Customer Target';

        }
        field(7; "Route Group"; Code[20])
        {
            Caption = 'Route Group';
            TableRelation = "Route Group";
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

}

