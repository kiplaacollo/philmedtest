page 50027 "Posted Receipt Header List"
{
    PageType = List;
    // ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Receipt Header";
    CardPageId = "Posted Receipt Header Card";
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
                field(Status; Rec.Status)
                {
                    Visible = false;
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
                field("New Total Amount"; Rec."New Total Amount")
                {

                }
                field("User ID"; Rec."User ID")
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