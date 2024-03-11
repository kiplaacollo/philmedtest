page 50437 "Employees Factbaox"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_employees;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(st_no; Rec.st_no)
                {

                }
                field("First Name"; Rec."First Name")
                {

                }
                field("Middle Name"; Rec."Middle Name")
                {

                }
                field("Last Name"; Rec."Last Name")
                {

                }
                field(employee_email; Rec.employee_email)
                {

                }
                field(department_code; Rec.department_code)
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