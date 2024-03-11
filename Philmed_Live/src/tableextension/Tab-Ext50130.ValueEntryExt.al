tableextension 50130 ValueEntryExt extends "Value Entry"
{
    fields
    {
        field(50100; "Route Plan"; Code[20])
        {
            Caption = 'Route Plan';
            TableRelation = "Route Plan";
        }
        field(50101; "Route Group"; Code[20])
        {
            Caption = 'Route Group';
            TableRelation = "Route Group";
        }
        field(50102; "Route Group SalesPerson"; Code[20])
        {
            Caption = 'Route Group SalesPerson';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50103; "Payroll No."; Code[30])
        {
            Caption = 'Payroll No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Payroll No." WHERE("No." = FIELD("Source No.")));
        }
        field(50104; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Item Category Code" WHERE("No." = FIELD("Item No.")));
        }
    }
    keys
    {
        key(ICSKey; "Route Plan")
        {

        }
    }
}
