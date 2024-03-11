table 50000 "Payments Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Payment Voucher",Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Accounting",Claim,"Member Bill","Group Bill","Petty Cash";
        }
        field(12; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
            trigger OnValidate()
            var
                BankAcc: Record "Bank Account";
                CurrExchRate: Record "Currency Exchange Rate";
            begin
                TestField("Bank Account");
                if "Currency Code" <> '' then begin
                    if BankAcc.Get("Bank Account") then begin
                        BankAcc.TestField(BankAcc."Currency Code", "Currency Code");
                        "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    end;
                end else begin
                    if BankAcc.Get("Bank Account") then begin
                        BankAcc.TestField(BankAcc."Currency Code", '');
                    end;
                end;
            end;
        }
        field(15; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Payee; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Payee := UpperCase(Payee);
            end;
        }
        field(17; "On Behalf Of"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Payment "; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Cash,Cheque,RTGS,"Letter of Credit","Custom 3","Custom 4","Custom 5";
            Editable = false;
            Caption = 'Payment Mode';
        }
        field(19; Amount; Decimal)
        {
            // flowfield
            // Replaced by New Amount
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Amount(LCY)"; Decimal)
        {
            // flowfield
            // Replaced by New Amount(LCY)
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "VAT Amount"; Decimal)
        {
            // flowfield
            // Replaced by New VAT Amount
            DataClassification = ToBeClassified;
        }
        field(22; "VAT Amount(LCY)"; Decimal)
        {
            // Flowfield
            // Replaced by New VAT Amount(LCY)
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Withholding Tax Amount"; Decimal)
        {
            // Flowfield
            // Replaced by W/Tax Amount
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Withholding Tax Amount(LCY)"; Decimal)
        {
            // flowfield
            // Replaced by W/Tax Amount(LCY)
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(25; "Net Amount"; Decimal)
        {
            // Flowfield
            // Replaced by New Net Amount
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Net Amount(LCY)"; Decimal)
        {
            // flowfield
            // Replaced by New Net Amount(LCY)
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Bank Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
            trigger OnValidate()
            begin
                BankAcc.Reset();
                BankAcc.SetRange(BankAcc."No.", "Bank Account");
                if BankAcc.FindFirst() then begin
                    "Bank Account Name" := BankAcc.Name;
                end else begin
                    "Bank Account Name" := '';
                end;
            end;
        }
        field(28; "Bank Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Bank Account Balance"; Decimal)
        {
            // flowfield
            // Replaced by New Bank Account Balance
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Cheque Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Computer Cheque","Manual Cheque";
            OptionCaption = ',Computer Cheque,Manual Cheque';
        }
        field(31; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                PHeader.Reset();
                if PHeader.FindSet() then begin
                    repeat
                        if PHeader."Cheque No" = "Cheque No" then
                            Error('The Cheque Number has been used in PV No:' + FORMAT(PHeader."No."));
                    until PHeader.Next = 0;
                end;
            end;
        }
        field(32; "Payment Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Payment Description" := UpperCase("Payment Description");
            end;
        }
        field(33; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard));
        }
        field(34; "Global Dimension 2 Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard));
        }
        field(35; "Shortcut Dimension 3 Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Shortcut Dimension 4 Code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(37; "Shortcut Dimension 5 Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Shortcut Dimension 6 Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Shortcut Dimension 7 Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Shortcut Dimension 8 Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(41; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Cancelled;
        }
        field(42; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(43; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(44; "Date Posted"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45; "Time Posted"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(46; Cashier; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(47; "No Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(49; "Retention Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Retention Amount(LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,"Petty Cash",Express,"Cash Purchase",Mobile;
        }
        field(53; "Payment Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Normal Payment","Meeting Payment";
        }
        field(59; "No. Printed"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Payee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Vendor,Employee;
        }
        field(61; "Payee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Payee Type" = const(Vendor)) Vendor;
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if "Payee Type" = "Payee Type"::Vendor then begin
                    Vendor.Reset();
                    Vendor.SetRange(Vendor."No.", "Payee No");
                    if Vendor.FindFirst() then begin
                        Payee := Vendor.Name;
                    end;
                end;
            end;
        }
        field(62; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                "Reversed By" := UserId;
                "Reversal Date" := Today;
                "Reversal Time" := Time;
                Modify();
            end;
        }
        field(63; "Reversed By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(64; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(65; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(66; "Creation Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Apply to Document"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Imprest,Claim;
        }
        field(68; "Apply to Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Apply to Document" = const(Imprest)) "Imprest Header"."No.";
            trigger OnValidate()
            var
                ImprestHeader: Record "Imprest Header";
                ImprestLine: Record "Imprest Lines";
                PaymentLines: Record "Payment Line Table";
            begin
                if "Apply to Document" = "Apply to Document"::Imprest then begin
                    ImprestHeader.Reset();
                    ImprestHeader.SetRange(ImprestHeader."No.", "Apply to Document No");
                    if ImprestHeader.Find('-') then begin
                        "Bank Account" := ImprestHeader."Paying Bank Account";
                        Validate("Bank Account");
                        "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
                        "Responsibility Center" := ImprestHeader."Responsibility Center";
                        Payee := ImprestHeader.Payee;
                        repeat
                            ImprestLine.Reset();
                            ImprestLine.SetRange(ImprestLine.No, "Apply to Document No");
                            if ImprestLine.Find('-') then begin
                                PaymentLines.Reset();
                                PaymentLines.SetRange(PaymentLines."Document No", "No.");
                                if PaymentLines.Find('-') then begin
                                    PaymentLines."Account Type" := PaymentLines."Account Type"::"G/L Account";
                                    PaymentLines."Account No." := ImprestLine."Account No";
                                    PaymentLines."Payment Description" := ImprestLine."Account Name";
                                    if PaymentLines.FindLast() then
                                        PaymentLines."Line No" := PaymentLines."Line No" + 1;
                                    PaymentLines.Amount := ImprestLine.Amount;
                                end;
                            end;
                        until ImprestLine.Next() = 0;
                    end;
                    ImprestLine.Reset();
                    ImprestLine.SetRange(ImprestLine.No, "Apply to Document No");
                    if ImprestLine.Find('-') then begin
                        repeat
                            PaymentLines.Init();
                            PaymentLines."Transaction Type" := 'CUSTOMER';
                            PaymentLines."Document No" := "No.";
                            PaymentLines."Line No" := PaymentLines."Line No" + 1;
                            PaymentLines."Document Type" := PaymentLines."Document Type"::Payment;
                            PaymentLines."Account Type" := PaymentLines."Account Type"::Customer;
                            if ImprestHeader.Get("Apply to Document No") then
                                PaymentLines."Account No." := ImprestHeader."Account No.";
                            PaymentLines.Validate(PaymentLines."Account No.");
                            PaymentLines.Amount := ImprestLine.Amount;
                            PaymentLines.Validate(PaymentLines.Amount);
                            if PaymentLines.Amount <> 0 then
                                PaymentLines.Insert();
                        until ImprestLine.Next = 0;
                    end;
                end;
            end;

        }
        field(69; "Refund Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,caution;
        }
        field(70; "Send SMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Credit Life Admin Fee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Admin Fees Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"), "Account Type" = filter(Posting));
        }
        field(73; "Admin Fees Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "New Amount"; Decimal)
        {
            // Replaces Amount
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line Table".Amount where("Document No" = field("No.")));
            Editable = false;
        }
        field(75; "New Amount(LCY)"; Decimal)
        {
            // Replaces Amount(LCY)
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line Table"."Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
        }
        field(76; "New VAT Amount"; Decimal)
        {
            // Replaces VAT Amount
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line Table"."VAT Amount" where("Document No" = field("No.")));
            Editable = false;
        }
        field(77; "New VAT Amount(LCY)"; Decimal)
        {
            // Replaces VAT Amount(LCY)
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line Table"."VAT Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
        }
        field(78; "New Withholding Tax Amount"; Decimal)
        {
            // Replaces Withholding Tax Amount
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line Table"."W/TAX Amount" where("Document No" = field("No.")));
            Editable = false;
        }
        field(79; "W/Tax Amount(LCY)"; Decimal)
        {
            // Replaces Withholding Tax Amount(LCY)
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line Table"."W/TAX Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
        }
        field(80; "New Net Amount"; Decimal)
        {
            // Replaces Net Amount
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line Table"."Net Amount" where("Document No" = field("No.")));
            Editable = false;
        }
        field(81; "New Net Amount(LCY)"; Decimal)
        {
            // Replaces Net Amount(LCY)
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line Table"."Net Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
        }
        field(82; "New Bank Account Balance"; Decimal)
        {
            // Replaces Bank Account Balance
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Account")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(key2; "Payment Category")
        {

        }
    }

    var
        myInt: Integer;
        Setup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAcc: Record "Bank Account";
        PHeader: Record "Payments Header";
        PaymentLines: Record "Payment Line Table";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            if "Payment Type" = "Payment Type"::Normal then begin
                // Check Payments
                Setup.Get();
                Setup.TestField(Setup."Payment Voucher Nos");
                NoSeriesMgt.InitSeries(Setup."Payment Voucher Nos", xRec."No Series", 0D, "No.", "No Series");
            end;
            if "Payment Type" = "Payment Type"::"Cash Purchase" then begin
                // Cash Payments
                Setup.Get();
                Setup.TestField(Setup."Cash Voucher Nos");
                NoSeriesMgt.InitSeries(Setup."Cash Voucher Nos", xRec."No Series", 0D, "No.", "No Series");
            end;
            if "Payment Type" = "Payment Type"::"Petty Cash" then begin
                // PettyCash Payments
                Setup.Get();
                Setup.TestField(Setup."PettyCash Nos");
                NoSeriesMgt.InitSeries(Setup."PettyCash Nos", xRec."No Series", 0D, "No.", "No Series");
            end;
            if "Payment Type" = "Payment Type"::Mobile then begin
                // Mobile Payments
                Setup.Get();
                Setup.TestField(Setup."Mobile Payment Nos");
                NoSeriesMgt.InitSeries(Setup."Mobile Payment Nos", xRec."No Series", 0D, "No.", "No Series");
            end;
        end;
        "Document Type" := "Document Type"::"Payment Voucher";
        "Document Date" := Today;
        "User ID" := UserId;
        Cashier := UserId;

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        if Status = Status::Open then begin
            PaymentLines.Reset();
            PaymentLines.SetRange(PaymentLines."Document No", "No.");
            if PaymentLines.FindSet() then
                PaymentLines.DeleteAll();
        end else begin
            Error('You can only delete an Open Payment Document. The current status is ' + FORMAT(Status));
        end;
    end;

    trigger OnRename()
    begin

    end;

}