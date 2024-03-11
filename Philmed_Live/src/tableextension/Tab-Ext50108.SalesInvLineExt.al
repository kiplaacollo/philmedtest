tableextension 50108 SalesInvLineExt extends "Sales Invoice Line"
{
    fields
    {
        field(50100; "Cash Sale Gift Item"; Boolean)
        {
            Caption = 'Cash Sale Gift Item';
            Editable = false;
        }
        field(50101; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            Editable = false;
        }
        field(50102; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            Editable = false;
        }
        field(50104; "Minimum Unit Price"; Decimal)
        {
            Caption = 'Minimum Unit Price';
        }
        field(50103; "HS Code"; Code[20])
        {
            Caption = 'HS Code';
            Editable = false;
            FieldClass = FlowField;
            //CalcFormula = sum("Item".Quantity WHERE("Item No." = field("No."), "Location Code" = field("Location Code")));
            CalcFormula = lookup(Item."HS Code" where("No." = field("No.")));
        }
    }
    keys
    {
        key(Key10; "Document No.", Description)
        {
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;

}

tableextension 50109 SalesShipmentLineExt extends "Sales Shipment Line"
{
    fields
    {
        field(50100; "Cash Sale Gift Item"; Boolean)
        {
            Caption = 'Cash Sale Gift Item';
            Editable = false;
        }
        field(50101; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            Editable = false;
        }
        field(50102; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            Editable = false;
        }
        field(50104; "Minimum Unit Price"; Decimal)
        {
            Caption = 'Minimum Unit Price';
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}

tableextension 50110 SalesCreditMemoLineExt extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50100; "Cash Sale Gift Item"; Boolean)
        {
            Caption = 'Cash Sale Gift Item';
            Editable = false;
        }
        field(50101; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            Editable = false;
        }
        field(50102; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            Editable = false;
        }
        field(50104; "Minimum Unit Price"; Decimal)
        {
            Caption = 'Minimum Unit Price';
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;


}