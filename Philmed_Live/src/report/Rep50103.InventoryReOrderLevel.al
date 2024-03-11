report 50103 "Inventory ReOrder Level"
{
    DefaultLayout = RDLC;
    RDLCLayout = './InventoryReOrder.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Inventory Reorder Levels';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Location Filter", "Variant Filter", "Search Description", "Assembly BOM", "Inventory Posting Group";
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(ItemFilterCopyCaption; TableCaption + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(InventPostingGr_Item; "Inventory Posting Group")
            {
            }
            column(No_Item; "No.")
            {
                IncludeCaption = true;
            }
            column(Desc_Item; Description)
            {
                IncludeCaption = true;
            }
            column(AssemblyBOM_Item; Format("Assembly BOM"))
            {
            }
            column(BaseUOM_Item; "Base Unit of Measure")
            {
                IncludeCaption = true;
            }
            //ICS
            column(LastVendorName; LastVendor)
            {
            }
            column(LastPurchaseDate; LastPurchaseDate)
            {
            }
            column(LastPurchaseQty; LastPurchaseQty)
            {
            }
            column(InStock; "Inventory")
            {
            }
            column(ReorderLevel; "Reorder Point")
            {
            }
            column(QtyToOrder; "Reorder Quantity")
            {
            }
            column(OrderValue; LPOValue)
            {
            }
            column(AverageCost; AverageCost)
            {
                AutoFormatType = 1;
            }
            column(StandardCost_Item; "Standard Cost")
            {
                IncludeCaption = true;
            }
            column(LastDirectCost_Item; "Last Direct Cost")
            {
                IncludeCaption = true;
            }
            column(UnitPrice_Item; "Unit Price")
            {
                IncludeCaption = true;
            }
            column(Profit_Item; "Profit %")
            {
                DecimalPlaces = 1 : 1;
                IncludeCaption = true;
            }
            column(UnitPriceUnitCost_Item; "Unit Price" - "Unit Cost")
            {
            }
            column(UseStockkeepingUnitBody; UseStockkeepingUnit)
            {
            }
            column(LocationFilter_Item; "Location Filter")
            {
            }
            column(VariantFilter_Item; "Variant Filter")
            {
            }
            column(InvCostAndPriceListCaption; InvCostAndPriceListCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(BOMCaption; BOMCaptionLbl)
            {
            }
            column(AvgCostCaption; AvgCostCaptionLbl)
            {
            }
            column(ProfitCaption; ProfitCaptionLbl)
            {
            }
            column(LastDirCostCaption; LastDirCostCaptionLbl)
            {
            }
            column(LocationCodeCaption; LocationCodeCaptionLbl)
            {
            }
            column(VariantCodeCaption; VariantCodeCaptionLbl)
            {
            }
            dataitem("Stockkeeping Unit"; "Stockkeeping Unit")
            {
                DataItemLink = "Item No." = FIELD("No."), "Location Code" = FIELD("Location Filter"), "Variant Code" = FIELD("Variant Filter");
                DataItemTableView = SORTING("Item No.", "Location Code", "Variant Code");
                column(ItemUnitPriceUnitCostDiff; Item."Unit Price" - Item."Unit Cost")
                {
                }
                column(LastDirCost_StockKeepingUnit; "Last Direct Cost")
                {
                }
                column(StandardCost_StockKeepingUnit; "Standard Cost")
                {
                }
                column(AverageCost_StockKeepingUnit; AverageCost)
                {
                    AutoFormatType = 1;
                }
                column(ItemBaseUOM; Item."Base Unit of Measure")
                {
                }
                column(ItemAssemblyBOM; Format(Item."Assembly BOM"))
                {
                }
                column(LocationCode_StockKeepingUnit; "Location Code")
                {
                }
                column(VariantCode_StockKeepingUnit; "Variant Code")
                {
                }
                column(UseStockkeepingUnit; UseStockkeepingUnit)
                {
                }
                column(SKUPrintLoop; SKUPrintLoop)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Item2: Record Item;

                begin
                    SKUPrintLoop := SKUPrintLoop + 1;
                    if Item2.Get("Item No.") then begin
                        Item2.SetFilter("Location Filter", "Location Code");
                        Item2.SetFilter("Variant Filter", "Variant Code");
                        ItemCostMgt.CalculateAverageCost(Item2, AverageCost, AverageCostACY);
                        AverageCost := Round(AverageCost, GLSetup."Unit-Amount Rounding Precision");
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    if not UseStockkeepingUnit then
                        CurrReport.Break();

                    SKUPrintLoop := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                PurchRcpt: Record "Purch. Rcpt. Line";
                Vend: Record Vendor;

            begin
                Item.CalcFields(Inventory);
                If Item."Reorder Point" = 0 then CurrReport.SKIP;
                ItemCostMgt.CalculateAverageCost(Item, AverageCost, AverageCostACY);
                AverageCost := Round(AverageCost, GLSetup."Unit-Amount Rounding Precision");
                LPOValue := 0;
                LPOValue := Item."Reorder Quantity" * AverageCost;
                LastVendor := '';
                LastPurchaseDate := 0D;
                LastPurchaseQty := 0;
                If Item.Inventory > Item."Reorder Point" then CurrReport.SKIP;

                //Purchase Receipt
                PurchRcpt.SetCurrentKey("Posting Date");
                PurchRcpt.SetFilter("No.", Item."No.");
                if PurchRcpt.findlast then begin
                    if Vend.get(PurchRcpt."Pay-to Vendor No.") then
                        LastVendor := Vend.Name;
                    LastPurchaseDate := PurchRcpt."Posting Date";
                    LastPurchaseQty := PurchRcpt.Quantity;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ItemFilter := Item.GetFilters;
        GetGLSetup;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ItemCostMgt: Codeunit ItemCostManagement;
        ItemFilter: Text;
        AverageCost: Decimal;
        AverageCostACY: Decimal;
        GLSetupRead: Boolean;
        UseStockkeepingUnit: Boolean;
        SKUPrintLoop: Integer;
        InvCostAndPriceListCaptionLbl: Label 'Inventory Cost and Price List';
        PageNoCaptionLbl: Label 'Page';
        BOMCaptionLbl: Label 'BOM';
        AvgCostCaptionLbl: Label 'Average Cost';
        ProfitCaptionLbl: Label 'Profit';
        LastDirCostCaptionLbl: Label 'Last Direct Cost';
        LocationCodeCaptionLbl: Label 'Location Code';
        VariantCodeCaptionLbl: Label 'Variant Code';
        LastVendor: Text[100];
        LPOValue: Decimal;
        LastPurchaseDate: Date;
        LastPurchaseQty: Decimal;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GLSetup.Get();
        GLSetupRead := true;
    end;

    procedure InitializeRequest(NewUseStockkeepingUnit: Boolean)
    begin
        UseStockkeepingUnit := NewUseStockkeepingUnit;
    end;
}

