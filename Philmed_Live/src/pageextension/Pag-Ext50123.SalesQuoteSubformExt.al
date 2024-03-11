pageextension 50123 SalesQuoteSubformExt extends "Sales Quote Subform"
{
    layout
    {
        addafter("Location Code")
        {
            field("Inventory Balance"; Rec."Inventory Balance")
            {
                ApplicationArea = all;
            }
        }

        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }

        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }

        modify(ShortcutDimCode3)
        {
            Visible = false;
        }

        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }

        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }

        modify("Line Amount")
        {
            Editable = false;
        }
        movebefore(Quantity; "Unit of Measure Code")
        //moveafter("Shortcut Dimension 1 Code"; "Location Code")

    }
}
