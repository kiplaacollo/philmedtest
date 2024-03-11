table 50748 "Asset Transfer Table"
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
                    NoSeriesMgt.TestManual(GenLedgerSetup."Asset Transfer Nos");
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
        field(5; "Item Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Total To Transfer"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Issuing Store"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE (IsBaseStation = FILTER (true));
        }
        field(8; "Destination Store"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE (IsBaseStation = FILTER (true));
        }
        field(9; Transferred; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    TotalTransfer := "Total To Transfer";
                    repeat
                        ItemLedger.Reset;
                        ItemLedger.SetRange(ItemLedger."Item No.", "Item No");
                        ItemLedger.SetRange(ItemLedger."Location Code", "Issuing Store");
                        if ItemLedger.Find('-') then begin

                            ItemLedger."Location Code" := "Destination Store";
                            //Check if Destination Base station
                            Location.Reset;
                            Location.SetRange(Location.Code, "Destination Store");
                            if Location.Find('-') then begin
                                if Location.IsBaseStation = true then begin
                                    if Location."Is Store" = false then
                                        ItemLedger."Transferr to Base Station" := true;
                                end;
                            end;
                            ItemLedger."Posting Date" := Today;

                            ItemLedger.Modify;
                        end;
                        TotalTransfer := TotalTransfer - 1;

                    until TotalTransfer = 0;


                end;
            end;
        }
        field(11; "No. Series"; Code[30])
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
            GenLedgerSetup.TestField(GenLedgerSetup."Asset Transfer Nos");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Asset Transfer Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Created By" := UserId;
        Date := Today;
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
        NoSeries: Record "No. Series Line";
        SerialNum: Code[30];
        store: Record Location;
        Tracking: Record "Store Tracking";
        ItemLedger: Record "Item Ledger Entry";
        TotalTransfer: Integer;
        ccount: Integer;
        Location: Record Location;
}

