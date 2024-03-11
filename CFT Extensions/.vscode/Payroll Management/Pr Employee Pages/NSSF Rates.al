page 50705 "NSSF Rates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_nssf;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(nssf_band; Rec.nssf_band)
                {

                }
                field(lower_limit; Rec.lower_limit)
                {

                }
                field(upper_limit; Rec.upper_limit)
                {

                }
                field(percentage; Rec.percentage)
                {

                }
                field(taxable_amount; Rec.taxable_amount)
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