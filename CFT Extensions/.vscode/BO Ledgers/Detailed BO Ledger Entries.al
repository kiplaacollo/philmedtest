page 50130 "Detailed BO Ledger Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Detailed BO Ledger Entry";
    SourceTableView = where(Reversed = filter(false));
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DataCaptionFields = "BO Ledger Entry No.", "Member Number";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date of the detailed employee ledger entry.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the entry type of the detailed employee ledger entry.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the document type of the detailed employee ledger entry.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number of the transaction that created the entry.';
                }
                field("Member Number"; Rec."Member Number")
                {
                    ToolTip = 'Specifies the number of the employee to which the entry is posted.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Initial Entry Global Dim. 1"; Rec."Initial Entry Global Dim. 1")
                {
                    Visible = false;
                    ToolTip = 'Specifies the Global Dimension 1 code of the initial employee ledger entry.';
                }
                field("Initial Entry Global Dim. 2"; Rec."Initial Entry Global Dim. 2")
                {
                    Visible = false;
                    ToolTip = 'Specifies the Global Dimension 2 code of the initial employee ledger entry.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the code for the currency if the amount is in a foreign currency.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the amount of the detailed employee ledger entry.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the amount of the entry in LCY.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits, expressed in LCY.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    Visible = false;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits, expressed in the local currency.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the source code that specifies where the entry was created.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                }
                field("Loan Number"; Rec."Loan Number")
                {

                }
                field("Loan Product Code"; Rec."Loan Product Code")
                {
                    Style = Attention;
                    StyleExpr = true;
                }
                field(Unapplied; Rec.Unapplied)
                {
                    Visible = false;
                    ToolTip = 'Specifies whether the entry has been unapplied (undone) from the Unapply Employee Entries window by the entry number shown in the Unapplied by Entry No. field.';
                }
                field("Unapplied by Entry No."; Rec."Unapplied by Entry No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the number of the correcting entry, if the original entry has been unapplied (undone) from the Unapply Employee Entries window.';
                }
                field("BO Ledger Entry No."; Rec."BO Ledger Entry No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the entry number of the employee ledger entry that the detailed employee ledger entry line was created for.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the entry number of the detailed employee ledger entry.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field(Reversed; Rec.Reversed)
                {

                }
                field("Reversal Date"; Rec."Reversal Date")
                {

                }
                field("Reversal Time"; Rec."Reversal Time")
                {

                }
                field("Reversed By"; Rec."Reversed By")
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}