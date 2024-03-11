pageextension 50102 VendorCardExtension extends "Vendor Card"
{
    layout
    {
        addafter("VAT Registration No.")
        {
            field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
            {
                ApplicationArea = all;
            }

        }

    }
}
