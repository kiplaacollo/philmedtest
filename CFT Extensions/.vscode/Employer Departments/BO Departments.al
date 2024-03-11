page 50103 "BO Departments"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Department";

    layout
    {
        area(Content)
        {
            repeater("Employer Departments")
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