report 50428 "Payroll Posting"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; pr_employees)
        {
            trigger OnPreDataItem()
            begin
                Window.OPEN('Processing: @1@@@@@@@@@@@@@@@');
                TotalCount := COUNT;

                LineNo := 0;

                //Create batch*****************************************************************************
                GenJnlBatch.RESET;
                GenJnlBatch.SETRANGE(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SETRANGE(GenJnlBatch.Name, 'NET PAY');
                IF GenJnlBatch.FIND('-') = FALSE THEN BEGIN
                    GenJnlBatch.INIT;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'NET PAY';
                    GenJnlBatch.INSERT;
                END;
                // End Create Batch

                // Clear the journal Lines
                GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", 'NET PAY');
                IF GenJournalLine.FIND('-') THEN
                    GenJournalLine.DELETEALL;

                PayrollGeneralsetup.GET();
                PayingBank := PayrollGeneralsetup."Paying Bank";

            end;

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                // Window.UPDATE(1, ROUND(Counter / TotalCount * 10000, 1));

                pr_transactions.RESET;
                pr_transactions.SETRANGE(staff_no, st_no);
                pr_transactions.SETRANGE(period_code, PayrollPeriod);
                pr_transactions.SETFILTER(gl_account_no, '<>%1', ' ');
                IF pr_transactions.FIND('-') THEN BEGIN
                    REPEAT
                        IF pr_transactions.gl_account_no <> '' THEN BEGIN
                            Amount := 0;
                            Amount := pr_transactions.amount * -1;
                            IF pr_transactions.transaction_reference = 'INCOME' THEN
                                Amount := pr_transactions.amount;
                            LineNo := LineNo + 1000;
                            CFTFactory.FnGenerateGeneralJournalLine('GENERAL', 'NET PAY', LineNo, '', PostingDate, DocNo, DocNo,
                                                                    GenJournalLine."Account Type"::"G/L Account", pr_transactions.gl_account_no,
                                                                    Amount, FORMAT(st_no) + ' ' + FORMAT(PayrollPeriod) + ' Salary', GenJournalLine."Transaction Type"::" ", '', '', '', '');

                            LineNo := LineNo + 1000;
                            CFTFactory.FnGenerateGeneralJournalLine('GENERAL', 'NET PAY', LineNo, '', PostingDate, DocNo, DocNo, GenJournalLine."Account Type"::"Bank Account", PayingBank,
                            pr_transactions.amount * -1, FORMAT(st_no) + ' ' + FORMAT(PayrollPeriod) + ' Salary', GenJournalLine."Transaction Type"::" ", '', '', '', '');
                        END;
                    UNTIL pr_transactions.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE('Journals Created Successfully');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Period)
                {
                    field(PayrollPeriod; PayrollPeriod)
                    {
                        TableRelation = pr_periods.period_code;
                    }
                    field(DocNo; DocNo)
                    {
                        Caption = 'Document No';
                    }
                    field(PostingDate; PostingDate)
                    {

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnPreReport()
    begin
        IF CONFIRM('Are you sure you want to transfer payroll items to the journal?', FALSE) = FALSE THEN BEGIN
            MESSAGE('Process aborted');
            CurrReport.QUIT;
        END;
    end;

    var
        myInt: Integer;
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        PayrollGeneralsetup: Record "Payroll General Setup";
        PayrollLiabilitiesAccount: Code[50];
        Counter: Integer;
        pr_transactions: Record pr_transactions;
        Window: Dialog;
        TotalCount: Integer;
        PayrollPeriod: Code[50];
        TransAmount: Decimal;
        LineNo: Integer;
        CFTFactory: Codeunit "CFT Factory";
        DocNo: Code[50];
        PostingDate: Date;
        PayingBank: Code[50];
        Amount: Decimal;
}