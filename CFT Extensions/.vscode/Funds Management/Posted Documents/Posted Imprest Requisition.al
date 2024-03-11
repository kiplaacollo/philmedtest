page 50043 "Posted Imprest Requisition"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Header";
    SourceTableView = where(Posted = const(true));
    ModifyAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Posted Imprest Header";

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
                field("Account No."; Rec."Account No.")
                {

                }
                field(Payee; Rec.Payee)
                {

                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(Posted; Rec.Posted)
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