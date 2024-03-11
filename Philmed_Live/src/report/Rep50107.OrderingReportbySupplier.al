report 50107 "Ordering Report by Supplier"
{
    DefaultLayout = RDLC;
    RDLCLayout = './OrderingReport.rdl';
    //AdditionalSearchTerms = 'vendor priority';
    ApplicationArea = Basic, Suite;
    Caption = 'Ordering Report by Supplier';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Vendor Posting Group";
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(STRSUBSTNO___1___2__Vendor_TABLECAPTION_VendFilter_; StrSubstNo('%1: %2', TableCaption, VendFilter))
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(STRSUBSTNO___1___2___Value_Entry__TABLECAPTION_ItemLedgEntryFilter_; StrSubstNo('%1: %2', "Value Entry".TableCaption, ItemLedgEntryFilter))
            {
            }
            column(ItemLedgEntryFilter; ItemLedgEntryFilter)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__Phone_No__; "Phone No.")
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(Value_Entry__Item_No__Caption; "Value Entry".FieldCaption("Item No."))
            {
            }
            column(Value_Entry__Invoiced_Quantity_Caption; "Value Entry".FieldCaption("Invoiced Quantity"))
            {
            }
            column(Value_Entry__Cost_Amount__Actual__Caption; "Value Entry".FieldCaption("Cost Amount (Actual)"))
            {
            }
            column(Value_Entry__Discount_Amount_Caption; "Value Entry".FieldCaption("Discount Amount"))
            {
            }
            column(Vendor__Phone_No__Caption; FieldCaption("Phone No."))
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Source No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Source Type", "Source No.", "Item No.", "Posting Date") WHERE("Source Type" = CONST(Vendor), "Expected Cost" = CONST(false));
                RequestFilterFields = "Posting Date", "Item No.", "Inventory Posting Group";
                column(Value_Entry__Item_No__; "Item No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Value_Entry__Invoiced_Quantity_; InvoicedQuantity)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Value_Entry___Cost_Amount__Actual__; CostAmountActual)
                {
                }
                column(Value_Entry___Discount_Amount_; DiscountAmount)
                {
                }
                column(InventoryPostingGroup; Item."Inventory Posting Group")
                {
                }
                column(InventoryQty; Item.Inventory)
                {
                }
                column(PackSize; PkSize)
                {
                }
                column(LastPurchaseQty; LastPurchaseQty)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not Item.Get("Item No.") then
                        Item.Init();
                    //GNK
                    if LocationFilter <> '' then Item.SetFilter("Location Filter", LocationFilter);
                    Item.Calcfields(Inventory);
                    PkSize := 0;
                    LastPurchaseQty := 0;
                    ItemUOM.setfilter("Item No.", Item."No.");
                    ItemUOM.setfilter(Code, 'P');
                    if Itemuom.findfirst then
                        if itemuom."Qty. per Unit of Measure" > 0 then Pksize := 1 / itemuom."Qty. per Unit of Measure";

                    PurchRcpt.SetCurrentKey("Item Rcpt. Entry No.");
                    PurchRcpt.SetFilter("No.", Item."No.");
                    PurchRcpt.SetFilter("Pay-to Vendor No.", Vendor."No.");
                    if PurchRcpt.findfirst then begin
                        //LastPurchaseDate := PurchRcpt."Posting Date";
                        LastPurchaseQty := PurchRcpt.Quantity;
                    end;
                    //GNK
                    if ResetItemTotal then begin
                        ResetItemTotal := false;
                        InvoicedQuantity := "Invoiced Quantity";
                        CostAmountActual := "Cost Amount (Actual)";
                        DiscountAmount := "Discount Amount";
                    end else begin
                        InvoicedQuantity += "Invoiced Quantity";
                        CostAmountActual += "Cost Amount (Actual)";
                        DiscountAmount += "Discount Amount";
                    end;

                    if not (ValueEntry.Next() = 0) then begin
                        if ValueEntry."Item No." = "Item No." then
                            CurrReport.Skip();
                        ResetItemTotal := true
                    end
                end;

                trigger OnPreDataItem()
                begin
                    ResetItemTotal := true;
                    //GNK
                    LocationFilter := "Value Entry".getfilter("Location Code");
                    "Value Entry".setfilter("Location Code", '');
                    //GNK
                    ValueEntry.SetCurrentKey("Source Type", "Source No.", "Item No.", "Posting Date");
                    ValueEntry.CopyFilters("Value Entry");
                    if ValueEntry.FindSet then;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
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
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Vendor';
                        ToolTip = 'Specifies if each vendor''s information is printed on a new page if you have chosen two or more vendors to be included in the report.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportNameLabel = 'Ordering Report by Supplier Name';
        PageLabel = 'Page';
        AllAmountsinLCYLabel = 'All amounts are in LCY';
        DescriptionLabel = 'Description';
        UnitOfMeasureLabel = 'Unit of Measure';
        TotalLabel = 'Total';
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        VendFilter := FormatDocument.GetRecordFiltersWithCaptions(Vendor);
        ItemLedgEntryFilter := "Value Entry".GetFilters;
        PeriodText := "Value Entry".GetFilter("Posting Date");
    end;

    var
        Text000: Label 'Period: %1';
        Item: Record Item;
        ValueEntry: Record "Value Entry";
        VendFilter: Text;
        ItemLedgEntryFilter: Text;
        PeriodText: Text;
        PrintOnlyOnePerPage: Boolean;
        PageGroupNo: Integer;
        ResetItemTotal: Boolean;
        InvoicedQuantity: Decimal;
        CostAmountActual: Decimal;
        DiscountAmount: Decimal;
        PkSize: Decimal;
        ItemUOM: Record "Item Unit of Measure";
        LastPurchaseQty: Decimal;
        PurchRcpt: Record "Purch. Rcpt. Line";
        Vend: Record Vendor;
        LocationFilter: Text;

    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
    end;
}

