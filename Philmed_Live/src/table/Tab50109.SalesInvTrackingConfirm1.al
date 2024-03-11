table 50109 "Sales Inv. Tracking Confirm 1"
{
    Caption = 'Sales Inv. Tracking Confirm 1';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            NotBlank = true;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "No. of Lines"; Integer)
        {
            Caption = 'No. of Lines';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Amount Including VAT"; Decimal)
        {
            Caption = 'Amount Including VAT';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Route Plan"; Code[20])
        {
            Caption = 'Route Plan';
            TableRelation = "Route Plan".Code;
        }
        field(8; "Entry Time In"; DateTime)
        {
            Caption = 'Entry Time In';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "First Confirmation Time In"; DateTime)
        {
            Caption = 'First Confirmation Time In';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "First Confirmation Time Out"; DateTime)
        {
            Caption = 'First Confirmation Time Out';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "First Confirm. Executive"; Code[20])
        {
            Caption = 'First Confirm. Executive';
            TableRelation = Employee WHERE("Global Dimension 1 Code" = field("Branch Code"));
        }
        field(12; "First Confirm. TAT (Mins)"; Decimal)
        {
            Caption = 'First Confirm. TAT (Mins)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Stores Time In"; DateTime)
        {
            Caption = 'Stores Time In';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Stores Time Out"; DateTime)
        {
            Caption = 'Stores Time Out';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Stores Executive"; Code[20])
        {
            Caption = 'Stores Executive';
            TableRelation = Employee WHERE("Global Dimension 1 Code" = field("Branch Code"));
        }
        field(16; "Stores TAT (Mins)"; Decimal)
        {
            Caption = 'Stores TAT (Mins)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Second Confirm. Time In"; DateTime)
        {
            Caption = 'Second Confirm. Time In';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Second Confirm. Time Out"; DateTime)
        {
            Caption = 'Second Confirm. Time Out';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Second Confirm. Executive"; Code[20])
        {
            Caption = 'Second Confirm. Executive';
            TableRelation = Employee WHERE("Global Dimension 1 Code" = field("Branch Code"));
        }
        field(20; "Second Confirm. TAT (Mins)"; Decimal)
        {
            Caption = 'Second Confirm. TAT (Mins)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; Rider; Code[20])
        {
            Caption = 'Rider';
            TableRelation = Employee WHERE("Global Dimension 1 Code" = field("Branch Code"));
        }
        field(22; "Cashier Name"; Code[20])
        {
            Caption = 'Cashier Name';
            TableRelation = Employee WHERE("Global Dimension 1 Code" = field("Branch Code"));

        }
        field(23; "Cashier Clearing Time"; DateTime)
        {
            Caption = 'Cashier Clearing Time';
            Editable = false;
        }
        field(24; "Payment Amount"; Decimal)
        {
            Caption = 'Payment Amount';
            trigger OnValidate()
            begin
                //If ("Payment Amount" + "Credit Memo Amount") > "Amount Including VAT" Then
                //Error('Payments and Credit Memo Amounts Cannot be more than Amount Including VAT');
                Dev := "Amount Including VAT" - "Payment Amount" - "Credit Memo Amount";
            end;
        }
        field(25; Dev; Decimal)
        {
            Caption = 'Dev';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Credit Memo Amount"; Decimal)
        {
            Caption = 'Credit Memo Amount';
            trigger OnValidate()
            begin
                //If ("Payment Amount" + "Credit Memo Amount") > "Amount Including VAT" Then
                //Error('Payments and Credit Memo Amounts Cannot be more than Amount Including VAT');
                Dev := "Amount Including VAT" - "Payment Amount" - "Credit Memo Amount";
            end;
        }
        field(27; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Dispatch Personnel"; Code[20])
        {
            Caption = 'Dispatch Personnel';
            TableRelation = Employee WHERE("Global Dimension 1 Code" = field("Branch Code"));

        }
        field(29; "Trip No."; Integer)
        {
            Caption = 'Trip No.';

        }
        field(30; "Dispatch Time"; DateTime)
        {
            Caption = 'Dispatch Time';
            Editable = false;
        }
        field(31; "Overall TAT(Hours)"; Decimal)
        {
            Caption = 'Overall TAT(Hours)';
            Editable = false;
        }
        field(32; "Clearing Comments"; Text[250])
        {
            Caption = 'Clearing Comments';
        }
        field(50; Cleared; Boolean)
        {
            Caption = 'Cleared';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Reset By User ID"; Code[50])
        {
            Caption = 'Reset By User ID';
            Editable = false;
        }
        field(52; "Reset Date"; DateTime)
        {
            Caption = 'Reset Date';
            Editable = false;
        }
        field(53; "Reset Host"; Code[50])
        {
            Caption = 'Reset Host';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Invoice No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "Invoice No." = '' then
            Error('Invoice Number Cannot Be Blank!');
    end;

    trigger OnDelete()
    begin
        if "Entry Time In" <> 0DT then
            Error('This Invoice is Checked in and cannot be Deleted!');
    end;
}
