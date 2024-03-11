page 50213 "Loan Purpose Setup"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Loan Purpose Setup Table";

    layout
    {
        area(Content)
        {
            repeater(Group)
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