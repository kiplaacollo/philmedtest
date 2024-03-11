page 52008 "Checkoff List(Posted)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Checkoff Header";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where(Status = const(Posted));
    CardPageId = "Checkoff Header Card(Posted)";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Document No"; Rec."Document No")
                {

                }
                field("Employer Code"; Rec."Employer Code")
                {

                }
                field("Employer Name"; Rec."Employer Name")
                {

                }
                field("Total Schedule Amount"; Rec."Total Schedule Amount")
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