table 50014 "Funds Transaction Types"
{
    DataClassification = CustomerContent;
    LookupPageId = "Funds Transaction Types";
    DrillDownPageId = "Funds Transaction Types";

    fields
    {
        field(10; "Transaction Code"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Transaction Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Transaction Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Payment,Receipt,Imprest,Claim;
        }
        field(13; "Account Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,Investor,Member;
        }
        field(14; "Account No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" else
            if ("Account Type" = const(Customer)) Customer else
            if ("Account Type" = const(Vendor)) Vendor;
            trigger OnValidate()
            begin
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    "G/L Account".Reset();
                    "G/L Account".SetRange("G/L Account"."No.", "Account No");
                    if "G/L Account".FindFirst() then begin
                        "Account Name" := "G/L Account".Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Customer then begin
                    Customer.Reset();
                    Customer.SetRange(Customer."No.", "Account No");
                    if Customer.FindFirst() then begin
                        "Account Name" := Customer.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Vendor then begin
                    Vendor.Reset();
                    Vendor.SetRange(Vendor."No.", "Account No");
                    if Vendor.FindFirst() then begin
                        "Account Name" := Vendor.Name;
                    end;
                end;
                if "Account No" = '' then
                    "Account Name" := '';
            end;
        }
        field(15; "Account Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Default Grouping"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group" else
            if ("Account Type" = const(Vendor)) "Vendor Posting Group" else
            if ("Account Type" = const("Bank Account")) "Bank Account Posting Group" else
            if ("Account Type" = const("Fixed Asset")) "FA Posting Group";
        }
        field(17; "VAT Chargeable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(18; "VAT Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Fund Tax Codes"."Tax Code";
        }
        field(19; "Withholding Tax Chargeable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Withholding Tax Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Retention Chargeable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Retention Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(23; "Legal Fee Chargeable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Legal Fee Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Legal Fee Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(26; "Investor Principle/Topup"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Transaction Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Normal,Investor,Property;
        }
        field(28; "Pending Voucher"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(29; "Bank Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
            trigger OnValidate()
            begin
                if "Account Type" <> "Account Type"::"Bank Account" then begin
                    Error('You can only enter Bank No where Account Type is Bank Account');
                end;
            end;
        }
        field(30; "Transaction Remarks"; Text[250])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(31; "Payment Reference"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Normal,"Farmer Purchase",Grant;
        }
        field(32; "Customer Payment On Account"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33; "Direct Expense"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(34; "Calculate Retention"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = No,Yes;
        }
        field(36; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(37; "Based On Travel Rates Table"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        // field(38; "VAT Withheld Code"; Code[10])
        // {
        //     DataClassification = CustomerContent;
        //     TableRelation = fund
        // }
        field(39; "G/L Account Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Transaction Code", "Account Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DrillDown; "Transaction Code", "Transaction Description", "Transaction Type", "Account Type", "Account No", "Account Name")
        {

        }
    }

    var
        myInt: Integer;
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}