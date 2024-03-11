page 50033 "Funds Tranfer Posted"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Funds Transfer Header";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where(Status = const(Posted));
    CardPageId = "Funds Transfer Card(Posted)";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {

                }
                field("Amount to Transfer(LCY)"; Rec."Amount to Transfer(LCY)")
                {

                }
                field(Status; Rec.Status)
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