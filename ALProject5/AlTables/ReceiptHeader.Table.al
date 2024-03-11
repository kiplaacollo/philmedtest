table 50003 "Receipt Header"
{

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;
        }
        field(2; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt;
        }
        field(3; Date; Date)
        {
            Editable = true;
        }
        field(4; "Posting Date"; Date)
        {
        }
        field(5; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.", "Bank Code");
                if BankAccount.FindFirst then begin
                    "Bank Name" := BankAccount.Name;
                end;
            end;
        }
        field(6; "Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(7; "Bank Balance"; Decimal)
        {
            CalcFormula = Sum ("Bank Account Ledger Entry".Amount WHERE ("Bank Account No." = FIELD ("Bank Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Currency Code"; Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                Validate("Currency Code");
            end;
        }
        field(9; "Currency Factor"; Decimal)
        {
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1),
                                                          "Dimension Value Type" = CONST (Standard));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2),
                                                          "Dimension Value Type" = CONST (Standard));
        }
        field(12; "Shortcut Dimension 3 Code"; Code[20])
        {
        }
        field(13; "Shortcut Dimension 4 Code"; Code[20])
        {
        }
        field(14; "Shortcut Dimension 5 Code"; Code[20])
        {
        }
        field(15; "Shortcut Dimension 6 Code"; Code[20])
        {
        }
        field(16; "Shortcut Dimension 7 Code"; Code[20])
        {
        }
        field(17; "Shortcut Dimension 8 Code"; Code[20])
        {
        }
        field(18; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(19; "Amount Received"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then begin
                    "Amount Received(LCY)" := "Amount Received";
                end else begin
                    "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    "Amount Received(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Amount Received", "Currency Factor"));
                end;
            end;
        }
        field(20; "Amount Received(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(21; "Total Amount"; Decimal)
        {
            CalcFormula = Sum ("Receipt Line".Amount WHERE ("Document No" = FIELD ("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Total Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum ("Receipt Line"."Amount(LCY)" WHERE ("Document No" = FIELD ("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "User ID"; Code[20])
        {
            Editable = false;
        }
        field(24; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
        }
        field(25; Description; Text[50])
        {
        }
        field(26; "Received From"; Text[50])
        {
        }
        field(27; "On Behalf of"; Text[50])
        {
        }
        field(28; "No. Series"; Code[20])
        {
        }
        field(29; Posted; Boolean)
        {
            Editable = true;
        }
        field(30; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(31; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(32; "Posted By"; Code[20])
        {
            Editable = false;
        }
        field(33; "Cheque No"; Code[20])
        {
        }
        field(34; "Date Created"; Date)
        {
            Editable = false;
        }
        field(35; "Time Created"; Time)
        {
            Editable = false;
        }
        field(36; "Receipt Type"; Option)
        {
            OptionCaption = 'Bank,Cash';
            OptionMembers = Bank,Cash;
        }
        field(49; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Reversed by"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            Setup.Get;
            Setup.TestField(Setup."Receipt No");
            NoSeriesMgt.InitSeries(Setup."Receipt No", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "User ID" := UserId;
        Date := Today;
        "Document Type" := "Document Type"::Receipt;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankAccount: Record "Bank Account";
        CurrExchRate: Record "Currency Exchange Rate";
        FA: Record "Fixed Asset";
        Setup: Record "Mpesa General Config";
}

