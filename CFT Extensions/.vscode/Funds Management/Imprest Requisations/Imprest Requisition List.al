page 50036 "Imprest Requisition List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Header";
    CardPageId = "Imprest Header";
    Caption = 'Staff Travel List';
    SourceTableView = where(Posted = const(false));
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