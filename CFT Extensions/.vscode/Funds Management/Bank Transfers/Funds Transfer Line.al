table 50005 "Funds Transfer Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(11; "Document No"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Document Type"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(13; Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Pay Mode"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Cash,Cheque;
        }
        field(16; "Receiving Bank Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
            trigger OnValidate()
            begin
                if BankAcc.Get("Receiving Bank Account") then
                    "Bank Name" := BankAcc.Name;
                BankAcc.CalcFields(BankAcc.Balance);
                BankAcc.CalcFields(BankAcc."Balance (LCY)");
                "Bank Balance" := BankAcc.Balance;
                "Bank Balance(LCY)" := BankAcc."Balance (LCY)";
                FundsHeader.Reset();
                FundsHeader.SetRange(FundsHeader."No.", "Document No");
                if FundsHeader.Find('-') then begin
                    if FundsHeader."Cheque/Doc. No" <> '' then
                        "External Doc No." := FundsHeader."Cheque/Doc. No";
                    FundsLines.Reset();
                    FundsLines.SetRange("Document No", "Document No");
                    if FundsLines.Find('-') then begin
                        FundsLines.CalcSums(FundsLines."Amount to Receive");
                        if (FundsLines."Amount to Receive" > 0) then
                            "Amount to Receive" := FundsHeader."Amount to Transfer" - FundsLines."Amount to Receive"
                        else
                            "Amount to Receive" := FundsHeader."Amount to Transfer";
                        Validate("Amount to Receive");
                    end;
                end;
            end;
        }
        field(17; "Bank Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Bank Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Bank Balance(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Bank Account No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Currency Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Amount to Receive"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                "Amount to Receive(LCY)" := "Amount to Receive";
            end;
        }
        field(24; "Amount to Receive(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(25; "External Doc No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Line No", "Document No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        FundsHeader: Record "Funds Transfer Header";
        BankAcc: Record "Bank Account";
        FundsLines: Record "Funds Transfer Line";

    trigger OnInsert()
    begin
        FundsHeader.Reset();
        FundsHeader.SetRange(FundsHeader."No.", "Document No");
        if FundsHeader.Find('-') then begin
            "Bank Account No." := FundsHeader."Bank Account No.";
            "Pay Mode" := FundsHeader."Pay Mode";
            "Currency Code" := FundsHeader."Currency Code";
        end;

    end;

    trigger OnModify()
    begin
        FundsHeader.Reset();
        FundsHeader.SetRange(FundsHeader."No.", "Document No");
        if FundsHeader.Find('-') then
            if FundsHeader."Cheque/Doc. No" <> '' then
                "External Doc No." := FundsHeader."Cheque/Doc. No"
            else
                "External Doc No." := '';
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}