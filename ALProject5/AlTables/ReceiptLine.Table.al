table 50004 "Receipt Line"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Document No"; Code[20])
        {
            Editable = false;
        }
        field(3; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt;
        }
        field(4; "Transaction Type"; Code[20])
        {

            trigger OnValidate()
            begin
                RHeader.Reset;
                RHeader.SetRange(RHeader."No.", "Document No");
                if RHeader.FindFirst then begin
                    "Global Dimension 1 Code" := RHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := RHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := RHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := RHeader."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := RHeader."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := RHeader."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := RHeader."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := RHeader."Shortcut Dimension 8 Code";

                    "Responsibility Center" := RHeader."Responsibility Center";
                    //"Pay Mode":=
                    "Currency Code" := RHeader."Currency Code";
                    "Currency Factor" := RHeader."Currency Factor";
                    "Document Type" := "Document Type"::Receipt;
                end;
                Validate("Account Type");
            end;
        }
        field(5; "Default Grouping"; Code[20])
        {
            Editable = false;
        }
        field(6; "Account Type"; Option)
        {
            Editable = true;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Member';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member;
        }
        field(7; "Account Code"; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST ("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST (Customer)) Customer
            ELSE
            IF ("Account Type" = CONST (Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST ("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = FILTER (Member)) Table50121;

            trigger OnValidate()
            begin
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    "G/L Account".Reset;
                    "G/L Account".SetRange("G/L Account"."No.", "Account Code");
                    if "G/L Account".FindFirst then begin
                        "Account Name" := "G/L Account".Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Customer then begin
                    Customer.Reset;
                    Customer.SetRange(Customer."No.", "Account Code");
                    if Customer.FindFirst then begin
                        "Account Name" := Customer.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Vendor then begin
                    Vendor.Reset;
                    Vendor.SetRange(Vendor."No.", "Account Code");
                    if Vendor.FindFirst then begin
                        "Account Name" := Vendor.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::"Bank Account" then begin
                    Bank.Reset;
                    Bank.SetRange(Bank."No.", "Account Code");
                    if Bank.FindFirst then begin
                        "Account Name" := Bank.Name;
                    end;
                end;

                if "Account Code" = '' then
                    "Account Name" := '';
            end;
        }
        field(8; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(9; Description; Text[50])
        {
            Editable = false;
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1),
                                                          "Dimension Value Type" = CONST (Standard));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2),
                                                          Blocked = CONST (false));
        }
        field(12; "Shortcut Dimension 3 Code"; Code[20])
        {
            Editable = false;
        }
        field(13; "Shortcut Dimension 4 Code"; Code[20])
        {
            Editable = false;
        }
        field(14; "Shortcut Dimension 5 Code"; Code[20])
        {
            Editable = false;
        }
        field(15; "Shortcut Dimension 6 Code"; Code[20])
        {
            Editable = false;
        }
        field(16; "Shortcut Dimension 7 Code"; Code[20])
        {
            Editable = false;
        }
        field(17; "Shortcut Dimension 8 Code"; Code[20])
        {
            Editable = false;
        }
        field(18; "Responsibility Center"; Code[20])
        {
        }
        field(19; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,Deposit Slip,EFT,Bankers Cheque,RTGS,MPesa,Card';
            OptionMembers = " ",Cash,Cheque,"Deposit Slip",EFT,"Bankers Cheque",RTGS,MPesa,Card;
        }
        field(20; "Currency Code"; Code[20])
        {
        }
        field(30; "Currency Factor"; Decimal)
        {
        }
        field(31; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then begin
                    "Amount(LCY)" := Amount;
                end else begin
                    "Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor"));
                end;

                "Net Amount" := Amount;
                "Net Amount(LCY)" := "Amount(LCY)";
            end;
        }
        field(32; "Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(33; "Cheque No"; Code[20])
        {
        }
        field(34; "Applies-To Doc No."; Code[20])
        {
        }
        field(35; "Applies-To ID"; Code[20])
        {
        }
        field(36; "VAT Code"; Code[20])
        {
        }
        field(37; "VAT Percentage"; Decimal)
        {
        }
        field(38; "VAT Amount"; Decimal)
        {
        }
        field(39; "VAT Amount(LCY)"; Decimal)
        {
        }
        field(40; "W/TAX Code"; Code[20])
        {
        }
        field(41; "W/TAX Percentage"; Decimal)
        {
        }
        field(42; "W/TAX Amount"; Decimal)
        {
        }
        field(43; "W/TAX Amount(LCY)"; Decimal)
        {
        }
        field(44; "Net Amount"; Decimal)
        {
            Editable = false;
        }
        field(45; "Net Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(46; "Gen. Bus. Posting Group"; Code[20])
        {
        }
        field(47; "Gen. Prod. Posting Group"; Code[20])
        {
        }
        field(48; "VAT Bus. Posting Group"; Code[20])
        {
        }
        field(49; "VAT Prod. Posting Group"; Code[20])
        {
        }
        field(50; "User ID"; Code[20])
        {
            Editable = false;
        }
        field(51; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
        }
        field(52; Posted; Boolean)
        {
            Editable = false;
        }
        field(53; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(54; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(55; "Posted By"; Code[20])
        {
            Editable = false;
        }
        field(56; "Date Created"; Date)
        {
            Editable = false;
        }
        field(57; "Time Created"; Time)
        {
            Editable = false;
        }
        field(61; Date; Date)
        {
        }
        field(62; "Posting Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Document No", "Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        RHeader.Reset;
        RHeader.SetRange(RHeader."No.", "Document No");
        if RHeader.FindFirst then begin
            "Global Dimension 1 Code" := RHeader."Global Dimension 1 Code";
            "Global Dimension 2 Code" := RHeader."Global Dimension 2 Code";
            "Shortcut Dimension 3 Code" := RHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := RHeader."Shortcut Dimension 4 Code";
            "Shortcut Dimension 5 Code" := RHeader."Shortcut Dimension 5 Code";
            "Shortcut Dimension 6 Code" := RHeader."Shortcut Dimension 6 Code";
            "Shortcut Dimension 7 Code" := RHeader."Shortcut Dimension 7 Code";
            "Shortcut Dimension 8 Code" := RHeader."Shortcut Dimension 8 Code";

            "Responsibility Center" := RHeader."Responsibility Center";
            //"Pay Mode":=
            "Currency Code" := RHeader."Currency Code";
            "Currency Factor" := RHeader."Currency Factor";
            "Document Type" := "Document Type"::Receipt;
        end;
        Validate("Account Type");
    end;

    var
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        RHeader: Record "Receipt Header";
        CurrExchRate: Record "Currency Exchange Rate";
        Bank: Record "Bank Account";
}

