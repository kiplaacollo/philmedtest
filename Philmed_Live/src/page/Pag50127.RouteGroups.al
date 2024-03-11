page 50127 "Route Groups"
{
    ApplicationArea = All;
    Caption = 'Route Groups';
    PageType = List;
    SourceTable = "Route Group";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Route Group Code"; Rec."Route Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Route Group Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = all;
                }
                field("Daily Sales Target"; Rec."Daily Sales Target")
                {
                    ApplicationArea = all;
                }
                field("Daily Customer Target"; Rec."Daily Customer Target")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
