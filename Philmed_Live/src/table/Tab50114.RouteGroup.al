table 50114 "Route Group"
{
    Caption = 'Route Group';
    DrillDownPageId = "Route Groups";
    LookupPageId = "Route Groups";

    fields
    {
        field(1; "Route Group Code"; Code[20])
        {
            Caption = 'Route Group Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser".Code where(Blocked = filter(false));
        }
        field(5; "Daily Sales Target"; Decimal)
        {
            Caption = 'Daily Sales Target';
            FieldClass = FlowField;
            CalcFormula = Sum("Route Plan"."Daily Sales Target" where("Route Group" = field("Route Group Code")));
            Editable = false;
        }
        field(6; "Daily Customer Target"; Integer)
        {
            Caption = 'Daily Customer Target';
            FieldClass = FlowField;
            CalcFormula = Sum("Route Plan"."Daily Customer Target" where("Route Group" = field("Route Group Code")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Route Group Code")
        {
            Clustered = true;
        }
    }
}
