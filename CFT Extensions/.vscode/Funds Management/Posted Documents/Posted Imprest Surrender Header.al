page 50047 "Posted Imprest Surrender"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Surrender Header";
    SourceTableView = where(Posted = const(true));
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Surrender Date"; Rec."Surrender Date")
                {

                }
                field("Account No."; Rec."Account No.")
                {

                }
                field("Account Name"; Rec."Account Name")
                {

                }
                field("Imprest Issue Doc. No"; Rec."Imprest Issue Doc. No")
                {

                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Imprest Issue Date"; Rec."Imprest Issue Date")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(Cashier; Rec.Cashier)
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = false;
                }

            }
            group("Posted Imprest Surrender Lines")
            {
                part(imprestlines; "Imprest Surrender Lines")
                {
                    SubPageLink = "Surrender Doc No" = field(No);
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