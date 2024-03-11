table 50601 Committment
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'LPO,Requisition,Imprest,Payment Voucher,PettyCash,PurchInvoice,StaffClaim,StaffAdvance,StaffSurrender,Grant Surrender,Cash Purchase';
            OptionMembers = LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance,StaffSurrender,"Grant Surrender","Cash Purchase";
        }
        field(5; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Month Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Month Actual"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Committed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Committed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Committed Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Committed Machine"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Cancelled Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Cancelled Machine"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Budget; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Vendor/Cust No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Vendor,Customer;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

