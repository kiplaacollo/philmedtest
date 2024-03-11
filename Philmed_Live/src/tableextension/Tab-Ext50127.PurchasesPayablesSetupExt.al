tableextension 50127 "Purchases Payables Setup Ext" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50101; "Postdated Check Jnl Template"; Code[10])
        {
            Caption = 'Postdated Check Jnl Template';
            TableRelation = "Gen. Journal Template" WHERE(Type = FILTER('Payments'));

        }
        field(50102; "Postdated Check Jnl Batch"; code[10])
        {
            Caption = 'Postdated Check Jnl Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = Field("Postdated Check Jnl Template"));
        }
    }
}
