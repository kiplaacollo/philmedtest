page 50421 "NHIF Rates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_nhifs;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(nhif_band; Rec.nhif_band)
                {
                    Caption = 'Band';
                }
                field(amount; Rec.amount)
                {
                    Caption = 'Amount';
                }
                field(lower_limit; Rec.lower_limit)
                {
                    Caption = 'Lower Limit';
                }
                field(upper_limit; Rec.upper_limit)
                {
                    Caption = 'Upper Limit';
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