page 50038 "Imprest Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Advance Type"; Rec."Advance Type")
                {

                }
                field(No; Rec.No)
                {
                    Visible = false;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {

                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    Visible = false;
                }
                field("No of Days"; Rec."No of Days")
                {
                    Visible = false;
                }
                field("Daily Rate(Amount)"; Rec."Daily Rate(Amount)")
                {
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {

                }
                field("Imprest Holder"; Rec."Imprest Holder")
                {

                }
                field(Purpose; Rec.Purpose)
                {

                }
                field("Due Date"; Rec."Due Date")
                {

                }
                field("Date Issued"; Rec."Date Issued")
                {

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
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