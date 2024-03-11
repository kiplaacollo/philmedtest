page 50215 "Checkoff Header Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Checkoff Header";
    SourceTableView = where(Status = const(Open));

    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                field("No."; Rec."No.")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Employer Code"; Rec."Employer Code")
                {

                }
                field("Employer Name"; Rec."Employer Name")
                {
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {

                }
                field("Loan Cutoff Date"; Rec."Loan Cutoff Date")
                {

                }
                field("Global Dimension Code 1"; Rec."Global Dimension Code 1")
                {
                    Caption = 'Activity Code';
                }
                field("Manual Checkoff"; Rec."Manual Checkoff")
                {

                }
                field("Loans Only"; Rec."Loans Only")
                {

                }
                // field("Total Count"; Rec."Total Count")
                // {

                // }
                field("Sheduled Amount"; Rec."Sheduled Amount")
                {

                }
                field("Total Schedule Amount"; Rec."Total Schedule Amount")
                {
                    Editable = false;
                }
                field("Checkoff Type"; Rec."Checkoff Type")
                {

                }
                field("Skip Loans"; Rec."Skip Loans")
                {

                }
                field("Captured By"; Rec."Captured By")
                {

                }
                field(Remarks; Rec.Remarks)
                {

                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }

            }
            group("Checkoff Lines")
            {
                part(checkofflines; "Checkoff Lines Listpart")
                {
                    SubPageLink = "No." = field("No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    LineNo := 0;
                    LineNo := 1000;
                    JTemplate := 'GENERAL';
                    JBatch := 'CHECKOFF';

                    GenJournalLine.Reset();
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll();
                    checkoffallocationlines.Reset();
                    checkoffallocationlines.SetRange("Advice No", Rec."No.");
                    if checkoffallocationlines.Find('-') then begin
                        if Confirm('Post checkoff Document No:' + Format(Rec."No.")) then
                            repeat
                                LineNo := LineNo + 1000;
                                if checkoffallocationlines."Transaction Type" = 'Loan Repayment' then
                                    cftfactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", Rec."No.", '', GenJournalLine."Account Type"::Customer, checkoffallocationlines."Client Code", checkoffallocationlines.amount * -1, 'Loan Repayment', GenJournalLine."Transaction Type"::"Loan Repayment", checkoffallocationlines."Loan No", '', '', '');


                                if checkoffallocationlines."Transaction Type" = 'Deposit Contribution' then
                                    cftfactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", Rec."No.", '', GenJournalLine."Account Type"::Customer, checkoffallocationlines."Client Code", checkoffallocationlines.amount * -1, 'Deposit Contribution', GenJournalLine."Transaction Type"::"Deposit Contribution", checkoffallocationlines."Loan No", '', '', '');


                                if checkoffallocationlines."Transaction Type" = 'Share Capital' then
                                    cftfactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", Rec."No.", '', GenJournalLine."Account Type"::Customer, checkoffallocationlines."Client Code", checkoffallocationlines.amount * -1, 'Share Capital', GenJournalLine."Transaction Type"::"Share Capital", checkoffallocationlines."Loan No", '', '', '');

                                if checkoffallocationlines."Transaction Type" = 'Registration Fees' then
                                    cftfactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", Rec."No.", '', GenJournalLine."Account Type"::Customer, checkoffallocationlines."Client Code", checkoffallocationlines.amount * -1, 'Registration Fees', GenJournalLine."Transaction Type"::"Registration Fees", checkoffallocationlines."Loan No", '', '', '');

                            until checkoffallocationlines.Next = 0;

                        //======CREATE BALANCING ENTRY===============================================
                        LineNo := LineNo + 1000;
                        cftfactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", Rec."No.", '', GenJournalLine."Account Type"::Customer, rec."Account No", Rec."Sheduled Amount", 'Registration Fees', GenJournalLine."Transaction Type"::" ", checkoffallocationlines."Loan No", '', '', '');
                        //==============================POST ENTRIES=================================
                        GenJournalLine.Reset();
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);

                        Page.Run(Page::"General Journal", GenJournalLine);


                    end;
                end;
            }
            action("Mark Posted")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    rec.Status := Rec.Status::Posted;
                    Rec.Modify();
                end;
            }
            action("Notify Members")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    txtmessage: Text;
                begin
                    checkofflines.Reset();
                    checkofflines.SetRange("No.", Rec."No.");
                    if checkofflines.Find('-') then begin
                        repeat
                            txtmessage := '';
                            txtmessage := 'Dear ' + checkofflines."Client Name" + ',your checkoff has been processed successfully. Dial *670# to Confirm your balances';
                            cftfactory.fnsendmessage(checkofflines."Client Code", checkofflines."Phone No", 'CHECKOFF', txtmessage);
                        until checkofflines.Next = 0;
                    end;
                    Message('Notifications to members successfully sent');
                end;
            }
        }
    }

    var
        myInt: Integer;
        cftfactory: Codeunit "CFT Factory";
        LineNo: Integer;
        JTemplate: Code[20];
        JBatch: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        checkoffallocationlines: Record "Checkoff Allocation Lines";
        checkofflines: Record "Checkoff Lines Table";
}