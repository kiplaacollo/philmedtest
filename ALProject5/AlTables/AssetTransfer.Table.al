table 50747 "Asset Transfer"
{

    fields
    {
        field(1; "Document No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Transfer To"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE ("Is Store" = FILTER (true));
        }
        field(3; "Total to Be Transferred"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TotalTobeTransferred := 0;
                begin
                    repeat
                        TotalTobeTransferred := TotalTobeTransferred + "Total to Be Transferred";
                    until Next = 0;
                    StockHeader.Reset;
                    StockHeader.SetRange(StockHeader."Document No", "Document No");
                    if StockHeader.Find('-') then begin
                        if TotalTobeTransferred > StockHeader."Total items" then
                            Error('You cannot Transfer more than the imported Assets');
                    end;
                end;
            end;
        }
        field(4; Transfered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No", "Transfer To", "Total to Be Transferred")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AssetTransfer: Record "Asset Transfer";
        TotalTobeTransferred: Integer;
        StockHeader: Record "Stock Submodule";
}

