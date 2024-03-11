pageextension 50117 CashReceiptJournalExt extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Applies-to Doc. No.")
        {
            field("Invoice Balance"; Rec."Invoice Balance")
            {
                ApplicationArea = all;
            }
            field("Direct Unapplied Amount"; Rec."Direct Unapplied Amount")
            {
                ApplicationArea = all;
            }
            field("Applies-To ID Amount"; Rec."Applies-To ID Amount")
            {
                ApplicationArea = All;
            }
        }

        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }

        movebefore(Amount; "Debit Amount", "Credit Amount")

        modify("External Document No.")
        {
            Visible = true;
        }
    }
    actions
    {
        addafter("Apply Entries")
        {
            action(GetMPESATransactions)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Get MPESA Transactions';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvMPESATransactions: Page "MPESA Transactions";
                begin
                    lvMPESATransactions.SetTemplate(Rec."Journal Template Name", Rec."Journal Batch Name");
                    lvMPESATransactions.RUN;
                end;
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                lvUserSetup: Record "User Setup";
                lvJournalLine: Record "Gen. Journal Line";
                lvSalesSetup: Record "Sales & Receivables Setup";
            begin
                if lvUserSetup.get(UserId) then
                    if not lvUserSetup."Allow Posting of Journals" then
                        error('You do not have permission to post journals');


                //Post Dated Batch Checks
                lvSalesSetup.Get();
                if (rec."Journal Batch Name" = lvSalesSetup."Postdated Check Jnl Batch") And (rec."Journal Template Name" = lvSalesSetup."Postdated Check Jnl Template") then begin

                    lvJournalLine.RESET;
                    lvJournalLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    lvJournalLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    lvJournalLine.SetFilter("Posting Date", '<=%1', Today);
                    IF lvJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", lvJournalLine);
                    END ELSE begin
                        Message('No Entries are ready for Posting!');
                    end;

                    Commit();
                    Error('');
                end;

                //Check Application
                lvJournalLine.RESET;
                lvJournalLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                lvJournalLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                IF lvJournalLine.FindFirst() THEN
                    repeat
                        if not lvJournalLine.IsApplied() then
                            Error('Journal Line No. %1 is not Applied!', lvJournalLine."Line No.");

                    //Check complete Direct Allocation
                    /*If lvJournalLine."Applies-to Doc. No." <> '' then begin
                        if lvJournalLine."Direct Unapplied Amount" > 0 then
                            Error('Journal Line No. %1 Document No. %2 is NOT fully Applied! It has Un-applied Amount of %3',
                                    lvJournalLine."Line No.", lvJournalLine."Document No.", lvJournalLine."Direct Unapplied Amount");
                    end;

                    //Check complete Apply Entry Allocation
                    If lvJournalLine."Applies-to Doc. No." = '' then begin
                        lvJournalLine.CalcFields("Applies-To ID Amount");
                        if lvJournalLine."Applies-To ID Amount" < lvJournalLine."Credit Amount" then
                            Error('Journal Line No. %1 Document No. %2 is NOT fully Applied! It has Un-applied Amount of %3',
                                    lvJournalLine."Line No.", lvJournalLine."Document No.", (lvJournalLine."Credit Amount" - lvJournalLine."Applies-To ID Amount"));
                    end;*/
                    until lvJournalLine.Next() = 0;

            end;

        }

        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                lvUserSetup: Record "User Setup";
                lvJournalLine: Record "Gen. Journal Line";
                lvSalesSetup: Record "Sales & Receivables Setup";
            begin
                if lvUserSetup.get(UserId) then
                    if not lvUserSetup."Allow Posting of Journals" then
                        error('You do not have permission to post journals');

                //Post Dated Batch Checks
                lvSalesSetup.Get();
                if (rec."Journal Batch Name" = lvSalesSetup."Postdated Check Jnl Batch") And (rec."Journal Template Name" = lvSalesSetup."Postdated Check Jnl Template") then begin

                    lvJournalLine.RESET;
                    lvJournalLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    lvJournalLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    lvJournalLine.SetFilter("Posting Date", '<=%1', Today);
                    IF lvJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", lvJournalLine);
                    END ELSE begin
                        Message('No Entries are ready for Posting!');
                    end;

                    Commit();
                    Error('');
                end;

                //Check Application
                lvJournalLine.RESET;
                lvJournalLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                lvJournalLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                IF lvJournalLine.FindFirst() THEN
                    repeat
                        if not lvJournalLine.IsApplied() then
                            Error('Journal Line No. %1 is not Applied!', lvJournalLine."Line No.");

                    //Check complete Direct Allocation
                    /* If lvJournalLine."Applies-to Doc. No." <> '' then begin
                         if lvJournalLine."Direct Unapplied Amount" > 0 then
                             Error('Journal Line No. %1 Document No. %2 is NOT fully Applied! It has Un-applied Amount of %3',
                                     lvJournalLine."Line No.", lvJournalLine."Document No.", lvJournalLine."Direct Unapplied Amount");
                     end;

                     //Check complete Apply Entry Allocation
                     If lvJournalLine."Applies-to Doc. No." = '' then begin
                         lvJournalLine.CalcFields("Applies-To ID Amount");
                         if lvJournalLine."Applies-To ID Amount" < lvJournalLine."Credit Amount" then
                             Error('Journal Line No. %1 Document No. %2 is NOT fully Applied! It has Un-applied Amount of %3',
                                     lvJournalLine."Line No.", lvJournalLine."Document No.", (lvJournalLine."Credit Amount" - lvJournalLine."Applies-To ID Amount"));
                     end;*/

                    until lvJournalLine.Next() = 0;
            end;
        }
    }
}

