tableextension 50102 VendorExtenstion extends Vendor
{
    fields
    {
        field(50100; "Credit Limit (LCY)"; Decimal)
        {
            Caption = 'Credit Limit (LCY)';
            DataClassification = ToBeClassified;
        }
        modify("VAT Registration No.")
        {
            Caption = 'PIN No.';
        }
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                lvVendor: Record Vendor;
            begin
                If Name <> '' then begin
                    lvVendor.SetRange("Search Name", UpperCase(Name));
                    if lvVendor.FindFirst() then
                        Error('Vendor No. %1 exists with the same Name!', lvVendor."No.");
                end;
            end;
        }
    }
    trigger OnAfterModify()
    begin
        If (Name <> xRec.Name) AND (Name = '') then
            Error('Vendor Name cannot be Blank!')

    end;
}
