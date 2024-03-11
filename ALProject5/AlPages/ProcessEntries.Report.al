report 50000 "Process Entries"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("BC Mpesa Integration"; "BC Mpesa Integration")
        {
            DataItemTableView = WHERE (processed = FILTER (false));
            RequestFilterFields = mpesa_ref, acc_no, phone_no, updated_at;
            column(mpesaref_BCMpesaIntegration; mpesa_ref)
            {
            }
            column(accno_BCMpesaIntegration; acc_no)
            {
            }
            column(phoneno_BCMpesaIntegration; phone_no)
            {
            }
            column(updatedat_BCMpesaIntegration; updated_at)
            {
            }
            column(processed_BCMpesaIntegration; processed)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Objcust.Reset;
                Objcust.SetRange("No.", "BC Mpesa Integration".acc_no);
                if Objcust.Find('-') then begin
                    objcustled.Reset;
                    objcustled.SetRange("External Document No.", "BC Mpesa Integration".mpesa_ref);
                    objcustled.SetRange("Customer No.", "BC Mpesa Integration".acc_no);
                    objcustled.SetRange("Posting Date", DT2Date("BC Mpesa Integration".updated_at));
                    if not objcustled.Find('-') then begin
                        ObjMpesa.Reset;
                        ObjMpesa.SetRange(mpesa_ref, "BC Mpesa Integration".mpesa_ref);
                        if ObjMpesa.Find('-') then begin
                            begin
                                NextNo := NoSeriesMgt.GetNextNo(RCPT, 0D, true);
                                ObjMpesa."Receipt No" := NextNo;
                                ObjMpesa.Modify;
                            end;
                        end;

                        LineNo := LineNo + 1000;
                        TransDate := DT2Date("BC Mpesa Integration".updated_at);
                        if "BC Mpesa Integration".trans_amt <> 0 then begin
                            FnGenerateJournalLines(JTemplate, JBatch, LineNo, GenJournalLine."Document Type"::Payment, TransDate, NextNo,
                                                    "BC Mpesa Integration".mpesa_ref, GenJournalLine."Account Type"::"Bank Account", BankAcc, "BC Mpesa Integration".trans_amt, 'MPESA- PAYBILL',
                                                    '', '', GenJournalLine."Account Type"::Customer, "BC Mpesa Integration".acc_no);
                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Records Successfully Transferred to MPESAPAYBL Journal Batch for Posting.');
            end;

            trigger OnPreDataItem()
            begin
                ObjMpesaConfig.Reset;
                if ObjMpesaConfig.Find('-') then begin
                    JTemplate := ObjMpesaConfig."Journal Template Name";
                    JBatch := ObjMpesaConfig."Journal Batch";
                    BankAcc := ObjMpesaConfig."Bank Account";
                    RCPT := ObjMpesaConfig."Receipt No";
                end;

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    GenJournalLine.DeleteAll;
                end;


                LineNo := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjMpesaConfig: Record "Mpesa General Config";
        JTemplate: Code[50];
        JBatch: Code[50];
        BankAcc: Code[50];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        TransDate: Date;
        objcustled: Record "Cust. Ledger Entry";
        Objcust: Record Customer;
        ObjMpesa: Record "BC Mpesa Integration";
        NextNo: Code[10];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RCPT: Code[50];

    local procedure FnGenerateJournalLines(JTemplate: Code[100]; JBatch: Code[100]; LineNo: Integer; DocumentType: Option; PostingDate: Date; DocumentNo: Code[50]; ExternalDocumentNo: Code[50]; AccountType: Option; AccountNo: Code[50]; Amount: Decimal; Description: Text[250]; ActivityCode: Code[50]; BranchCode: Code[50]; BalAccountType: Option; BalAccountNo: Code[50])
    var
        ObjGL: Record "Gen. Journal Line";
    begin
        ObjGL.Init;
        ObjGL."Journal Template Name" := JTemplate;
        ObjGL.Validate(ObjGL."Journal Template Name");
        ObjGL."Journal Batch Name" := JBatch;
        ObjGL.Validate(ObjGL."Journal Batch Name");
        ObjGL."Line No." := LineNo;
        ObjGL."Document Type" := DocumentType;
        ObjGL."Posting Date" := PostingDate;
        ObjGL."Document No." := DocumentNo;
        ObjGL."External Document No." := ExternalDocumentNo;
        ObjGL."Account Type" := AccountType;
        ObjGL."Account No." := AccountNo;
        ObjGL.Validate(ObjGL."Account No.");
        ObjGL.Amount := Amount;
        ObjGL.Validate(ObjGL.Amount);
        ObjGL.Description := Description;
        ObjGL.Validate(ObjGL.Description);
        ObjGL."Shortcut Dimension 1 Code" := ActivityCode;
        ObjGL."Shortcut Dimension 2 Code" := BranchCode;
        ObjGL."Bal. Account Type" := BalAccountType;
        ObjGL."Bal. Account No." := BalAccountNo;
        ObjGL.Validate(ObjGL."Bal. Account No.");
        if ObjGL.Amount <> 0 then
            ObjGL.Insert;
    end;
}

