page 50706 "NHIF Rates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_nhif;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(nhif_band; Rec.nhif_band)
                {

                }
                field(amount; Rec.amount)
                {

                }
                field(lower_limit; Rec.lower_limit)
                {

                }
                field(upper_limit; Rec.upper_limit)
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