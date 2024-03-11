page 50065 "BO Receipt Card(Posted)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Receipt Header.al";
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                }
                field("Client Code"; Rec."Client Code")
                {

                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Transaction Date"; Rec."Transaction Date")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Pay Mode"; Rec."Pay Mode")
                {

                }
                field("Cheque No"; Rec."Cheque No")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field("Paying Bank"; Rec."Paying Bank")
                {

                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {

                }
                field(Posted; Rec.Posted)
                {

                }
            }
            group("BO Receipt Line")
            {
                part(BOReceiptLine; "BO Receipt Line")
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
            action("Post Receipt")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    LineNo := 0;
                    BOReceiptLine.Reset();
                    BOReceiptLine.SetRange(BOReceiptLine."No.", Rec."No.");
                    if BOReceiptLine.FindSet() then
                        BOReceiptLine.CalcSums(BOReceiptLine.Amount);
                    if BOReceiptLine.Amount <> Rec.Amount then
                        Error('The Totals on the Receipt Lines must be equal to the Header Amount');
                    if FundSetup.Get(FundSetup."User ID") then begin
                        JTemplate := FundSetup."Receipt Journal Template";
                        JBatch := FundSetup."Receipt Journal Batch";
                    end;
                    GenJournalLine.Reset();
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll();
                    IF CONFIRM('Post Receipt No:' + FORMAT(rec."No.")) THEN
                        // Debit Bank Account
                        LineNo := LineNo + 1000;
                    // CFTFactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."No.", rec."Cheque No", GenJournalLine."Account Type"::"Bank Account", rec."Paying Bank",
                    //             rec.Amount, 'Customer Receipt - ' + FORMAT(rec."Client Name") + ' ' + FORMAT(rec."No."), GenJournalLine."Transaction Type", '', '', '');
                    // END Debit Bank Account
                    // Credit Member Loan
                    BOReceiptLine.Reset();
                    BOReceiptLine.SetRange(BOReceiptLine."No.", Rec."No.");
                    if BOReceiptLine.Find('-') then begin
                        repeat
                            LineNo := LineNo + 1000;
                        // CFTFactory.FnGenerateGeneralJournalLine(JTemplate, JBatch, LineNo, '', rec."Posting Date", rec."No.", rec."Cheque No", GenJournalLine."Account Type"::Member, rec."Client Code",
                        //       rec.Amount * -1, 'Customer Receipt - ' + FORMAT(rec."Client Name") + ' ' + FORMAT(rec."No."), BOReceiptLine."Transaction Type", BOReceiptLine."Loan No", '', '');
                        UNTIL BOReceiptLine.NEXT = 0;
                    end;
                    // END Credit Member Loan
                end;
            }
        }
    }

    var
        myInt: Integer;
        LineNo: Integer;
        BOReceiptLine: Record "BO Receipt Line";
        FundSetup: Record "Funds User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        CFTFactory: Codeunit "CFT Factory";
}