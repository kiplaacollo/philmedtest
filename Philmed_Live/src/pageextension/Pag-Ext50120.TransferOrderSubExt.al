pageextension 50120 TransferOrderSubExt extends "Transfer Order Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Inventory Balance"; Rec."Inventory Balance")
            {
                Editable = false;
                ApplicationArea = all;
            }

        }
        modify("Reserved Quantity Inbnd.")
        {
            Visible = false;
        }
        modify("Reserved Quantity Outbnd.")
        {
            Visible = false;
        }
        modify("Reserved Quantity Shipped")
        {
            Visible = false;
        }
        movebefore(Quantity; "Unit of Measure Code")
    }
}
