tableextension 50120 DimensionValueExt extends "Dimension Value"
{
    fields
    {
        field(50100; "Sales Invoice Nos."; Code[20])
        {
            Caption = 'Sales Invoice Nos.';
            TableRelation = "No. Series".Code;
        }
        field(50101; "Cash Sale Nos."; Code[20])
        {
            Caption = 'Cash Sale Nos.';
            TableRelation = "No. Series".Code;
        }

        field(50102; "MPESA Till No."; Code[20])
        {
            Caption = 'MPESA Till No.';
        }
        field(50103; "Daily Sales Target"; Decimal)
        {
            Caption = 'Daily Sales Target';

        }
        field(50104; "Daily Customer Target"; Integer)
        {
            Caption = 'Daily Customer Target';
        }
    }
}
