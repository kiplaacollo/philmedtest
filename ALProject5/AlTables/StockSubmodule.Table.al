table 50745 "Stock Submodule"
{

    fields
    {
        field(1; "Document No"; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    GenLedgerSetup.Get();
                    NoSeriesMgt.TestManual(GenLedgerSetup."Asset Module Nos");
                    "Document No" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Item No"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                if item.Get("Item No") then
                    "Item Name" := item.Description;
            end;
        }
        field(5; "Item Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Store(Where Items are Loaded )"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE (IsBaseStation = FILTER (true));

            trigger OnValidate()
            begin
                store.Reset;
                store.SetRange(store.Code, "Store(Where Items are Loaded )");
                if store.Find('-') then
                    SuperVisor := store."SuperVisor Staff No";

            end;
        }
        field(7; "Total items"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                AssetLines.Reset;
                AssetLines.SetRange(AssetLines."Document No", "Document No");
                if AssetLines.Find('-') then
                    AssetLines.DeleteAll;

                //Check Last Serial Used
                NoSeriesLine.Reset;
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'SERIALS');
                if NoSeriesLine.Find('-') then
                    lastnoUsed := NoSeriesLine."Last No. Used";
                //Insert Into AssetLines;
                TotalItems := "Total items";
                SerialNum := (lastnoUsed);
                entryno := 0;
                repeat
                    SerialNum := IncStr(SerialNum);
                    // MESSAGE('SerialNum %1',SerialNum);
                    entryno := entryno + 1;
                    AssetLines.Init;
                    AssetLines."Entry No" := entryno;
                    AssetLines."Document No" := "Document No";
                    AssetLines."Item No" := "Item No";
                    AssetLines.Validate(AssetLines."Item No");
                    AssetLines.Store := "Store(Where Items are Loaded )";
                    AssetLines."Serial No" := SerialNum;
                    AssetLines.Insert;
                    TotalItems := TotalItems - 1;
                until TotalItems = 0;



                Message('Sub-module lines have been loaded successfully');
            end;
        }
        field(8; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Loaded into Store Tracking"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; SuperVisor; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Recovery Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Recovered Functional","Recovered Faulty";
        }
        field(12; Negative; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    if Bulk = false then begin
                        if Negative = false then begin
                            if Confirm('Do you want to load this items into store tracking?', false) = true then begin
                                Ledger.Reset;
                                if Ledger.FindLast then
                                    entryno := Ledger."Entry No.";
                                AssetLines.Reset;
                                AssetLines.SetRange(AssetLines."Document No", "Document No");
                                if AssetLines.Find('-') then begin
                                    repeat
                                        entryno := entryno + 1;
                                        StoreTracking.Init;
                                        StoreTracking."Entry No" := entryno;
                                        StoreTracking."Item No" := AssetLines."Item No";
                                        StoreTracking.Validate(StoreTracking."Item No");
                                        StoreTracking."Source ID" := AssetLines."Document No";
                                        StoreTracking."Serial No" := AssetLines."Serial No";
                                        StoreTracking.Quantity := 1;
                                        StoreTracking.Accepted := StoreTracking.Accepted::Accepted;
                                        StoreTracking."Staff No" := SuperVisor;
                                        StoreTracking."Location Code" := AssetLines.Store;
                                        StoreTracking."Transaction Date" := Today;
                                        StoreTracking."Transaction time" := Time;
                                        if "Recovery Type" = "Recovery Type"::"Recovered Functional" then
                                            StoreTracking.Recovery := StoreTracking.Recovery::"Recovered Functional";

                                        if "Recovery Type" = "Recovery Type"::"Recovered Faulty" then
                                            StoreTracking.Recovery := StoreTracking.Recovery::"Recovered Faulty";
                                        StoreTracking.Type := StoreTracking.Type::"Technician Requisition";
                                        StoreTracking.Insert;


                                        //Insert into Item Ledger
                                        entryno := entryno + 1;
                                        itemledger.Init;
                                        itemledger."Entry No." := entryno;
                                        itemledger."Item No." := AssetLines."Item No";
                                        itemledger."Posting Date" := Today;
                                        itemledger."Entry Type" := itemledger."Entry Type"::"Positive Adjmt.";
                                        itemledger."Document No." := 'ADJ';
                                        itemledger.Description := AssetLines."Item Name";
                                        itemledger."Location Code" := AssetLines.Store;
                                        itemledger.Quantity := 1;
                                        itemledger."Uploaded By" := UserId;
                                        itemledger."Uploaded Through Asset Module" := true;
                                        itemledger."Serial No." := AssetLines."Serial No";
                                        if "Recovery Type" = "Recovery Type"::"Recovered Functional" then
                                            itemledger."Recovered Functional" := true;
                                        if "Recovery Type" = "Recovery Type"::"Recovered Faulty" then
                                            itemledger."Recovered Faulty" := true;
                                        itemledger."Posting Time" := Time;
                                        itemledger.Insert;
                                    until AssetLines.Next = 0;
                                    Message('Items loaded successfully into store tracking');
                                end;

                                Tracking.Reset;
                                Tracking.SetRange(Tracking."Source ID", "Document No");
                                if Tracking.FindLast then
                                    lastnoUsed := Tracking."Serial No";
                                //Check Last Serial Used
                                NoSeries.Reset;
                                NoSeries.SetRange(NoSeries."Series Code", 'SERIALS');
                                if NoSeries.Find('-') then begin
                                    NoSeries."Last No. Used" := lastnoUsed;
                                    NoSeries.Modify;
                                end;
                            end;
                        end;
                        if Negative = true then begin
                            if Confirm('Do you want to do this negative adjustment?', false) = true then begin
                                Ledger.Reset;
                                if Ledger.FindLast then
                                    entryno := Ledger."Entry No.";
                                AssetLines.Reset;
                                AssetLines.SetRange(AssetLines."Document No", "Document No");
                                if AssetLines.Find('-') then begin
                                    repeat
                                        //Insert into Item Ledger
                                        entryno := entryno + 1;
                                        itemledger.Init;
                                        itemledger."Entry No." := entryno;
                                        itemledger."Item No." := AssetLines."Item No";
                                        itemledger."Posting Date" := Today;
                                        itemledger."Entry Type" := itemledger."Entry Type"::"Positive Adjmt.";
                                        itemledger."Document No." := 'ADJ';
                                        itemledger.Description := AssetLines."Item Name";
                                        itemledger."Location Code" := AssetLines.Store;
                                        itemledger.Quantity := -1;
                                        itemledger."Uploaded By" := UserId;
                                        itemledger."Uploaded Through Asset Module" := true;
                                        itemledger."Serial No." := AssetLines."Serial No";
                                        if "Recovery Type" = "Recovery Type"::"Recovered Functional" then
                                            itemledger."Recovered Functional" := true;
                                        if "Recovery Type" = "Recovery Type"::"Recovered Faulty" then
                                            itemledger."Recovered Faulty" := true;

                                        itemledger."Posting Time" := Time;
                                        itemledger.Insert;
                                    until AssetLines.Next = 0;
                                    Message('Negative Adjustment Done Successfully');
                                end;
                            end;
                        end;
                    end;
                    if Bulk = true then begin
                        FnBulkAdjustment;
                    end;
                    Posted := true;
                    Modify;
                end;
            end;
        }
        field(16; Bulk; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No", "Item No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."Asset Module Nos");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Asset Module Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Created By" := UserId;
        Date := Today;
        "Store(Where Items are Loaded )" := 'NANYUKI';
        Validate("Store(Where Items are Loaded )");
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Purchases & Payables Setup";
        item: Record Item;
        AssetLines: Record "Asset Submodule Line";
        TotalItems: Integer;
        entryno: Integer;
        NoSeriesLine: Record "No. Series Line";
        lastnoUsed: Code[40];
        SerialNum: Code[30];
        store: Record Location;
        StoreTracking: Record "Store Tracking";
        NoSeries: Record "No. Series Line";
        Tracking: Record "Store Tracking";
        Ledger: Record "Item Ledger Entry";
        itemledger: Record "Item Ledger Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    [Scope('Internal')]
    procedure FnBulkAdjustment()
    begin
        Ledger.Reset;
        if Ledger.FindLast then
            entryno := Ledger."Entry No.";
        AssetLines.Reset;
        AssetLines.SetRange(AssetLines."Document No", "Document No");
        if AssetLines.Find('-') then begin
            repeat
                entryno := entryno + 1;
                StoreTracking.Init;
                StoreTracking."Entry No" := entryno;
                StoreTracking."Item No" := AssetLines."Item No";
                StoreTracking.Validate(StoreTracking."Item No");
                StoreTracking."Source ID" := AssetLines."Document No";
                StoreTracking."Serial No" := AssetLines."Serial No";
                StoreTracking.Quantity := 1;
                StoreTracking.Accepted := StoreTracking.Accepted::Accepted;
                StoreTracking."Staff No" := SuperVisor;
                StoreTracking."Location Code" := AssetLines.Store;
                StoreTracking."Transaction Date" := Today;
                StoreTracking."Transaction time" := Time;
                if "Recovery Type" = "Recovery Type"::"Recovered Functional" then
                    StoreTracking.Recovery := StoreTracking.Recovery::"Recovered Functional";

                if "Recovery Type" = "Recovery Type"::"Recovered Faulty" then
                    StoreTracking.Recovery := StoreTracking.Recovery::"Recovered Faulty";
                StoreTracking.Type := StoreTracking.Type::"Technician Requisition";
                StoreTracking.Insert;


                //Insert into Item Ledger
                entryno := entryno + 1;
                itemledger.Init;
                itemledger."Entry No." := entryno;
                itemledger."Item No." := AssetLines."Item No";
                itemledger."Posting Date" := Today;
                itemledger."Entry Type" := itemledger."Entry Type"::"Positive Adjmt.";
                itemledger."Document No." := 'ADJ';
                itemledger.Description := AssetLines."Item Name";
                itemledger."Location Code" := AssetLines.Store;
                itemledger.Quantity := AssetLines.Quantity;
                itemledger."Uploaded By" := UserId;
                itemledger."Uploaded Through Asset Module" := true;
                itemledger."Serial No." := AssetLines."Serial No";
                if "Recovery Type" = "Recovery Type"::"Recovered Functional" then
                    itemledger."Recovered Functional" := true;
                if "Recovery Type" = "Recovery Type"::"Recovered Faulty" then
                    itemledger."Recovered Faulty" := true;
                itemledger."Posting Time" := Time;
                itemledger.Insert;
            until AssetLines.Next = 0;
            Message('Items loaded successfully into store tracking');
        end;

        Tracking.Reset;
        Tracking.SetRange(Tracking."Source ID", "Document No");
        if Tracking.FindLast then
            lastnoUsed := Tracking."Serial No";
        //Check Last Serial Used
        NoSeries.Reset;
        NoSeries.SetRange(NoSeries."Series Code", 'SERIALS');
        if NoSeries.Find('-') then begin
            NoSeries."Last No. Used" := lastnoUsed;
            NoSeries.Modify;
        end;

    end;
}

