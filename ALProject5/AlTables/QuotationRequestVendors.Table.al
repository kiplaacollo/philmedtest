table 50608 "Quotation Request Vendors"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(2; "Requisition Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor WHERE ("Vendor Posting Group" = FILTER (<> 'DRIVERS'));

            trigger OnValidate()
            begin
                if vend.Get("Vendor No.") then begin
                    "Vendor Name" := vend.Name;
                    // MODIFY;

                end;
            end;
        }
        field(4; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Requisition Document No.", "Vendor No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        vend: Record Vendor;
}

