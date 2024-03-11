page 50061 "BO Receipt List"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "BO Receipt Header.al";
    CardPageId = "BO Receipt Card";
    Editable = true;
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Client Code"; Rec."Client Code")
                {

                }
                field("Pay Mode"; Rec."Pay Mode")
                {

                }
                field("Cheque No"; Rec."Cheque No")
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