tableextension 50132 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        field(50100; "MPESA Shortcode"; Code[20])
        {
            Caption = 'MPESA Shortcode';
            DataClassification = ToBeClassified;
        }
        field(50101; "Block Balances Below Zero"; Boolean)
        {
            Caption = 'Block Balances Below Zero';
        }
    }
}
