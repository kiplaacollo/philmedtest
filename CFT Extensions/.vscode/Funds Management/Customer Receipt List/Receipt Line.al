table 50003 "Receipt Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            AutoIncrement = true;
        }
        field(11; "Document No"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt;
            Editable = false;
        }
        field(13; "Transaction Type"; Code[20])
        {
            DataClassification = CustomerContent;

            TableRelation = "Funds Transaction Types"."Transaction Code" where("Transaction Type" = const(Receipt));
            trigger OnValidate()
            var
                FundsTypes: Record "Funds Transaction Types";
            begin
                FundsTypes.Reset();
                FundsTypes.SetRange(FundsTypes."Transaction Code", "Transaction Type");
                if FundsTypes.FindFirst() then begin
                    "Default Grouping" := FundsTypes."Default Grouping";
                    "Account Type" := FundsTypes."Account Type";
                    "Account Code" := FundsTypes."Account No";
                    Description := FundsTypes."Transaction Description";
                    "Investor Principle/Topup" := FundsTypes."Investor Principle/Topup";

                end;
                RHeader.Reset();
                RHeader.SetRange(RHeader."No.", "Document No");
                if RHeader.FindFirst() then begin
                    "Global Dimension 1 Code" := RHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := RHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := RHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := RHeader."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := RHeader."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := RHeader."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := RHeader."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := RHeader."Shortcut Dimension 8 Code";
                    "Responsibility Center" := RHeader."Responsibility Center";
                    "Currency Code" := RHeader."Currency Code";
                    "Currency Factor" := RHeader."Currency Factor";
                    "Document Type" := "Document Type"::Receipt;
                end;
                Validate("Account Type");
            end;
        }
        field(14; "Default Grouping"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Account Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,Investor,Member;
            trigger OnValidate()
            var
                RHeader: Record "Receipt Header";
            begin
                IF "Account Type" = "Account Type"::Investor THEN BEGIN
                    RHeader.RESET;
                    RHeader.SETRANGE(RHeader."No.", "Document No");
                    IF RHeader.FINDFIRST THEN BEGIN
                        "Account Code" := RHeader."Investor No.";
                        "Account Name" := RHeader."Investor Name";
                    END;
                END;
                Validate("Account Code");
            end;
        }
        field(16; "Account Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF ("Account Type" = CONST(" G/L Account")) "G/L Account" ELSE
            IF ("Account Type" = CONST(Customer)) Customer ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account";
            trigger OnValidate()
            var
                RHeader: Record "Receipt Header";
                "G/L Account": Record "G/L Account";
                Customer: Record Customer;
                Vendor: Record Vendor;
                Bank: Record "Bank Account";
            begin
                if "Account Type" = "Account Type"::" G/L Account" then begin
                    "G/L Account".RESET;
                    "G/L Account".SETRANGE("G/L Account"."No.", "Account Code");
                    IF "G/L Account".FINDFIRST THEN BEGIN
                        "Account Name" := "G/L Account".Name;
                    END;
                end;
                IF "Account Type" = "Account Type"::Customer THEN BEGIN
                    Customer.RESET;
                    Customer.SETRANGE(Customer."No.", "Account Code");
                    IF Customer.FINDFIRST THEN BEGIN
                        "Account Name" := Customer.Name;
                    END;
                END;
                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    Vendor.RESET;
                    Vendor.SETRANGE(Vendor."No.", "Account Code");
                    IF Vendor.FINDFIRST THEN BEGIN
                        "Account Name" := Vendor.Name;
                    END;
                END;
                IF "Account Code" = '' THEN
                    "Account Name" := '';
            end;

        }
        field(17; "Account Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            // CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard));
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            // CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(24; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(25; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(27; "Responsibility Center"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(28; "Pay Mode"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Cash,Cheque,"Deposit Slip",EFT,"Bankers Cheque",RTGS;
        }
        field(29; "Currency Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(30; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(31; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Currency Code" = '' then begin
                    "Amount(LCY)" := Amount;
                end else begin
                    "Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor"));
                end;
                "Net Amount" := Amount;
                "Net Amount(LCY)" := "Amount(LCY)";
            end;
        }
        field(32; "Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33; "Cheque No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Applies-to Doc No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(35; "Applies-To ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(36; "VAT Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(37; "VAT Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(38; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(39; "VAT Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(40; "W/TAX Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(41; "W/TAX Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(42; "W/TAX Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(43; "W/TAX Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(44; "Net Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(45; "Net Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(46; "Gen. Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(47; "Gen. Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(48; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(49; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(51; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
            Editable = false;
        }
        field(52; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(53; "Date Posted"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(54; "Time Posted"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(55; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(56; "Date Created"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(57; "Time Created"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(58; "Legal Fee Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Investment Field';
        }
        field(59; "Legal Fee Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Investment Field';
            Editable = false;
        }
        field(60; "Legal Fee Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Investment Field';
        }
        field(61; Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(62; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(63; "Investor Principle/Topup"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'Investment Field';
        }
    }

    keys
    {
        key(Key1; "Line No", "Document No", "Transaction Type")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        CurrExchRate: Record "Currency Exchange Rate";
        RHeader: Record "Receipt Header";

    trigger OnInsert()
    var
        RHeader: Record "Receipt Header";
    begin
        RHeader.Reset();
        RHeader.SetRange(RHeader."No.", "Document No");
        if RHeader.FindFirst() then begin
            "Global Dimension 1 Code" := RHeader."Global Dimension 1 Code";
            "Global Dimension 2 Code" := RHeader."Global Dimension 2 Code";
            "Shortcut Dimension 3 Code" := RHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := RHeader."Shortcut Dimension 4 Code";
            "Shortcut Dimension 5 Code" := RHeader."Shortcut Dimension 5 Code";
            "Shortcut Dimension 6 Code" := RHeader."Shortcut Dimension 6 Code";
            "Shortcut Dimension 7 Code" := RHeader."Shortcut Dimension 7 Code";
            "Shortcut Dimension 8 Code" := RHeader."Shortcut Dimension 8 Code";
            "Responsibility Center" := RHeader."Responsibility Center";
            "Currency Code" := RHeader."Currency Code";
            "Currency Factor" := RHeader."Currency Factor";
            "Document Type" := "Document Type"::Receipt;
        end;
        Validate("Account Type");
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