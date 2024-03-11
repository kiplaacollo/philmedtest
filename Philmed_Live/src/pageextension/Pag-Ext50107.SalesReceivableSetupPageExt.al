pageextension 50107 SalesReceivableSetupPageExt extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Posted Invoice Nos.")
        {
            field("Cash Sale Posting Nos."; Rec."Cash Sale Posting Nos.")
            {
                ApplicationArea = all;
            }

        }
        addafter("Copy Line Descr. to G/L Entry")
        {
            field("Postdated Check Jnl Template"; Rec."Postdated Check Jnl Template")
            {
                ApplicationArea = all;
            }
            field("Postdated Check Jnl Batch"; Rec."Postdated Check Jnl Batch")
            {
                ApplicationArea = all;
            }
            field("MPESA Auto Journal Template"; Rec."MPESA Auto Journal Template")
            {
                ApplicationArea = all;
            }
            field("MPESA Auto Journal Batch"; Rec."MPESA Auto Journal Batch")
            {
                ApplicationArea = all;
            }
        }


    }
}
