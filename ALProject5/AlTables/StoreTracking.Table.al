table 356 "Store Tracking"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;

            trigger OnValidate()
            begin
                items.Reset;
                items.SetRange(items."No.", "Item No");
                if items.Find('-') then
                    "Item Name" := items.Description;

                PurchaseLine.Reset;
                PurchaseLine.SetRange("No.", "Item No");
                PurchaseLine.SetRange("Document No.", "Source ID");
                if PurchaseLine.FindFirst then
                    "Batch No" := PurchaseLine."Batch No";
            end;
        }
        field(3; "Serial No"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Source ID"; Code[25])
        {
            Caption = 'Source ID';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ReqHeader.Reset;
                ReqHeader.SetRange(ReqHeader."No.", "Source ID");
                if ReqHeader.Find('-') then begin
                    "Staff No" := ReqHeader."Staff No";
                    if ReqHeader.Type = ReqHeader.Type::"Technician Requisition" then
                        "Location Code" := ReqHeader."Issuing Store";
                    if ReqHeader.Type = ReqHeader.Type::"Branch Requisition" then
                        "Location Code" := ReqHeader."Destination Store";
                    Type := ReqHeader.Type;
                end;
            end;
        }
        field(6; Accepted; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Accepted,Pending Return,Returned,Installed,Lost,Damaged';
            OptionMembers = Pending,Accepted,"Pending Return",Returned,Installed,Lost,Damaged;

            trigger OnValidate()
            begin
                if Accepted = Accepted::Installed then begin
                    if "Customer No" = '' then
                        Error('Customer No field must be filled before installation');
                end;

                if Accepted = Accepted::"Pending Return" then begin
                    IssuingStore.Reset;
                    IssuingStore.SetRange(IssuingStore.Code, "Staff No");
                    if IssuingStore.Find('-') then begin
                        if IssuingStore."SuperVisor Staff No" = "Staff No" then
                            Accepted := Accepted::Returned;
                    end;
                end;


                if (Accepted = Accepted::Pending) or (Accepted = Accepted::Accepted) then begin
                    RequisitionHeader.Reset;
                    RequisitionHeader.SetRange(RequisitionHeader."No.", "Source ID");
                    if RequisitionHeader.Find('-') then begin
                        IssuingStore.Reset;
                        IssuingStore.SetRange(IssuingStore.Code, RequisitionHeader."Issuing Store");
                        if IssuingStore.Find('-') then begin
                            if RequisitionHeader."Staff No" = IssuingStore."SuperVisor Staff No" then begin
                                Accepted := Accepted::Accepted;
                                RequisitionHeader.Status := RequisitionHeader.Status::Accepted;
                                RequisitionHeader.Modify;
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(7; "Staff No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Installed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Item Name"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Location Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Transaction time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Customer No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(16; "Recovery Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Installed,Damaged,Lost,Returned';
            OptionMembers = " ",Installed,Damaged,Lost,Returned;
        }
        field(17; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Branch Requisition,Technician Requisition';
            OptionMembers = "Branch Requisition","Technician Requisition";
        }
        field(18; Recovery; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Recovered Functional,Rec,Recovered Faulty';
            OptionMembers = "Recovered Functional",Rec,"Recovered Faulty";
        }
        field(19; "Batch No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No", "Item No", "Source ID", "Serial No", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        // stracking.RESET;
        // stracking.SETRANGE(stracking."Serial No","Serial No");
        // IF stracking.FIND('-') THEN BEGIN
        //  REPEAT
        //     IF stracking.Accepted<>stracking.Accepted::Pending THEN
        //  ERROR('Serial No %1 already exists in the store,the serial is %1',stracking."Serial No");
        //    UNTIL  stracking.NEXT=0;
        //  END;

        if "Serial No" = '' then
            Error('Serial number cannot be blank')
    end;

    var
        store: Record "Store Requistion Liness";
        ReqHeader: Record "Store Requistion Headerr";
        items: Record Item;
        CFTFACTORY: Codeunit "CFT Factory";
        stracking: Record "Store Tracking";
        IssuingStore: Record Location;
        RequisitionHeader: Record "Store Requistion Headerr";
        PurchaseLine: Record "Purchase Line";

    procedure InitFromStoreRequisition(Store: Record "Store Requistion Liness")
    begin
        Init;
        SetItemData(
          Store."No.", Store.Description, Store."Location Filter", Store."Description 2", Store."Bin Code",
          Store."Quantity Requested");
        SetSource(
          DATABASE::"Store Requistion Liness", Store.Type, Store."Requistion No", (Store."Line No."), '', 0);
        SetQuantities(
          Store.Quantity, Store.Quantity, Store."Quantity Requested",
          Store.Quantity, Store.Quantity, Store.Quantity,
          Store.Quantity);
        OnAfterInitFromStoreLines(Rec, Store);
    end;

    procedure SetItemData(ItemNo: Code[20]; ItemDescription: Text[100]; LocationCode: Code[10]; VariantCode: Code[10]; BinCode: Code[20]; QtyPerUoM: Decimal)
    begin
        "Item No" := ItemNo;
        //Description := ItemDescription;
        //"Location Code" := LocationCode;
        //"Variant Code" := VariantCode;
        //"Bin Code" := BinCode;
        //"Qty. per Unit of Measure" := QtyPerUoM;
    end;

    procedure SetQuantities(QtyBase: Decimal; QtyToHandle: Decimal; QtyToHandleBase: Decimal; QtyToInvoice: Decimal; QtyToInvoiceBase: Decimal; QtyHandledBase: Decimal; QtyInvoicedBase: Decimal)
    begin
        Quantity := QtyBase;
        Quantity := QtyToHandle;
        //"Qty. to Handle (Base)" := QtyToHandleBase;
        //"Qty. to Invoice" := QtyToInvoice;
        //"Qty. to Invoice (Base)" := QtyToInvoiceBase;
        //"Quantity Handled (Base)" := QtyHandledBase;
        //"Quantity Invoiced (Base)" := QtyInvoicedBase;
    end;

    procedure SetSource(SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; SourceBatchName: Code[10]; SourceProdOrderLine: Integer)
    begin
        //"Source Type" := SourceType;
        //"Source Subtype" := SourceSubtype;
        "Source ID" := SourceID;
        //"Source Ref. No." := SourceRefNo;
        //"Source Batch Name" := SourceBatchName;
        //"Source Prod. Order Line" := SourceProdOrderLine;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitFromStoreLines(var TrackingSpecification: Record "Store Tracking"; store: Record "Store Requistion Liness")
    begin
    end;

    procedure returnStoreNo(Store: Record "Store Requistion Liness"): Code[25]
    var
        storeno: Code[24];
    begin
        storeno := Store."Requistion No";
        Message('n1o %1', storeno);
        exit(storeno);
    end;

    procedure InitFromStoreRequisition1(Store: Record "Store Requistion Liness")
    begin
        //MESSAGE('store no is %1',Store."Requistion No");
    end;

    [Scope('Internal')]
    procedure FnReduceInventory(itemNo: Code[35]; ReqNo: Code[30]; location: Code[30]; SerialNo: Code[30])
    var
        LineNo: Integer;
        GenJnline: Record "Item Journal Line";
        InventorySetup: Record "Inventory Setup";
        ReqLine: Record "Store Requistion Liness";
        Item: Record Item;
        tspecification: Record "Tracking Specification";
        LastResNo: Integer;
        Tracking: Record "Tracking Specification";
        Journals: Record "Item Journal Line";
        itemledger: Record "Item Ledger Entry";
        ledger: Record "Item Ledger Entry";
    begin
        ReqLine.Reset;
        ReqLine.SetRange(ReqLine."Requistion No", ReqNo);
        if ReqLine.Find('-') then
            InventorySetup.Get;
        // ERROR('item %1',InventorySetup."Item Jnl Template");
        //DELETE

        ledger.Reset;
        if ledger.FindLast then
            LastResNo := ledger."Entry No." + 1;

        //insert into item ledger entry
        itemledger.Init;
        itemledger."Entry No." := LastResNo;
        itemledger."Item No." := itemNo;
        itemledger."Posting Date" := Today;
        itemledger."Entry Type" := itemledger."Entry Type"::"Negative Adjmt.";
        itemledger."Document No." := 'ADJ';
        if Item.Get(itemNo) then
            itemledger.Description := Item.Description;
        itemledger."Location Code" := location;
        itemledger."Serial No." := SerialNo;
        itemledger.Quantity := -1;
        itemledger.Insert;

        //Insert Tracking Info
        tspecification.Reset;
        if tspecification.FindLast then
            LastResNo := tspecification."Entry No.";

        /*
                         Tracking.INIT;
                         Tracking."Entry No.":=LastResNo;
                         Tracking."Item No.":=itemNo;
                         Tracking."Location Code":=location;
                         Tracking."Serial No.":=SerialNo;
                         Tracking."Quantity (Base)":=1;
                         Tracking."Source ID":='ITEM';
                         Tracking."Source Ref. No.":=10000;
                         Tracking."Source Batch Name":='DEFAULT';
                         Tracking."Qty. per Unit of Measure":=1;
                        // Tracking.INSERT;
                        */
        //End Insert Tracking




    end;
}

