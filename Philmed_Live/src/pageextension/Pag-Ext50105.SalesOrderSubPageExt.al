pageextension 50105 SalesOrderSubPageExt extends "Sales Order Subform"
{
    layout
    {
        addafter("Location Code")
        {
            field("Inventory Balance"; Rec."Inventory Balance")
            {
                ApplicationArea = all;
            }
        }
        modify("Line No.")
        {
            Visible = true;
            Editable = false;
        }
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Planned Shipment Date")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }

        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }
        modify("Qty. to Ship")
        {
            Visible = false;
        }
        modify("Quantity Shipped")
        {
            Visible = false;
        }
        modify("Qty. to Invoice")
        {
            Visible = false;
        }
        modify("Quantity Invoiced")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        //modify("Unit Price")
        //{
        //Editable = AllowPriceChange;
        //}
        modify("Line Amount")
        {
            Editable = false;
        }
        movebefore(Quantity; "Unit of Measure Code")
        moveafter("Shortcut Dimension 1 Code"; "Location Code")
    }

    actions
    {
        addbefore(GetPrices)
        {
            action("View Allowed Prices")
            {
                ApplicationArea = all;
                Image = TaskList;
                ShortcutKey = 'Alt+P';
                trigger OnAction()
                var
                    lvItem: Record Item;
                    ViewItemPrices: Page ViewItemPrices;
                    SalesInvLine: Record "Sales Invoice Line";
                    LastCustPrice: Decimal;
                begin
                    LastCustPrice := 0;
                    if Rec."Sell-to Customer No." <> '' then begin
                        SalesInvLine.SetCurrentKey("Posting Date");
                        SalesInvLine.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                        SalesInvLine.SetRange("No.", rec."No.");
                        if SalesInvLine.FindLast() then
                            LastCustPrice := SalesInvLine."Unit Price" / SalesInvLine."Qty. per Unit of Measure";
                    end;

                    lvItem.SetRange("No.", rec."No.");
                    ViewItemPrices.SetLastCustomerPrice(LastCustPrice);
                    ViewItemPrices.SetTableView(lvItem);
                    ViewItemPrices.RunModal();
                end;
            }
        }


    }
    var
        AllowPriceChange: Boolean;
        AllowPriceUpwards: Boolean;

    trigger OnOpenPage()
    var
        lvUserSetup: Record "User Setup";
    begin
        //AllowPriceChange := false;
        //lvuserSetup.setfilter("user id", UserId);
        //if lvUserSetup.findfirst then begin
        //if lvUserSetup."Allow Sales Order Price Change" then AllowPriceChange := true;
        //if lvUserSetup."Sales Order Price Upwards Only" then AllowPriceUpwards := true;
        //end;
    end;


}