pageextension 50118 PaymentJournalExt extends "Payment Journal"
{
    layout
    {

        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("Recipient Bank Account")
        {
            Visible = false;
        }
        modify("Message to Recipient")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Bank Payment Type")
        {
            Visible = false;
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Exported to Payment File")
        {
            Visible = false;
        }
        modify(TotalExportedAmount)
        {
            Visible = false;
        }
        modify("Has Payment Export Error")
        {
            Visible = false;
        }
        movebefore(Amount; "Debit Amount", "Credit Amount")
    }
    actions
    {
        addafter(ApplyEntries)
        {
            action(PaymentVoucher)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Voucher';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvJournalLine: Record "Gen. Journal Line";
                    PaymentVoucher: report "Payment Voucher";
                begin
                    lvJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    lvJournalLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
                    PaymentVoucher.SetTableView(lvJournalLine);
                    PaymentVoucher.Run();
                end;
            }
            action(PettyCashVoucher)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Petty Cash Voucher';
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lvJournalLine: Record "Gen. Journal Line";
                    PettyCashVoucher: report "Petty Cash Voucher";
                begin
                    lvJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    lvJournalLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
                    PettyCashVoucher.SetTableView(lvJournalLine);
                    PettyCashVoucher.Run();
                end;
            }

        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                lvUserSetup: Record "User Setup";

            begin
                if lvUserSetup.get(UserId) then
                    if not lvUserSetup."Allow Posting of Journals" then
                        error('You do not have permission to post journals');

            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                lvUserSetup: Record "User Setup";

            begin
                if lvUserSetup.get(UserId) then
                    if not lvUserSetup."Allow Posting of Journals" then
                        error('You do not have permission to post journals');

            end;
        }
    }
}

pageextension 50119 GeneralJournalExt extends "General Journal"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Due Date"; Rec."Due Date")
            { }

        }
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("Payment Terms Code")
        {
            Visible = true;
        }
        movebefore(Amount; "Debit Amount", "Credit Amount")
    }
    actions
    {
        addafter("Apply Entries")
        {
            action("Validate Due Date")
            {

                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    lvCustomer: Record Customer;
                    lvVendor: Record Vendor;
                    PaymentTerms: Record "Payment Terms";

                begin
                    GenJournalLine.Reset();
                    GenJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    GenJournalLine.SetRange("Journal Template Name", Rec."Journal Batch Name");
                    //GenJournalLine.SetRange("Account Type", GenJournalLine."Account Type"::Customer);
                    GenJournalLine.SetRange("Document Type", GenJournalLine."Document Type"::Invoice);
                    if GenJournalLine.FindFirst() then
                        repeat
                            if Rec."Payment Terms Code" <> '' then begin
                                PaymentTerms.Get(rec."Payment Terms Code");
                                Rec."Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", Rec."Posting Date");
                            end;

                        until GenJournalLine.Next() = 0;
                end;
            }

        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                lvUserSetup: Record "User Setup";
            begin
                if lvUserSetup.get(UserId) then
                    if not lvUserSetup."Allow Posting of Journals" then
                        error('You do not have permission to post journals');
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            var
                lvUserSetup: Record "User Setup";
            begin
                if lvUserSetup.get(UserId) then
                    if not lvUserSetup."Allow Posting of Journals" then
                        error('You do not have permission to post journals');
            end;
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Access to General Journal" then
            Error('You have NO Acccess rights to General Journals');
    end;
}