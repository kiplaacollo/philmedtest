report 50422 "Payroll Journal Tranfer"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; pr_employees)
        {
            trigger OnPreDataItem()
            var
                Window: Dialog;
                TotalCount: Integer;
                LineNo: Integer;
            begin
                Window.Open('Processing: @1@@@@@@@@@@@@@@@');
                TotalCount := COUNT;

                LineNo := 0;
                //Create batch*****************************************************************************
                GenJnlBatch.RESET;
                GenJnlBatch.SETRANGE(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SETRANGE(GenJnlBatch.Name, 'SALARY');
                IF GenJnlBatch.FIND('-') = FALSE THEN BEGIN
                    GenJnlBatch.INIT;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'SALARY';
                    GenJnlBatch.INSERT;
                END;
                // End Create Batch
                // Clear the journal Lines
                GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", 'SALARY');
                IF GenJournalLine.FIND('-') THEN
                    GenJournalLine.DELETEALL;
                PayrollGeneralsetup.GET();
                PayrollLiabilitiesAccount := PayrollGeneralsetup."Payroll Liabilities Account";
            end;

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                //Window.UPDATE(1, ROUND(Counter / TotalCount * 10000, 1));

                pr_transactions.RESET;
                pr_transactions.SETRANGE(staff_no, st_no);
                pr_transactions.SETRANGE(period_code, PayrollPeriod);
                IF pr_transactions.FIND('-') THEN BEGIN
                    REPEAT
                        IF (pr_transactions.transaction_code <> 'GPAY') AND (pr_transactions.transaction_code <> 'NPAY') AND (pr_transactions.gl_account_no <> '') THEN BEGIN
                            TransAmount := 0;
                            TransAmount := pr_transactions.amount * -1;
                            IF pr_transactions.transaction_reference = 'INCOME' THEN
                                TransAmount := pr_transactions.amount;
                            LineNo := LineNo + 1000;
                            CFTFactory.CreateGnlJournalLineBalanced('GENERAL', 'SALARY', DocNo, LineNo, GenJournalLine."Transaction Type",
                            GenJournalLine."Account Type", pr_transactions.gl_account_no, PostingDate, TransAmount, '', DocNo, pr_transactions.transaction_name + ' ' + pr_transactions.staff_no, '',
                            GenJournalLine."Bal. Account Type"::"G/L Account", PayrollLiabilitiesAccount);
                            //NSSF EMPLOYER CONTRIBUTION
                            IF pr_transactions.transaction_code = 'NSSF' THEN BEGIN
                                LineNo := LineNo + 1000;
                                CFTFactory.CreateGnlJournalLineBalanced('GENERAL', 'SALARY', DocNo, LineNo, GenJournalLine."Transaction Type",
                                GenJournalLine."Account Type", pr_transactions.gl_account_no, PostingDate, TransAmount, '', DocNo, 'NSSF EMPLOYER ' + pr_transactions.staff_no, '',
                                GenJournalLine."Bal. Account Type"::"G/L Account", PayrollGeneralsetup."NSSF Employer Account");
                            END
                        END;
                    UNTIL pr_transactions.NEXT = 0;
                END;

                Counter := Counter + 1;
                //Window.UPDATE(1, ROUND(Counter / TotalCount * 10000, 1));

                pr_transactions.RESET;
                pr_transactions.SETRANGE(staff_no, st_no);
                pr_transactions.SETRANGE(period_code, PayrollPeriod);
                IF pr_transactions.FIND('-') THEN BEGIN
                    REPEAT
                        IF (pr_transactions.transaction_code <> 'GPAY') AND (pr_transactions.transaction_code <> 'NPAY') AND (pr_transactions.gl_account_no <> '') AND (pr_transactions.transaction_code <> 'NSSF') THEN BEGIN
                            TransAmount := 0;
                            TransAmount := pr_transactions.amount * -1;
                            IF pr_transactions.transaction_reference = 'INCOME' THEN
                                TransAmount := pr_transactions.amount;
                            LineNo := LineNo + 1000;
                            CFTFactory.CreateGnlJournalLineBalanced('GENERAL', 'SALARY', DocNo, LineNo, GenJournalLine."Transaction Type",
                            GenJournalLine."Account Type", pr_transactions.gl_account_no, PostingDate, TransAmount, '', DocNo, pr_transactions.transaction_name + ' ' + pr_transactions.staff_no, '',
                            GenJournalLine."Bal. Account Type"::"G/L Account", PayrollLiabilitiesAccount);
                            //HOUSING EMPLOYER CONTRIBUTION
                            IF pr_transactions.transaction_code = 'HOUSELVY' THEN BEGIN
                                LineNo := LineNo + 1000;
                                CFTFactory.CreateGnlJournalLineBalanced('GENERAL', 'SALARY', DocNo, LineNo, GenJournalLine."Transaction Type",
                                GenJournalLine."Account Type", pr_transactions.gl_account_no, PostingDate, TransAmount, '', DocNo, 'Housing EMPLOYER ' + pr_transactions.staff_no, '',
                                GenJournalLine."Bal. Account Type"::"G/L Account", PayrollGeneralsetup."Housing Employer Account");
                            END
                        END;
                    UNTIL pr_transactions.NEXT = 0;
                END;

            end;

            trigger OnPostDataItem()
            begin
                CFTFactory.FnPostJournals('GENERAL', 'SALARY');
                //Window.CLOSE;
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
                        TableRelation = pr_periods.period_code where(Closed = const(false));
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

}