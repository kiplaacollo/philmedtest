page 50041 "Imprest Surrender Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Surrender Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {

                }
                field("Account Name"; Rec."Account Name")
                {

                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {

                }
                field("Cash Receipt No"; Rec."Cash Receipt No")
                {
                    Visible = false;
                }
                field("Cash Surrender Amt"; Rec."Cash Surrender Amt")
                {

                }
                field("Bank/Petty Cash"; Rec."Bank/Petty Cash")
                {

                }
                field("Imprest Holder"; Rec."Imprest Holder")
                {
                    Editable = false;
                }
                field("Apply to"; Rec."Apply to")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec."Apply to" := '';
                        Rec."Apply to ID" := '';
                        Custledger.RESET;
                        Custledger.SETCURRENTKEY(Custledger."Customer No.", Open, "Document No.");
                        Custledger.SETRANGE(Custledger."Customer No.", Rec."Imprest Holder");
                        Custledger.SETRANGE(Open, TRUE);
                        Custledger.CALCFIELDS(Custledger.Amount);
                        IF PAGE.RUNMODAL(25, Custledger) = ACTION::LookupOK THEN begin
                            IF Custledger."Applies-to ID" <> '' THEN begin
                                Custledger1.RESET;
                                Custledger1.SETCURRENTKEY(Custledger1."Customer No.", Open, "Applies-to ID");
                                Custledger1.SETRANGE(Custledger1."Customer No.", Rec."Imprest Holder");
                                Custledger1.SETRANGE(Open, TRUE);
                                Custledger1.SETRANGE("Applies-to ID", Custledger."Applies-to ID");
                                IF Custledger1.FIND('-') THEN begin
                                    REPEAT
                                        Custledger1.CALCFIELDS(Custledger1.Amount);
                                        Amt := Amt + ABS(Custledger1.Amount);
                                    UNTIL Custledger1.NEXT = 0;
                                end;
                                IF Amt <> Amt THEN
                                    Rec."Apply to" := Custledger."Document No.";
                                Rec."Apply to ID" := Custledger."Applies-to ID";
                            end else begin
                                IF Rec.Amount <> ABS(Custledger.Amount) THEN
                                    Custledger.CALCFIELDS(Custledger."Remaining Amount");
                                Rec."Apply to" := Custledger."Document No.";
                                Rec."Apply to ID" := Custledger."Applies-to ID";
                            end;
                        end;
                        IF Rec."Apply to ID" <> '' THEN
                            Rec."Apply to" := '';

                        Rec.VALIDATE(Amount);
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
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
        Custledger: Record "Cust. Ledger Entry";
        Custledger1: Record "Cust. Ledger Entry";
        Amt: Decimal;
}