pageextension 50131 LocationCardExt extends "Location Card"
{
    layout
    {
        addafter("Use As In-Transit")
        {
            field("Block Sales From Location"; Rec."Block Sales From Location")
            {
                ApplicationArea = all;
            }

        }
        addafter(General)
        {

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
                Caption = 'Kra Success/Error Description';
                ApplicationArea = all;
                Editable = false;
            }
            field("KRA Branch Code"; "KRA Branch Code")
            {
                ApplicationArea = all;
                Editable = true;
            }

        }
    }
}

pageextension 50132 LocationListExt extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field("Block Sales From Location"; Rec."Block Sales From Location")
            { }

        }
    }
}
