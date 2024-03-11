page 50030 "Funds Transfer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Funds Transfer Header";
    SourceTableView = where(Status = filter(<> Posted));
    CardPageId = "Funds Transfer Header";
    ModifyAllowed = false;
    DeleteAllowed = false;

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
                field("Paying Bank Name"; Rec."Paying Bank Name")
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