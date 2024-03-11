tableextension 50121 CustomerLedgerEntryExt extends "Cust. Ledger Entry"
{
    fields
    {
        field(50100; "Customer Route"; Code[20])
        {
            Caption = 'Customer Route';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Route Plan" WHERE("No." = field("Customer No.")));
        }
        field(50101; "Customer Region"; Code[20])
        {
            Caption = 'Customer Region';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Customer Region" WHERE("No." = field("Customer No.")));
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED ENTRY!');
    end;
}

tableextension 50122 VendLedgerEntryExt extends "Vendor Ledger Entry"
{
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED ENTRY!');
    end;
}

tableextension 50123 PurchInvHeaderExt extends "Purch. Inv. Header"
{
    fields
    {

        field(50101; "Awaiting Kra Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Posted To KRA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Posted To KRA Error"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Kra Error Descripion"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}

tableextension 50124 PurchCrMemoHeaderExt extends "Purch. Cr. Memo Hdr."
{
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}
tableextension 50136 PurchaseInvoiceHeaderExt extends "Purchase Header"
{
    fields
    {

        field(50101; "Awaiting Kra Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Posted To KRA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Posted To KRA Error"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Kra Error Descripion"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}


