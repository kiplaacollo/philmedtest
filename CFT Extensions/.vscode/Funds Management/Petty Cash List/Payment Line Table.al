table 52011 "Payment Line Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(11; "Document No"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payments Header"."No.";
        }
        field(12; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Accounting",Claim,"Member Bill","Group Bill";
        }
        field(13; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
            trigger OnValidate()
            begin
                if "Currency Code" <> '' then begin
                    TestField("Bank Code");
                    if BankAcc.Get("Bank Code") then begin
                        BankAcc.TestField(BankAcc."Currency Code", "Currency Code");
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    end;
                end;
            end;
        }
        field(14; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Transaction Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Funds Transaction Types"."Transaction Code" where("Transaction Type" = const(Payment));
            trigger OnValidate()
            begin
                FundsTypes.Reset();
                FundsTypes.SetRange(FundsTypes."Transaction Code", "Transaction Type");
                if FundsTypes.FindFirst() then begin
                    "Default Grouping" := FundsTypes."Default Grouping";
                    "Account No." := FundsTypes."Account No";
                    "Transaction Type Description" := FundsTypes."Transaction Description";
                    "Payment Description" := FundsTypes."Transaction Description";
                    if FundsTypes."VAT Chargeable" then
                        "VAT Code" := FundsTypes."VAT Code";
                    if FundsTypes."Withholding Tax Chargeable" then
                        "W/TAX Code" := FundsTypes."Withholding Tax Code";
                end;
                PHeader.Reset();
                PHeader.SetRange(PHeader."No.", "Document No");
                if PHeader.FindFirst() then begin
                    "Global Dimension 1 Code" := PHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := PHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := PHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := PHeader."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := PHeader."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := PHeader."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := PHeader."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := PHeader."Shortcut Dimension 8 Code";
                    "Responsibility Center" := PHeader."Responsibility Center";
                    "Bank Code" := PHeader."Bank Account";
                    Validate("Bank Code");
                    "Currency Code" := PHeader."Currency Code";
                    Validate("Currency Code");
                    "Currency Factor" := PHeader."Currency Factor";
                end;
                Validate("Account No.");
            end;

        }
        field(16; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            Editable = false;
        }
        field(17; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No." else
            if ("Account Type" = const(Customer)) Customer."No." else
            if ("Account Type" = const(Vendor)) Vendor."No." else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"."No.";
            trigger OnValidate()
            begin
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    "G/L Account".Reset();
                    "G/L Account".SetRange("G/L Account"."No.", "Account No.");
                    if "G/L Account".FindFirst() then begin
                        "Account Name" := "G/L Account".Name;
                        "VAT Bus. Posting Group" := "G/L Account"."VAT Bus. Posting Group";
                        "VAT Prod. Posting Group" := "G/L Account"."VAT Prod. Posting Group";
                    end;
                end;
                if "Account Type" = "Account Type"::Customer then begin
                    Customer.Reset();
                    Customer.SetRange(Customer."No.", "Account No.");
                    if Customer.FindFirst() then begin
                        "Account Name" := Customer.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Vendor then begin
                    Vendor.Reset();
                    Vendor.SetRange(Vendor."No.", "Account No.");
                    if Vendor.FindFirst() then begin
                        "Account Name" := Vendor.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::"Fixed Asset" then begin
                    FA.Reset();
                    FA.SetRange(FA."No.", "Account No.");
                    if FA.FindFirst() then begin
                        "Account Name" := FA.Description;
                    end;
                end;
                if "Account No." = '' then
                    "Account Name" := '';
            end;
        }
        field(18; "Account Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Transaction Type Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Payment Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(21; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Net Amount" := Amount;
                if "Currency Code" <> '' then begin
                    "Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor"));
                    "Net Amount(LCY)" := "Amount(LCY)";
                end else begin
                    "Amount(LCY)" := Amount;
                    "Net Amount(LCY)" := Amount;
                end;
                Validate("VAT Code");
                Validate("W/TAX Code");
            end;
        }
        field(22; "Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "VAT Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Fund Tax Codes"."Tax Code" where(Type = const(VAT));
            trigger OnValidate()
            begin
                FundsTaxCodes.Reset();
                FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "VAT Code");
                if FundsTaxCodes.FindFirst() then begin
                    "VAT Amount" := Amount * (FundsTaxCodes.Percentage / 100);
                    Validate("VAT Amount");
                end;
            end;

        }
        field(24; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                "Net Amount" := Amount - "VAT Amount";
                if "Currency Code" <> '' then begin
                    "VAT Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "VAT Amount", "Currency Factor"));
                    "Net Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "VAT Amount(LCY)" := "VAT Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
            end;
        }
        field(25; "VAT Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "W/TAX Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Fund Tax Codes"."Tax Code" where(Type = const("W/Tax"));
            trigger OnValidate()
            begin
                FundsTaxCodes.Reset();
                FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "W/TAX Code");
                if FundsTaxCodes.FindFirst() then begin
                    "W/TAX Amount" := Amount * (FundsTaxCodes.Percentage / 100);
                    VALIDATE("W/TAX Amount");
                end;
            end;
        }
        field(27; "W/TAX Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Net Amount" := Amount - "W/TAX Amount";
                if "Currency Code" <> '' then begin
                    "W/TAX Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "W/TAX Amount", "Currency Factor"));
                    "Net Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "W/TAX Amount(LCY)" := "W/TAX Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
            end;
        }
        field(28; "W/TAX Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(29; "Retention Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(30; "Retention Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(31; "Retention Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(32; "Net Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33; "Net Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(34; Committed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Vote Book"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Gen. Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Gen. Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(38; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(39; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(40; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Global Dimension 2 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(42; "Shortcut Dimension 3 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(43; "Shortcut Dimension 4 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(44; "Shortcut Dimension 5 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(45; "Shortcut Dimension 6 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(46; "Shortcut Dimension 7 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(47; "Shortcut Dimension 8 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(48; "Applies-to Doc. Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(49; "Applies-to Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." <> '') AND ("Applies-to Doc. No." <> '') THEN BEGIN
            //         SetAmountToApply("Applies-to Doc. No.", "Account No.");
            //         SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
            //     END else
            //         IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (xRec."Applies-to Doc. No." = '') THEN
            //             SetAmountToApply("Applies-to Doc. No.", "Account No.")
            //         ELSE
            //             IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND ("Applies-to Doc. No." = '') THEN
            //                 SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
            //     PHeader.Reset();
            //     PHeader.SetRange(PHeader."No.", "Document No");
            //     if PHeader.FindFirst() then begin
            //         IF (PHeader.Status = PHeader.Status::Approved) OR (PHeader.Status = PHeader.Status::Posted) OR (PHeader.Status = PHeader.Status::"Pending Approval") THEN
            //             ERROR('You Cannot modify documents that are approved/posted/Send for Approval');
            //     end;
            // end;

            // trigger OnLookup()
            // begin
            //     PHeader.Reset();
            //     PHeader.SetRange(PHeader."No.", "Document No");
            //     if PHeader.FindFirst() then begin
            //         IF (PHeader.Status = PHeader.Status::Approved) OR (PHeader.Status = PHeader.Status::Posted) OR (PHeader.Status = PHeader.Status::"Pending Approval") THEN
            //             ERROR('You Cannot modify documents that are approved/posted/Send for Approval');
            //     end;
            //     IF (Rec."Account Type" <> Rec."Account Type"::Customer) AND (Rec."Account Type" <> Rec."Account Type"::Vendor) THEN
            //         ERROR('You cannot apply to %1', "Account Type");
            //     WITH Rec DO BEGIN
            //         Amount := 0;
            //         Validate(Amount);
            //         PayToVendorNo := "Account No.";
            //         VendLedgEntry.SETCURRENTKEY("Vendor No.", Open);
            //         VendLedgEntry.SETRANGE("Vendor No.", PayToVendorNo);
            //         VendLedgEntry.SETRANGE(Open, TRUE);
            //         if "Applies-to ID" = '' then
            //             "Applies-to ID" := "Document No";
            //         if "Applies-to ID" = '' then
            //             Error('You must specify %1 or %2', FIELDCAPTION("Document No"), FIELDCAPTION("Applies-to ID"));
            //         // ApplyVendEntries.SetPVLine(Rec, VendLedgEntry, Rec.FIELDNO("Applies-to ID"));
            //         ApplyVendEntries.SETRECORD(VendLedgEntry);
            //         ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
            //         ApplyVendEntries.LOOKUPMODE(TRUE);
            //         OK := ApplyVendEntries.RUNMODAL = ACTION::LookupOK;
            //         CLEAR(ApplyVendEntries);
            //         IF NOT OK THEN
            //             EXIT;
            //         VendLedgEntry.RESET;
            //         VendLedgEntry.SETCURRENTKEY("Vendor No.", Open);
            //         VendLedgEntry.SETRANGE("Vendor No.", PayToVendorNo);
            //         VendLedgEntry.SETRANGE(Open, TRUE);
            //         VendLedgEntry.SETRANGE(VendLedgEntry."Applies-to ID", "Applies-to ID");
            //         IF VendLedgEntry.FIND('-') THEN BEGIN
            //             "Applies-to Doc. Type" := 0;
            //             "Applies-to Doc. No." := '';
            //         end else
            //             "Applies-to ID" := '';
            //     end;
            //     // Calculate Total To Apply
            //     VendLedgEntry.RESET;
            //     VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, "Applies-to ID");
            //     VendLedgEntry.SETRANGE("Vendor No.", PayToVendorNo);
            //     VendLedgEntry.SETRANGE(Open, TRUE);
            //     VendLedgEntry.SETRANGE(VendLedgEntry."Applies-to ID", "Applies-to ID");
            //     IF VendLedgEntry.FIND('-') THEN BEGIN
            //         VendLedgEntry.CALCSUMS("Amount to Apply");
            //         Amount := ABS(VendLedgEntry."Amount to Apply");
            //         VALIDATE(Amount);
            //     END;
            // end;
        }
        field(50; "Applies-to ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(51; "VAT Withheld"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(52; "VAT Withheld Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(53; "VAT Withheld Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(54; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
            Editable = false;
        }
        field(55; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(56; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(57; "Date Posted"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(58; "Time Posted"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(59; "Payment Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Normal,"Petty Cash",Express,"Cash Purchase",Mobile;
        }
        field(60; "Payment Mode"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Cash,Cheque,EFT,"Letter of Credit","Custom 3","Custom 4","Custom 5";
        }
        field(61; "Default Grouping"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(62; "Responsibility Center"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(63; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(64; "Payment Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,"Normal Payment","Meeting Payment";
        }
        field(66; Reversed; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(67; "Reversed By"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(68; "Reversal Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(69; "Reversal Time"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(71; "Bank Code"; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                BankAcc.Reset();
                BankAcc.SetRange(BankAcc."No.", "Bank Code");
                if BankAcc.FindFirst() then begin
                    "Bank Name" := BankAcc.Name;
                end;
            end;
        }
        field(72; "Bank Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73; "Posting Dates"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Payments Header"."Posting Date" where("No." = field("Document No")));
        }
        field(74; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }

    }

    keys
    {
        key(Key1; "Line No", "Document No", "Transaction Type")
        {
            Clustered = true;
        }
    }
    procedure SetAmountToApply(AppliesToDocNo: Code[20]; VendorNo: Code[20])
    begin
        VendLedgEntry.SetCurrentKey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliesToDocNo);
        VendLedgEntry.SetRange("Vendor No.", VendorNo);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst() then begin
            if VendLedgEntry."Amount to Apply" = 0 then begin
                VendLedgEntry.CalcFields("Remaining Amount");
                VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
            end else
                VendLedgEntry."Amount to Apply" := 0;
            VendLedgEntry."Accepted Payment Tolerance" := 0;
            VendLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
            CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
        end;
    end;

    var
        myInt: Integer;
        BankAcc: Record "Bank Account";
        CurrExchRate: Record "Currency Exchange Rate";
        FundsTypes: Record "Funds Transaction Types";
        PHeader: Record "Payments Header";
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        FA: Record "Fixed Asset";
        FundsTaxCodes: Record "Fund Tax Codes";
        VendLedgEntry: Record "Vendor Ledger Entry";
        PayToVendorNo: Code[20];
        ApplyVendEntries: Page "Apply Vendor Entries";
        OK: Boolean;



    trigger OnInsert()
    begin
        "Document Type" := "Document Type"::Payment;
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