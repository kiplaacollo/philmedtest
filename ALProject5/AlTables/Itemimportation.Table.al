table 50749 "Item importation"
{

    fields
    {
        field(1; "Document No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                if items.Get("Item No") then
                    "Item Name" := items.Description;
            end;
        }
        field(3; "Item Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Negative Adjustment"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                AssetLines.Reset;
                AssetLines.SetRange(AssetLines."Document No", "Document No");
                AssetLines.SetRange(AssetLines."Item No", "Item No");
                AssetLines.SetRange(AssetLines.Store, "Location(To be Loaded)");
                if AssetLines.Find('-') then begin
                    repeat
                        AssetLines.Quantity := -1;
                        AssetLines.Modify
                      until AssetLines.Next = 0;
                end;
            end;
        }
        field(5; "Recovery Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Recovered Functional","Recovered Faulty";
        }
        field(6; "No(To be Adjusted)"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                AssetLines.Reset;
                AssetLines.SetRange(AssetLines."Document No", "Document No");
                AssetLines.SetRange(AssetLines."Item No", "Item No");
                AssetLines.SetRange(AssetLines.Store, "Location(To be Loaded)");
                if AssetLines.Find('-') then
                    AssetLines.DeleteAll;

                //Check Last Serial Used
                NoSeriesLine.Reset;
                NoSeriesLine.SetRange(NoSeriesLine."Series Code", 'SERIALS');
                if NoSeriesLine.Find('-') then
                    lastnoUsed := NoSeriesLine."Last No. Used";
                //Insert Into AssetLines;
                //TotalItems:="Total items";
                SerialNum := (lastnoUsed);
                //
                TotalItems := "No(To be Adjusted)";
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
                    AssetLines.Store := "Location(To be Loaded)";
                    AssetLines."Serial No" := SerialNum;
                    AssetLines.Quantity := 1;
                    AssetLines.Insert;
                    TotalItems := TotalItems - 1;
                until TotalItems = 0;


                NoSeriesLine."Last No. Used" := SerialNum;
                NoSeriesLine.Modify;

                Message('Sub-module lines have been loaded successfully');
            end;
        }
        field(7; "Location(To be Loaded)"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
    }

    keys
    {
        key(Key1; "Document No", "Item No", "Recovery Type", "Negative Adjustment")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        items: Record Item;
        AssetLines: Record "Asset Submodule Line";
        NoSeriesLine: Record "No. Series Line";
        lastnoUsed: Code[30];
        TotalItems: Integer;
        SerialNum: Code[30];
        entryno: Integer;
        itemImportation: Record "Item importation";
}

