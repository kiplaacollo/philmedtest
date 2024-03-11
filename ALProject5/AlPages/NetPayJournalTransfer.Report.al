report 50423 "NetPay Journal Transfer"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(pr_employees; pr_employees)
        {

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.Update(1, Round(Counter / TotalCount * 10000, 1));

                pr_transactions.Reset;
                pr_transactions.SetRange(staff_no, st_no);
                pr_transactions.SetRange(transaction_code, 'NPAY');
                pr_transactions.SetRange(period_code, PayrollPeriod);
                if pr_transactions.Find('-') then begin
                    LineNo := LineNo + 10000;
                    Amount := 0;
                    Amount := pr_transactions.amount * -1;
                    if pr_transactions.transaction_reference = 'INCOME' then
                        Amount := pr_transactions.amount;
                    LineNo := LineNo + 1000;
                    //          CFTFactory.FnCreateGnlJournalLineBalanced('GENERAL','NET PAY',DocNo,LineNo,GenJournalLine."Transaction Type",
                    //          GenJournalLine."Account Type"::"Bank Account",PayingBank,PostingDate,pr_transactions.amount*-1,'',DocNo,pr_transactions.transaction_name+' '+pr_transactions.staff_no,'',
                    //          GenJournalLine."Bal. Account Type"::"G/L Account",PayrollLiabilitiesAccount);

                    CFTFactory.FnGenerateGeneralJournalLine('GENERAL', 'NET PAY', LineNo, '', PostingDate, DocNo, DocNo,
                                                            GenJournalLine."Account Type"::"G/L Account", PayrollLiabilitiesAccount,
                                                            Amount, pr_transactions.transaction_name + ' ' + pr_transactions.staff_no, GenJournalLine."Transaction Type"::" ", '', '', '');
                end;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close;
                Message('Journals Posted Successfully');

            end;

            trigger OnPreDataItem()
            begin
                Window.Open('Processing: @1@@@@@@@@@@@@@@@');
                TotalCount := Count;

                LineNo := 0;

                //Create batch*****************************************************************************
                GenJnlBatch.Reset;
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'NET PAY');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'NET PAY';
                    GenJnlBatch.Insert;
                end;
                // End Create Batch

                // Clear the journal Lines
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'NET PAY');
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;

                PayrollGeneralsetup.Get();
                PayingBank := PayrollGeneralsetup."Paying Bank";
                PayrollLiabilitiesAccount := PayrollGeneralsetup."Payroll Liabilities Account";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PayrollPeriod; PayrollPeriod)
                {
                    Caption = 'Period';
                    TableRelation = pr_periods.period_code WHERE (Closed = CONST (false));
                }
                field("Document No"; DocNo)
                {
                    Caption = 'Document No';
                }
                field("AmountPaid "; AmountPaid)
                {
                    Caption = 'Amount Paid';
                }
                field("Posting Date"; PostingDate)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."View Payroll" then
                Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
        end else
            Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
    end;

    trigger OnPostReport()
    begin
        LineNo := LineNo + 1000;

        CFTFactory.FnGenerateGeneralJournalLine('GENERAL', 'NET PAY', LineNo, '', PostingDate, DocNo, DocNo,
                                                     GenJournalLine."Account Type"::"Bank Account", PayingBank,
                                                     AmountPaid * -1, 'NET SAL ' + PayrollPeriod, GenJournalLine."Transaction Type"::" ", '', '', '');

        CFTFactory.FnPostJournals('GENERAL', 'NET PAY');
    end;

    trigger OnPreReport()
    begin

        if Confirm('Are you sure you want to transfer payroll items to the journal?', false) = false then begin
            Message('Process aborted');
            CurrReport.Quit;
        end;

        if UserSetup.Get(UserId) then begin
            if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
    end;

    var
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        UserSetup: Record "User Setup";
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        PayrollPeriod: Code[50];
        DocNo: Code[50];
        PostingDate: Date;
        LineNo: Integer;
        pr_transactions: Record pr_transactions;
        CFTFactory: Codeunit "CFT Factory";
        PayrollGeneralsetup: Record "Payroll General setup";
        PayingBank: Code[50];
        Amount: Decimal;
        PayrollLiabilitiesAccount: Code[20];
        AmountPaid: Decimal;
}

