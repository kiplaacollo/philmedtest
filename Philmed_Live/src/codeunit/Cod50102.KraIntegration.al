codeunit 50102 "KraIntegration"
{
    trigger OnRun()
    begin
    end;

    var
        Item: Record Item;
        Customer: Record Customer;
        ItemCategory: Record "Item Category";
        ItemLedgerEntries: Record "Item Ledger Entry";
        Locations: Record Location;
        PostedInvoiceHeader: Record "Purch. Inv. Header";
        PostedPurchaseInvLines: Record "Purch. Inv. Line";
        PostedSalesInvoices: Record "Sales Invoice Header";
        PostedSalesInvLines: Record "Sales Invoice Line";
        PostedSHipmentsHeader: Record "Transfer Shipment Header";
        PostedShipmentLines: Record "Transfer Shipment Line";




    procedure UpdateItem(Name: Code[250]; PostedToKra: Boolean; KraError: Boolean; Description: Text) Updated: Boolean
    var

    begin
        Updated := false;
        Item.Reset();
        Item.SetRange(Item."No.", Name);
        if Item.FindFirst() then begin
            if PostedToKra = true then begin
                Item."Awaiting Kra Posting" := false;
                Item."Posted To KRA" := true;
                Item."Posted To KRA Error" := false;
            end else begin
                Item."Posted To KRA Error" := true;
            end;
            Item."Kra Error Descripion" := Description;
            Item.Modify(true);
            Updated := true;
            exit(Updated);
        end;
    end;

    procedure UpdatePostedPurchaseInv(Name: Code[250]; PostedToKra: Boolean; KraError: Boolean; Description: Text) Updated: Boolean
    var

    begin
        Updated := false;
        PostedInvoiceHeader.Reset();
        PostedInvoiceHeader.SetRange(PostedInvoiceHeader."No.", Name);
        if PostedInvoiceHeader.FindFirst() then begin
            if PostedToKra = true then begin
                PostedInvoiceHeader."Awaiting Kra Posting" := false;
                PostedInvoiceHeader."Posted To KRA" := true;
                PostedInvoiceHeader."Posted To KRA Error" := false;
            end else begin
                PostedInvoiceHeader."Posted To KRA Error" := true;
            end;
            PostedInvoiceHeader."Kra Error Descripion" := Description;
            PostedInvoiceHeader.Modify(true);
            Updated := true;
            exit(Updated);
        end;
    end;

    procedure UpdatePostedTransferShipments(Name: Code[250]; PostedToKra: Boolean; KraError: Boolean; Description: Text) Updated: Boolean
    var

    begin
        Updated := false;
        PostedSHipmentsHeader.Reset();
        PostedSHipmentsHeader.SetRange(PostedSHipmentsHeader."No.", Name);
        if PostedSHipmentsHeader.FindFirst() then begin
            if PostedToKra = true then begin
                PostedSHipmentsHeader."Awaiting Kra Posting" := false;
                PostedSHipmentsHeader."Posted To KRA" := true;
                PostedSHipmentsHeader."Posted To KRA Error" := false;
            end else begin
                PostedSHipmentsHeader."Posted To KRA Error" := true;
            end;
            PostedSHipmentsHeader."Kra Error Descripion" := Description;
            PostedSHipmentsHeader.Modify(true);
            Updated := true;
            exit(Updated);
        end;
    end;

    procedure UpdatePostedSalesInv(Name: Code[250]; PostedToKra: Boolean; KraError: Boolean; Description: Text; rcptNo: Code[250]; intrlData: Text; rcptSign: Code[250];
    totRcptNo: Code[250]; vsdcRcptPbctDate: Text; sdcId: Code[250]; mrcNo: Code[250];
    QrCode: Text) Updated: Boolean
    var

    begin
        Updated := false;
        PostedSalesInvoices.Reset();
        PostedSalesInvoices.SetRange(PostedSalesInvoices."No.", Name);
        if PostedSalesInvoices.FindFirst() then begin
            if PostedToKra = true then begin
                PostedSalesInvoices."Awaiting Kra Posting" := false;
                PostedSalesInvoices."Posted To KRA" := true;
                PostedSalesInvoices."Posted To KRA Error" := false;
            end else begin
                PostedSalesInvoices."Posted To KRA Error" := true;
            end;
            PostedSalesInvoices."Kra Error Descripion" := Description;
            PostedSalesInvoices.rcptNo := rcptNo;
            PostedSalesInvoices.intrlData := intrlData;
            PostedSalesInvoices.rcptSign := rcptSign;
            PostedSalesInvoices.totRcptNo := totRcptNo;
            PostedSalesInvoices.vsdcRcptPbctDate := vsdcRcptPbctDate;
            PostedSalesInvoices.sdcId := sdcId;
            PostedSalesInvoices.mrcNo := mrcNo;
            PostedSalesInvoices."QR Code" := 'rcptNo' + rcptNo + ',intrlData' + intrlData + ',rcptSign' + rcptSign + ',totRcptNo' + totRcptNo + ',vsdcRcptPbctDate' + vsdcRcptPbctDate + ',sdcId' + sdcId + ',mrcNo' + mrcNo;
            PostedSalesInvoices.Modify(true);
            Updated := true;
            exit(Updated);
        end;
    end;


    procedure UpdateLocation(No: Code[250]; PostedToKra: Boolean; KraError: Boolean; Description: Text) Updated: Boolean
    var

    begin
        Updated := false;
        Locations.Reset();
        Locations.SetRange(Locations.Code, No);
        if Locations.FindFirst() then begin
            if PostedToKra = true then begin
                Locations."Awaiting Kra Posting" := true;
                Locations."Posted To KRA" := true;
            end else begin
                Locations."Posted To KRA Error" := false;
            end;
            Locations."Kra Error Descripion" := Description;
            Locations.Modify(true);
            Updated := true;
            exit(Updated);
        end;
    end;

    procedure GetBranchID(No: Code[250]) BranchID: Code[250]
    var
    begin
        Locations.Reset();
        Locations.SetRange(Locations.Code, No);
        if Locations.FindFirst() then begin
            BranchID := Locations."KRA Branch Code";
            exit(BranchID);
        end;
    end;










    procedure GetRecord(jsontext: Text; No: Code[250]): Text
    var
        Customer: Record Customer;
        Item: Record Item;
        JSONManagementV2: Codeunit JsonFunctions;
        RecordRef: RecordRef;
        mJsonArray: JsonArray;
        JsonObject: JsonObject;
        NameToken: JsonToken;
        NameRecord: Text;
        Output: Text;
    begin


        NameRecord := jsontext;

        case NameRecord of
            'Item':
                begin
                    Item.Reset();
                    Item.SetRange("Awaiting Kra Posting", true);
                    Item.SetRange("Posted To KRA Error", false);
                    Item.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(Item));
                    until Item.Next() = 0;
                end;
            'ItemSpecific':
                begin
                    Item.Reset();
                    Item.SetRange(Item."No.", No);
                    Item.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(Item));
                    until Item.Next() = 0;
                end;
            'Locations':
                begin
                    Locations.Reset();
                    Locations.SetRange("Awaiting Kra Posting", true);
                    Locations.SetRange("Posted To KRA Error", false);
                    Locations.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(Locations));
                    until Locations.Next() = 0;
                end;
            'PostedPurchInv':
                begin
                    PostedInvoiceHeader.Reset();
                    PostedInvoiceHeader.SetRange("Awaiting Kra Posting", true);
                    PostedInvoiceHeader.SetRange("Posted To KRA Error", false);
                    PostedInvoiceHeader.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(PostedInvoiceHeader));
                    until PostedInvoiceHeader.Next() = 0;
                end;
            'PostedPurchInvLines':
                begin
                    PostedPurchaseInvLines.Reset();
                    PostedPurchaseInvLines.SetRange(PostedPurchaseInvLines."Document No.", No);
                    PostedPurchaseInvLines.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(PostedPurchaseInvLines));
                    until PostedPurchaseInvLines.Next() = 0;
                end;
            'PostedSalesInv':
                begin
                    PostedSalesInvoices.Reset();
                    PostedSalesInvoices.SetRange("Awaiting Kra Posting", true);
                    PostedSalesInvoices.SetRange("Posted To KRA Error", false);
                    PostedSalesInvoices.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(PostedSalesInvoices));
                    until PostedSalesInvoices.Next() = 0;
                end;
            'PostedSalesInvLines':
                begin
                    PostedSalesInvLines.Reset();
                    PostedSalesInvLines.SetRange(PostedSalesInvLines."Document No.", No);
                    PostedSalesInvLines.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(PostedSalesInvLines));
                    until PostedSalesInvLines.Next() = 0;
                end;
            'PostedTransferShipments':
                begin
                    PostedSHipmentsHeader.Reset();
                    PostedSHipmentsHeader.SetRange("Awaiting Kra Posting", true);
                    PostedSHipmentsHeader.SetRange("Posted To KRA Error", false);
                    PostedSHipmentsHeader.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(PostedSHipmentsHeader));
                    until PostedSHipmentsHeader.Next() = 0;
                end;
            'PostedTransferShipmentsLines':
                begin
                    PostedShipmentLines.Reset();
                    PostedShipmentLines.SetRange(PostedShipmentLines."Document No.", No);
                    PostedShipmentLines.FindSet();
                    repeat
                        mJsonArray.Add(JSONManagementV2.RecordToJson(PostedShipmentLines));
                    until PostedShipmentLines.Next() = 0;
                end;






        end;

        mJsonArray.WriteTo(Output);

        exit(Output);
    end;


}