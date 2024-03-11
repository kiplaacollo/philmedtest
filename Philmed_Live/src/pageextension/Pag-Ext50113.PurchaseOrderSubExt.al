pageextension 50113 PurchaseOrderSubExt extends "Purchase Order Subform"
{
    layout
    {
        addafter("Direct Unit Cost")
        {
            field("Expiry Date"; Rec."Expiry Date")
            {
                ApplicationArea = all;
            }
            field("Batch No."; Rec."Batch No.")
            {
                ApplicationArea = all;
            }
            field("VAT Identifier"; "VAT Identifier")
            {
                ApplicationArea = ALL;
                Editable = true;
            }


        }

        modify("Bin Code")
        {
            Visible = false;
        }

        modify("Reserved Quantity")
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


    }
}
