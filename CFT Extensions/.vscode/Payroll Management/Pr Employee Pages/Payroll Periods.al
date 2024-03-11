page 50709 "Payroll Periods"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_periods;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(period_code; Rec.period_code)
                {

                }
                field(start_date; Rec.start_date)
                {

                }
                field(end_date; Rec.end_date)
                {

                }
                field(period_month; Rec.period_month)
                {

                }
                field(period_year; Rec.period_year)
                {

                }
                field(Active; Rec.Active)
                {

                }
                field(Closed; Rec.Closed)
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