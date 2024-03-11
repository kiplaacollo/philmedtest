tableextension 50135 tsh extends "Transfer Shipment Header"
{
    fields
    {
        field(50100; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = ToBeClassified;
        }
        field(50101; "Awaiting Kra Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Posted To KRA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Posted To KRA Error"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Kra Error Descripion"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
}
