table 50106 "MPESA Transaction"
{
    Caption = 'MPESA Transaction';

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
        field(2; TransTime; DateTime)
        {
            Caption = 'TransTime';
            DataClassification = ToBeClassified;
        }
        field(3; BillRefNumber; Code[50])
        {
            Caption = 'BillRefNumber';
            DataClassification = ToBeClassified;
        }
        field(4; BusinessShortCode; Code[20])
        {
            Caption = 'BusinessShortCode';
            DataClassification = ToBeClassified;
        }
        field(5; FirstName; Text[100])
        {
            Caption = 'FirstName';
            DataClassification = ToBeClassified;
        }
        field(6; MiddleName; Text[100])
        {
            Caption = 'MiddleName';
            DataClassification = ToBeClassified;
        }
        field(7; LastName; Text[100])
        {
            Caption = 'LastName';
            DataClassification = ToBeClassified;
        }
        field(8; OrgAccountBalance; Decimal)
        {
            Caption = 'OrgAccountBalance';
            DataClassification = ToBeClassified;
        }
        field(9; ThirdPartyTransID; Code[50])
        {
            Caption = 'ThirdPartyTransID';
            DataClassification = ToBeClassified;
        }
        field(10; TransAmount; Decimal)
        {
            Caption = 'TransAmount';
            DataClassification = ToBeClassified;
        }
        field(11; TransID; Code[30])
        {
            Caption = 'TransID';
            DataClassification = ToBeClassified;
        }
        field(12; "TransactionType"; Text[100])
        {
            Caption = 'TransactionType';
            DataClassification = ToBeClassified;
        }
        field(13; Posted; Integer)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(14; PostingDate; Date)
        {
            Caption = 'PostingDate';
            DataClassification = ToBeClassified;
        }
        field(15; PostingTime; Time)
        {
            Caption = 'PostingTime';
            DataClassification = ToBeClassified;
        }
        field(16; DocumentNo; Code[250])
        {
            Caption = 'DocumentNo';
            DataClassification = ToBeClassified;
        }
        field(17; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(18; ATTRIBUTE1; Text[100])
        {
            Caption = 'ATTRIBUTE1';
            DataClassification = ToBeClassified;
        }
        field(19; ATTRIBUTE2; Text[100])
        {
            Caption = 'ATTRIBUTE2';
            DataClassification = ToBeClassified;
        }
        field(20; MSISDN; Text[30])
        {
            Caption = 'MSISDN';
            DataClassification = ToBeClassified;
        }
        field(21; "Select Line"; Boolean)
        {
            Caption = 'Select Line';
            DataClassification = ToBeClassified;
        }
        field(22; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        Field(23; "Posted Document No."; Code[20])
        {
            Caption = 'Posted Document No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Cust. Ledger Entry"."Document No." where("External Document No." = field(TransID)));
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
        key(Key1; Posted)
        {

        }
        key(Key2; TransID)
        {

        }
    }

    trigger OnDelete()
    begin
        Error('This MPESA Entry cannot be Deleted');
    end;
}
