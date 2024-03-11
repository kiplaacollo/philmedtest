page 50044 "Posted Imprest Header"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Header";
    RefreshOnActivate = true;
    SourceTableView = where(Posted = const(true));
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {

                }
                field("Function Name"; Rec."Function Name")
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {

                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {

                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                }
                field(Dim3; Rec.Dim3)
                {
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {

                }
                field("Account No."; Rec."Account No.")
                {

                }
                field(Requisition; Rec.Requisition)
                {
                    Visible = false;
                }
                field(Payee; Rec.Payee)
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {

                }
                field("Bank Name"; Rec."Bank Name")
                {

                }
                field(Purpose; Rec.Purpose)
                {

                }
                field(Cashier; Rec.Cashier)
                {

                }
                field(Status; Rec.Status)
                {

                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {

                }
                field("Total Net Amount lCY"; Rec."Total Net Amount lCY")
                {

                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {

                }
                field("Pay Mode"; Rec."Pay Mode")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field("Cheque No."; Rec."Cheque No.")
                {

                }
            }
            group("Posted Receipt Lines")
            {
                part(PVLines; "Imprest Lines")
                {
                    SubPageLink = No = field("No.");
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