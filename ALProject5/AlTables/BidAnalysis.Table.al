table 50610 "Bid Analysis"
{

    fields
    {
        field(1; "RFQ No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "RFQ Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Quote No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Unit Of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Total; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Last Direct Cost"; Decimal)
        {
            CalcFormula = Lookup (Item."Last Direct Cost" WHERE ("No." = FIELD ("Item No.")));
            FieldClass = FlowField;
        }
        field(13; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                PurchLine.Reset;
                PurchLine.SetRange(PurchLine."Document Type", PurchLine."Document Type"::Quote);
                PurchLine.SetRange(PurchLine."Document No.", "Quote No.");
                PurchLine.SetRange(PurchLine."Line No.", "RFQ Line No.");
                if PurchLine.FindSet then begin
                    // PurchLine."RFQ Remarks" := Remarks;
                    PurchLine.Modify;
                end
            end;
        }
        field(14; "Total Quoted"; Decimal)
        {
            CalcFormula = Sum ("Bid Analysis".Amount WHERE ("RFQ No." = FIELD ("RFQ No."),
                                                           "Vendor No." = FIELD ("Vendor No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "RFQ No.", "RFQ Line No.", "Quote No.", "Vendor No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.")
        {
        }
        key(Key3; "Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PurchLine: Record "Purchase Line";
}

