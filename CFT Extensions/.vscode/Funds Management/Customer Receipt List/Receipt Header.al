table 50002 "Receipt Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "No."; code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt;
            Editable = false;
        }
        field(12; Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Bank Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            var
                BankAccount: Record "Bank Account";
            begin
                BankAccount.Reset();
                BankAccount.SetRange(BankAccount."No.", "Bank Code");
                if BankAccount.FindFirst() then begin
                    "Bank Name" := BankAccount.Name;
                end;
            end;
        }
        field(15; "Bank Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Bank Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Code")));
        }
        field(17; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
            trigger OnValidate()
            begin
                Validate("Responsibility Center");
            end;
        }
        field(18; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), "Dimension Value Type" = const(Standard));
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard));
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(23; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(24; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(26; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(27; "Responsibility Center"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
        field(28; "Amount Received"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CurrExchRate: Record "Currency Exchange Rate";
            begin
                if "Currency Code" = '' then begin
                    "Amount Received(LCY)" := "Amount Received";
                end else begin
                    "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                    "Amount Received(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Amount Received", "Currency Factor"));
                end;
            end;
        }
        field(29; "Amount Received(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            // Replaced by field New Total Amount
        }
        field(31; "Total Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
            // Replaced by field New Total Amount(LCY)
        }
        field(32; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
            Editable = false;
        }
        field(34; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(35; "Received From"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(36; "On Behalf of"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(37; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(38; Posted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(39; "Date Posted"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(40; "Time Posted"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(41; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(42; "Cheque No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(43; "Date Created"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(44; "Time Created"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(46; "Receipt Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Bank,Cash;
        }
        // 
        field(51516450; "Investor Transaction"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Principle,Topup;
            Description = 'Investment Management';
        }
        field(51516451; "Interest Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Investment Management';
        }
        field(51516452; "Investor Net Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Receipt Line"."Net Amount" where("Investor Principle/Topup" = const(true), "Document No" = field("No.")));
            Description = 'Investment Management';
            Editable = false;
        }
        // Add Investor Net Amount(LCY)
        field(51516453; "Investor Net Amount (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Receipt Line"."Net Amount(LCY)" where("Investor Principle/Topup" = const(true), "Document No" = field("No.")));
            Editable = false;
            Description = 'Investment Management';
        }
        field(51516454; "Investor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Investment Management';
        }
        field(51516455; "Investor Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'Investment Management';
        }
        field(51516830; "Project Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Project Management Field';
            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
            begin
                if "Project Code" <> '' then begin
                    FA.Reset();
                    FA.SetRange(FA."No.", "Project Code");
                    if FA.FindFirst then begin
                        "Project Name" := FA.Description;
                    end;
                end;
            end;
        }
        field(51516831; "Property Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Project Management Field';
            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
            begin
                if "Property Code" <> '' then begin
                    FA.Reset();
                    FA.SetRange(FA."No.", "Property Code");
                    if FA.FindFirst then begin
                        "Property Name" := FA.Description;
                    end;
                end;
            end;
        }
        field(51516832; "Project Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'Project Management Field';
        }
        field(51516833; "Property Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'Project Management Field';
        }
        field(51516834; "Receipt Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Normal,Investor,Property;
        }
        field(51516835; "Property total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Project Management Field';
        }
        field(51516836; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(51516837; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51516838; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51516839; "Reversed by"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51516840; "New Total Amount"; Decimal)
        {
            // Replaces field Total Amount
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Receipt Line".Amount where("Document No" = field("No.")));
        }
        field(51516841; "New Total Amount (LCY)"; Decimal)
        {
            // Replaces Total Amount(LCY)
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Receipt Line"."Amount(LCY)" where("Document No" = field("No.")));
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        Setup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            Setup.Get();
            Setup.TestField(Setup."Receipt Nos");
            NoSeriesMgt.InitSeries(Setup."Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
        Date := Today;
        "Document Type" := "Document Type"::Receipt;
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