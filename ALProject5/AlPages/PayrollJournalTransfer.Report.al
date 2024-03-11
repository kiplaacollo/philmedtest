report 50422 "Payroll Journal Transfer"
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
                if pr_transactions.Find('-') then begin
                    repeat
                        if (pr_transactions.transaction_code <> 'GPAY') and (pr_transactions.transaction_code <> 'NPAY') and (pr_transactions.gl_account_no <> '') then begin
                            TransAmount := 0;
                            TransAmount := pr_transactions.amount * -1;
                            if pr_transactions.transaction_reference = 'INCOME' then
                                TransAmount := pr_transactions.amount;
                            LineNo := LineNo + 1000;
                            CFTFactory.FnCreateGnlJournalLineBalanced('GENERAL', 'SALARY', DocNo, LineNo, GenJournalLine."Transaction Type",
                            GenJournalLine."Account Type", pr_transactions.gl_account_no, PostingDate, TransAmount, '', DocNo, pr_transactions.transaction_name + ' ' + pr_transactions.staff_no, '',
                            GenJournalLine."Bal. Account Type"::"G/L Account", PayrollLiabilitiesAccount);
                            //NSSF EMPLOYER CONTRIBUTION
                            if pr_transactions.transaction_code = 'NSSF' then begin
                                LineNo := LineNo + 1000;
                                CFTFactory.FnCreateGnlJournalLineBalanced('GENERAL', 'SALARY', DocNo, LineNo, GenJournalLine."Transaction Type",
                                GenJournalLine."Account Type", pr_transactions.gl_account_no, PostingDate, TransAmount, '', DocNo, 'NSSF EMPLOYER ' + pr_transactions.staff_no, '',
                                GenJournalLine."Bal. Account Type"::"G/L Account", PayrollGeneralsetup."NSSF Employer Account");
                            end
                        end;
                    until pr_transactions.Next = 0;
                end;

                Counter := Counter + 1;
                Window.Update(1, Round(Counter / TotalCount * 10000, 1));

                pr_transactions.Reset;
                pr_transactions.SetRange(staff_no, st_no);
                pr_transactions.SetRange(period_code, PayrollPeriod);
                if pr_transactions.Find('-') then begin
                    repeat
                        if (pr_transactions.transaction_code <> 'GPAY') and (pr_transactions.transaction_code <> 'NPAY') and (pr_transactions.gl_account_no <> '') and (pr_transactions.transaction_code <> 'NSSF') then begin
                            TransAmount := 0;
                            TransAmount := pr_transactions.amount * -1;
                            if pr_transactions.transaction_reference = 'INCOME' then
                                TransAmount := pr_transactions.amount;
                            LineNo := LineNo + 1000;
                            CFTFactory.FnCreateGnlJournalLineBalanced('GENERAL', 'SALARY', DocNo, LineNo, GenJournalLine."Transaction Type",
                            GenJournalLine."Account Type", pr_transactions.gl_account_no, PostingDate, TransAmount, '', DocNo, pr_transactions.transaction_name + ' ' + pr_transactions.staff_no, '',
                            GenJournalLine."Bal. Account Type"::"G/L Account", PayrollLiabilitiesAccount);
                            //HOUSING EMPLOYER CONTRIBUTION
                            if pr_transactions.transaction_code = 'HOUSELVY' then begin
                                LineNo := LineNo + 1000;
                                CFTFactory.FnCreateGnlJournalLineBalanced('GENERAL', 'SALARY', DocNo, LineNo, GenJournalLine."Transaction Type",
                                GenJournalLine."Account Type", pr_transactions.gl_account_no, PostingDate, TransAmount, '', DocNo, 'Housing EMPLOYER ' + pr_transactions.staff_no, '',
                                GenJournalLine."Bal. Account Type"::"G/L Account", PayrollGeneralsetup."Housing Employer Account");
                            end
                        end;
                    until pr_transactions.Next = 0;
                end;

            end;

            trigger OnPostDataItem()
            begin
                CFTFactory.FnPostJournals('GENERAL', 'SALARY');
                Window.Close;
                // MESSAGE('Journals Posted Successfully');

            end;

            trigger OnPreDataItem()
            begin
                Window.Open('Processing: @1@@@@@@@@@@@@@@@');
                TotalCount := Count;

                LineNo := 0;

                //Create batch*****************************************************************************
                GenJnlBatch.Reset;
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'SALARY');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'SALARY';
                    GenJnlBatch.Insert;
                end;
                // End Create Batch

                // Clear the journal Lines
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'SALARY');
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;

                PayrollGeneralsetup.Get();
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
        PayrollLiabilitiesAccount: Code[50];
        TransAmount: Decimal;
}

