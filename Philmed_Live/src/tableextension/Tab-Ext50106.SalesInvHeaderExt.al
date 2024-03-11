tableextension 50106 SalesInvHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "Cash Sale Order"; Boolean)
        {
            Caption = 'Cash Sale Order';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50101; "Route Plan"; Code[20])
        {
            Caption = 'Route Plan';
            Editable = false;
        }
        field(50102; "Urgent Comments"; Text[100])
        {
            Caption = 'Urgent Comments';
            Editable = false;
        }
        field(50103; "Host Name"; Text[250])
        {
            Caption = 'Host Name';
            Editable = false;
        }
        field(50104; "branch code"; Code[30])
        {

            Caption = 'Branch code';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."No." where("No." = field("No.")));

        }
        field(50105; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            FieldClass = FlowField;
            OptionCaption = ' ,Cash Sale, Credit, Staff';
            OptionMembers = " ","Cash Sale","Credit","Staff";
            CalcFormula = lookup(Customer."Customer Type" where("No." = field("Sell-to Customer No.")));
        }
        field(50106; "Awaiting Kra Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Posted To KRA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Posted To KRA Error"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Kra Error Descripion"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "rcptNo"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "intrlData"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "rcptSign"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "totRcptNo"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "vsdcRcptPbctDate"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "sdcId"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "mrcNo"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "QR Code"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Kra QR Code"; Blob)
        {
            Caption = 'KRA QR Code';
            Subtype = Bitmap;
        }


    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;

}
tableextension 50107 SalesShipmentHeaderExt extends "Sales Shipment Header"
{
    fields
    {
        field(50100; "Cash Sale Order"; Boolean)
        {
            Caption = 'Cash Sale Order';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50101; "Route Plan"; code[20])
        {
            Caption = 'Route Plan';
            Editable = false;
        }
        field(50102; "Urgent Comments"; Text[100])
        {
            Caption = 'Urgent Comments';
            Editable = false;
        }
        field(50103; "Host Name"; Text[250])
        {
            Caption = 'Host Name';
            Editable = false;
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}

tableextension 50111 SalesCreditMemoHeaderExt extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50100; "Cash Sale Order"; Boolean)
        {
            Caption = 'Cash Sale Order';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50101; "Route Plan"; code[20])
        {
            Caption = 'Route Plan';
            Editable = false;
        }
        field(50102; "Urgent Comments"; Text[100])
        {
            Caption = 'Urgent Comments';
            Editable = false;
        }
        field(50103; "Host Name"; Text[250])
        {
            Caption = 'Host Name';
            Editable = false;
        }
    }
    trigger OnBeforeDelete()
    begin
        Error('YOU CANNOT DELETE A POSTED DOCUMENT!');
    end;
}