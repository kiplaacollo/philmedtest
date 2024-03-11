page 50039 "Imprest Surrender List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Surrender Header";
    CardPageId = "Imprest Surrender Header";
    SourceTableView = where(Posted = const(false));
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {

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
                field("Imprest Issue Date"; Rec."Imprest Issue Date")
                {

                }
                field(Amount; Rec.Amount)
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