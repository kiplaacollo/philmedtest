page 50056 "Payments Tax Codes List"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "Fund Tax Codes";
    CardPageId = "Payments Tax Codes Card";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Tax Code"; Rec."Tax Code")
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