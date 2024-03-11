page 50103 "Cash Sale Gift Items"
{
    ApplicationArea = All;
    Caption = 'Cash Sale Gift Items';
    PageType = List;
    SourceTable = "Cash Sale Gift Item";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cash Sale Limit"; Rec."Cash Sale Limit (LCY)")
                {
                    ToolTip = 'Specifies the value of the Cash Sale Limit field.';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line Number field.';
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ToolTip = 'Specifies the value of the Item Code field.';
                    ApplicationArea = All;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ToolTip = 'Specifies the value of the Item Name field.';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
