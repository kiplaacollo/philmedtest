page 50100 "Route Plans"
{

    ApplicationArea = All;
    Caption = 'Route Plans';
    PageType = List;
    SourceTable = "Route Plan";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Route Group"; Rec."Route Group")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                    ApplicationArea = All;
                }
                field("Route No."; Rec."Route No.")
                {
                    ToolTip = 'Specifies the value of the Route No. field.';
                    ApplicationArea = All;
                }
                field("Daily Sales Target"; Rec."Daily Sales Target")
                {
                    ToolTip = 'Specifies the value of the Daily Sales Target field.';
                    ApplicationArea = All;
                }
                field("Daily Customer Target"; Rec."Daily Customer Target")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
