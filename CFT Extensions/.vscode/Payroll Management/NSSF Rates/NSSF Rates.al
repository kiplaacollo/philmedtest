page 50422 "NSSF Rates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_nssfs;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(nssf_band; Rec.nssf_band)
                {
                    Caption = 'Band';
                }
                field(lower_limit; Rec.lower_limit)
                {
                    Caption = 'Lower Limit';
                }
                field(upper_limit; Rec.upper_limit)
                {
                    Caption = 'Upper Limit';
                }
                field(percentage; Rec.percentage)
                {

                }
                field(taxable_amount; Rec.taxable_amount)
                {
                    Caption = 'Taxable Amount';
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