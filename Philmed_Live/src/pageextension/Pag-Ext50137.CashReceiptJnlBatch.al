pageextension 50137 CashReceiptJnlBatch extends "General Journal Batches"
{
    layout
    {
        addafter("Reason Code")
        {
            field("MPESA Shortcode"; Rec."MPESA Shortcode")
            {
                ApplicationArea = all;
            }
        }
    }
}
