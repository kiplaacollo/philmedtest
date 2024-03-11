page 50024 "Receipt Header List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted = const(false));
    ModifyAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Receipt Header Card";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Received From"; Rec."Received From")
                {

                }
                field("Amount Received(LCY)"; Rec."Amount Received(LCY)")
                {

                }
                field("User ID"; Rec."User ID")
                {

                }
                field("New Total Amount"; Rec."New Total Amount")
                {
                    Caption = 'Total Amount';
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