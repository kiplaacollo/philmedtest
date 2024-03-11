page 50034 "Funds Transfer Card(Posted)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Funds Transfer Header";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Pay Mode"; Rec."Pay Mode")
                {

                }
                field("No."; Rec."No.")
                {

                }
                field(Date; Rec.Date)
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {

                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {

                }
                field("Bank Balance"; Rec."Bank Balance")
                {

                }
                field("Bank Balance(LCY)"; Rec."Bank Balance(LCY)")
                {

                }
                field("Bank Account No."; Rec."Bank Account No.")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Currency Factor"; Rec."Currency Factor")
                {

                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {

                }
                field("Amount to Transfer(LCY)"; Rec."Amount to Transfer(LCY)")
                {

                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {

                }
                field("Total Line Amount(LCY)"; Rec."Total Line Amount(LCY)")
                {

                }
                field("Cheque/Doc. No"; Rec."Cheque/Doc. No")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Created By"; Rec."Created By")
                {

                }
                field("Date Created"; Rec."Date Created")
                {

                }
                field("Time Created"; Rec."Time Created")
                {

                }
                field(Status; Rec.Status)
                {

                }
            }
            group("Funds Transfer Lines")
            {
                part(FundsTransferLines; "Funds Transfer Lines")
                {
                    SubPageLink = "Document No" = field("No.");
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