tableextension 50117 SalesReceivableSetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Cash Sale Posting Nos."; Code[20])
        {
            Caption = 'Cash Sale Posting Nos.';
            TableRelation = "No. Series";
        }
        field(50101; "Postdated Check Jnl Template"; Code[10])
        {
            Caption = 'Postdated Check Jnl Template';
            TableRelation = "Gen. Journal Template" WHERE(Type = FILTER('Cash Receipts'));

        }
        field(50102; "Postdated Check Jnl Batch"; code[10])
        {
            Caption = 'Postdated Check Jnl Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = Field("Postdated Check Jnl Template"));
        }
        field(50103; "MPESA Auto Journal Template"; Code[20])
        {
            Caption = 'MPESA Auto Journal Template';
            TableRelation = "Gen. Journal Template".Name WHERE(Type = CONST("Cash Receipts"));
        }
        field(50104; "MPESA Auto Journal Batch"; Code[20])
        {
            Caption = 'MPESA Auto Journal Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("MPESA Auto Journal Template"));
        }
    }
}
