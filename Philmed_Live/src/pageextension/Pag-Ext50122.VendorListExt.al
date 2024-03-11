pageextension 50122 VendorListExt extends "Vendor List"
{
    layout
    {
        addbefore("Phone No.")
        {
            field("Our Account No."; Rec."Our Account No.")
            {
                Editable = false;
                ApplicationArea = all;
            }
        }
    }
}
