tableextension 50128 VATEntryExt extends "VAT Entry"
{
    fields
    {
        field(50100; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name WHERE("No." = FIELD("Bill-to/Pay-to No.")));
        }

        field(50101; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name WHERE("No." = FIELD("Bill-to/Pay-to No.")));
        }
        field(50102; "Branch Code"; Text[100])
        {
            Caption = 'Branch Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Entry"."Global Dimension 1 Code" WHERE("Posting Date" = FIELD("Posting Date"), "Document No." = FIELD("Document No.")));
        }
    }
}

pageextension 50129 VATEntry extends "VAT Entries"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = all;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = all;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
            field("Branch Code"; Rec."Branch Code")
            {
                ApplicationArea = all;
            }
        }
        modify("VAT Registration No.")
        {
            Caption = 'PIN No.';
            Visible = true;
        }
    }
}