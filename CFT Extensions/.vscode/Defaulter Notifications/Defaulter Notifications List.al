page 50223 "Defaulter Notifications List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Defaulter Notifications Header";
    CardPageId = "Defaulter Notifications Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {

                }
                field("Notification Type"; Rec."Notification Type")
                {

                }
                field("Notification Date"; Rec."Notification Date")
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