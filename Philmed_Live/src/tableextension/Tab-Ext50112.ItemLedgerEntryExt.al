tableextension 50112 ItemLedgerEntryExt extends "Item Ledger Entry"
{
    fields
    {
        field(50100; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Line"."Batch No." WHERE("Document No." = field("Document No."), "Line No." = field("Document Line No."), "No." = field("Item No.")));
        }
        field(50101; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Line"."Expiry Date" WHERE("Document No." = field("Document No."), "Line No." = field("Document Line No."), "No." = field("Item No.")));
        }

        field(50102; "Route Plan"; Code[20])
        {
            Caption = 'Route Plan';
            TableRelation = "Route Plan";
        }
        field(50103; "Route Group"; Code[20])
        {
            Caption = 'Route Group';
            TableRelation = "Route Group";
        }
        field(50104; "Route Group SalesPerson"; Code[20])
        {
            Caption = 'Route Group SalesPerson';
            TableRelation = "Salesperson/Purchaser";
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}
