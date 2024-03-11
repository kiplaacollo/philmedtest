pageextension 50103 ItemCardExtension extends "Item Card"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            /* field("Manufacturer Code"; Rec."Manufacturer Code")
            {
                ApplicationArea = all;
            } */

        }
        addafter("Unit Price")
        {
            field("Minimum Unit Price"; Rec."Minimum Unit Price")
            {
                ShowMandatory = True;
                ApplicationArea = all;
            }
            field("Discount % Allowed"; Rec."Discount % Allowed")
            {
                ApplicationArea = all;
            }
            field("Retail Price"; Rec."Retail Price")
            {
                ApplicationArea = all;
            }

        }

        addafter(Item)
        {
            field("HS Code"; "HS Code")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Item Classification"; "Item Classification")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Awaiting Kra Posting"; "Awaiting Kra Posting")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Posted To KRA"; "Posted To KRA")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Posted To KRA Error"; "Posted To KRA Error")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Kra Error Descripion"; "Kra Error Descripion")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
    }
}
