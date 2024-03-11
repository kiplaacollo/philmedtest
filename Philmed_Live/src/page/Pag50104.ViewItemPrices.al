page 50104 ViewItemPrices
{
    ApplicationArea = All;
    Caption = 'ViewItemPrices';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the item.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies what you are selling.';
                    ApplicationArea = All;
                }

                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    ToolTip = 'Specifies the cost of one unit of the item Last Direct Cost.';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                    ApplicationArea = All;
                }
                field("Minimum Unit Price"; Rec."Minimum Unit Price")
                {
                    ToolTip = 'Specifies the value of the Minimum Unit Price field.';
                    ApplicationArea = All;
                }
                field(LastCustomerPrice; LastCustomerPrice)
                {
                    Caption = 'Last Customer Price';
                    ApplicationArea = All;
                }


                field("Retail Price"; Rec."Retail Price")
                {
                    ToolTip = 'Specifies the value of the Retail Price field.';
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies the unit in which the item is held in inventory. The base unit of measure also serves as the conversion basis for alternate units of measure.';
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        LastCustomerPrice: Decimal;

    procedure SetLastCustomerPrice(Price: Decimal)
    begin
        LastCustomerPrice := Price;
    end;

}
