page 50028 "Posted Receipt Header Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Receipt Header";
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
                field("No."; Rec."No.")
                {

                }
                field("Document Type"; Rec."Document Type")
                {

                }
                field(Date; Rec.Date)
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Bank Code"; Rec."Bank Code")
                {

                }
                field("Bank Name"; Rec."Bank Name")
                {

                }
                field("Bank Balance"; Rec."Bank Balance")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Currency Factor"; Rec."Currency Factor")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field("Amount Received"; Rec."Amount Received")
                {

                }
                field("Amount Received(LCY)"; Rec."Amount Received(LCY)")
                {

                }
                field("New Total Amount"; Rec."New Total Amount")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Received From"; Rec."Received From")
                {

                }
                field("User ID"; Rec."User ID")
                {

                }
                field("Total Amount(LCY)"; Rec."Total Amount(LCY)")
                {

                }
            }
            group("Posted Receipt Line")
            {
                part(PostedReceiptLine; "Posted Receipt Line")
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