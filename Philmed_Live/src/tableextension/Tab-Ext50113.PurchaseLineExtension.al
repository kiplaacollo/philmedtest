tableextension 50113 PurchaseLineExtension extends "Purchase Line"
{
    fields
    {
        field(50100; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50101; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }
}

tableextension 50114 PurchaseInvLineExt extends "Purch. Inv. Line"
{
    fields
    {
        field(50100; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            Editable = false;
        }
        field(50101; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            Editable = false;
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}

tableextension 50115 PurchaseReceiptLineExt extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50100; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            Editable = false;
        }
        field(50101; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            Editable = false;
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}
tableextension 50116 PurchaseCrMemoLineExt extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50100; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            Editable = false;
        }
        field(50101; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            Editable = false;
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}