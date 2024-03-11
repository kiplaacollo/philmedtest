tableextension 50126 "General Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(50100; "Invoice Balance"; Decimal)
        {
            Caption = 'Invoice Balance';
            Editable = false;
        }
        field(50101; "MPESA Entry"; Boolean)
        {
            Caption = 'MPESA Entry';
            Editable = false;
        }
        field(50102; "Direct Unapplied Amount"; Decimal)
        {
            Caption = 'Direct Unapplied Amount';
            Editable = false;
        }
        field(50103; "Applies-To ID Amount"; Decimal)
        {
            Caption = 'Applies-To ID Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Cust. Ledger Entry"."Amount to Apply" Where("Applies-To ID" = Field("Document No.")));
        }
        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()
            begin
                CalculateInvoiceBalance;
            end;
        }
        modify(Amount)
        {
            trigger OnAfterValidate()
            begin
                CalculateInvoiceBalance;
            end;
        }

    }
    trigger OnAfterModify()
    begin
        //AMI MPESA Integration 08052022
        IF (Amount <> xRec.Amount) AND ("MPESA Entry") THEN
            ERROR('MPESA Entry Amounts Cannot be Edited');

        IF ("External Document No." <> xRec."External Document No.") AND ("MPESA Entry") THEN
            ERROR('MPESA Entry External Document No. Cannot be Edited');
        //</AMI>

    end;

    trigger OnAfterDelete()
    var
        lvMPESATransaction: Record "MPESA Transaction";
    begin
        //AMI MPESA Integration 08052022
        IF "MPESA Entry" THEN BEGIN
            lvMPESATransaction.SETRANGE(TransID, "External Document No.");
            IF lvMPESATransaction.FINDFIRST THEN BEGIN
                lvMPESATransaction.DocumentNo := '';
                lvMPESATransaction.PostingDate := 0D;
                lvMPESATransaction.MODIFY;
            END;
        END;
    end;

    procedure CalculateInvoiceBalance()
    var
        lvCustomerLedger: Record "Cust. Ledger Entry";
    begin
        if (rec."Applies-to Doc. No." <> '') and (Rec."Applies-to Doc. Type" = Rec."Applies-to Doc. Type"::Invoice)
        and (rec."Journal Template Name" = 'CASH RECE') then begin
            lvCustomerLedger.SetRange("Document Type", lvCustomerLedger."Document Type"::Invoice);
            lvCustomerLedger.SetRange("Customer No.", rec."Account No.");
            lvCustomerLedger.SetRange("Document No.", Rec."Applies-to Doc. No.");
            if lvCustomerLedger.FindFirst() then begin
                lvCustomerLedger.CalcFields("Remaining Amount");
                Rec."Invoice Balance" := lvCustomerLedger."Remaining Amount" + Rec.Amount;
                //Amount Not Allocated
                If lvCustomerLedger."Remaining Amount" >= Abs(Rec.Amount) then
                    Rec."Direct Unapplied Amount" := 0
                else
                    Rec."Direct Unapplied Amount" := Abs(Rec.Amount) - lvCustomerLedger."Remaining Amount";

            end else begin
                Rec."Invoice Balance" := 0;
            end;
        end Else begin
            Rec."Invoice Balance" := 0;
        end;
    end;
}
