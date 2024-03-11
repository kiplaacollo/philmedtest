table 50004 "Funds Transfer Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(10; "No."; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Paying Bank Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
            trigger OnValidate()
            var
                BankAcc: Record "Bank Account";
            begin
                if BankAcc.Get("Paying Bank Account") then
                    "Paying Bank Name" := BankAcc.Name;
                BankAcc.CalcFields(BankAcc.Balance);
                BankAcc.CalcFields(BankAcc."Balance (LCY)");
                "Bank Balance" := BankAcc.Balance;
                "Bank Balance(LCY)" := BankAcc."Balance (LCY)";
            end;
        }
        field(14; "Paying Bank Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Bank Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Bank Balance(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Bank Account No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(18; "Currency Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency.Code;
        }
        field(19; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Amount to Transfer"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Amount to Transfer(LCY)" := "Amount to Transfer";
            end;
        }
        field(21; "Amount to Transfer(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        // flowfield
        field(22; "Total Line Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Funds Transfer Line"."Amount to Receive" where("Document No" = field("No.")));
            Editable = false;
        }
        field(23; "Total Line Amount(LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Funds Transfer Line"."Amount to Receive(LCY)" where("Document No" = field("No.")));
            Editable = false;
        }
        field(24; "Pay Mode"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Cash,Cheque,RTGS;
        }
        field(25; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted,Cancelled;
        }
        field(26; "Cheque/Doc. No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(27; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(28; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Enabled = false;
        }
        field(29; Posted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Posted By"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(31; "Date Posted"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Time Posted"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(33; "Created By"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Date Created"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Time Created"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(36; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order","Payment voucher","Imprest Requisition","Imprest Surrender","Funds Transfer";
        }
        field(37; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(38; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Reversed By"; Code[50])
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

    var
        myInt: Integer;
        GenLedgerSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GenLedgerSetup.Get;
            begin
                GenLedgerSetup.TestField(GenLedgerSetup."Funds Transfer Nos");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Funds Transfer Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
        end;
        "Document Type" := "Document Type"::"Funds Transfer";
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