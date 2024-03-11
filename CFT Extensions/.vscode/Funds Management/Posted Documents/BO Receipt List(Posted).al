page 50064 "BO Receipt List(Posted)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Receipt Header.al";
    Editable = false;
    CardPageId = "BO Receipt Card(Posted)";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where(Posted = const(true));

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
                field("Cutoff Date"; Rec."Cutoff Date")
                {
                    Caption = 'Loan Cut Off Date';
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