page 50710 "RM Rewards"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_rewards;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(rm_band; Rec.rm_band)
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
                field("chargable amount"; Rec."chargable amount")
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