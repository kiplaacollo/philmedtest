pageextension 50121 PostedSalesInvoiceListExt extends "Posted Sales Invoices"
{
    layout
    {
        addbefore("Location Code")
        {
            field("Cash Sale Order"; Rec."Cash Sale Order")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("branch code"; Rec."branch code")
            {
                ApplicationArea = all;
            }


        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Posting Date")
        {
            Visible = true;
        }
        moveafter("Location Code"; "Shortcut Dimension 1 Code")
        moveafter("Currency Code"; "Posting Date")
    }

    trigger OnOpenPage()
    var
        lvUserSetup: Record "User Setup";

    begin
        if lvUserSetup.get(UserId) then
            if not lvUserSetup."View Posted Sales Invoice" then
                error('You do not have permission to view posted sales invoice');
    end;


}
