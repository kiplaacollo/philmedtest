report 50428 "Payroll Posting"
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
                pr_transactions.SetRange(period_code, PayrollPeriod);
                pr_transactions.SetFilter(gl_account_no, '<>%1', ' ');
                if pr_transactions.Find('-') then begin
                    repeat
                        if pr_transactions.gl_account_no <> '' then begin
                            Amount := 0;
                            Amount := pr_transactions.amount * -1;
                            if pr_transactions.transaction_reference = 'INCOME' then
                                Amount := pr_transactions.amount;
                            LineNo := LineNo + 1000;
                            CFTFactory.FnGenerateGeneralJournalLine('GENERAL', 'NET PAY', LineNo, '', PostingDate, DocNo, DocNo,
                                                                    GenJournalLine."Account Type"::"G/L Account", pr_transactions.gl_account_no,
                                                                    Amount, Format(st_no) + ' ' + Format(PayrollPeriod) + ' Salary', GenJournalLine."Transaction Type"::" ", '', '', '');

                            LineNo := LineNo + 1000;
                            CFTFactory.FnGenerateGeneralJournalLine('GENERAL', 'NET PAY', LineNo, '', PostingDate, DocNo, DocNo, GenJournalLine."Account Type"::"Bank Account", PayingBank,
                            pr_transactions.amount * -1, Format(st_no) + ' ' + Format(PayrollPeriod) + ' Salary', GenJournalLine."Transaction Type"::" ", '', '', '');
                        end;
                    until pr_transactions.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close;
                Message('Journals Created Successfully');

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
                    TableRelation = pr_periods.period_code;
                }
                field("Document No"; DocNo)
                {
                    Caption = 'Document No';
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
}

