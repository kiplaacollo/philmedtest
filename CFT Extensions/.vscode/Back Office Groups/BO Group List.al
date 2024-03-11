page 50120 "BO Group"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Group";

    layout
    {
        area(Content)
        {
            repeater("BackOffice Groups")
            {
                field(Code; Rec.Code)
                {

                }

                field(Description; Rec.Description)
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