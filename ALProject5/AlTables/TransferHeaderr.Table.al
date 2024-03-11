table 50616 "Transfer Headerr"
{
    Caption = 'Transfer Header';
    LookupPageID = "Transfer Orders open";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetInventorySetup;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            TableRelation = Location WHERE ("Use As In-Transit" = CONST (false));

            trigger OnValidate()
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
                TestStatusOpen;
                if ("Transfer-from Code" = "Transfer-to Code") and
                   ("Transfer-from Code" <> '')
                then
                    Error(
                      Text001,
                      FieldCaption("Transfer-from Code"), FieldCaption("Transfer-to Code"),
                      TableCaption, "No.");
                if xRec."Transfer-from Code" <> "Transfer-from Code" then begin
                    if HideValidationDialog or
                       (xRec."Transfer-from Code" = '')
                    then
                        Confirmed := true
                    else
                        Confirmed := Confirm(Text002, false, FieldCaption("Transfer-from Code"));
                    if Confirmed then begin
                        if Location.Get("Transfer-from Code") then begin
                            "Transfer-from Name" := Location.Name;
                            "Transfer-from Name 2" := Location."Name 2";
                            "Transfer-from Address" := Location.Address;
                            "Transfer-from Address 2" := Location."Address 2";
                            "Transfer-from Post Code" := Location."Post Code";
                            "Transfer-from City" := Location.City;
                            "Transfer-from County" := Location.County;
                            "Trsf.-from Country/Region Code" := Location."Country/Region Code";
                            "Transfer-from Contact" := Location.Contact;
                            "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
                            TransferRoute.GetTransferRoute(
                              "Transfer-from Code", "Transfer-to Code", "In-Transit Code",
                              "Shipping Agent Code", "Shipping Agent Service Code");
                            TransferRoute.GetShippingTime(
                              "Transfer-from Code", "Transfer-to Code",
                              "Shipping Agent Code", "Shipping Agent Service Code",
                              "Shipping Time");
                            TransferRoute.CalcReceiptDate(
                              "Shipment Date",
                              "Receipt Date",
                              "Shipping Time",
                              "Outbound Whse. Handling Time",
                              "Inbound Whse. Handling Time",
                              "Transfer-from Code",
                              "Transfer-to Code",
                              "Shipping Agent Code",
                              "Shipping Agent Service Code");
                            TransLine.LockTable;
                            TransLine.SetRange("Document No.", "No.");
                            if TransLine.FindSet then;
                            Modify;
                        end;
                        UpdateTransLines(FieldNo("Transfer-from Code"));
                    end else begin
                        "Transfer-from Code" := xRec."Transfer-from Code";
                        exit;
                    end;
                end;
            end;
        }
        field(3; "Transfer-from Name"; Text[50])
        {
            Caption = 'Transfer-from Name';
        }
        field(4; "Transfer-from Name 2"; Text[50])
        {
            Caption = 'Transfer-from Name 2';
        }
        field(5; "Transfer-from Address"; Text[50])
        {
            Caption = 'Transfer-from Address';
        }
        field(6; "Transfer-from Address 2"; Text[50])
        {
            Caption = 'Transfer-from Address 2';
        }
        field(7; "Transfer-from Post Code"; Code[20])
        {
            Caption = 'Transfer-from ZIP Code';
            TableRelation = IF ("Trsf.-from Country/Region Code" = CONST ('')) "Post Code"
            ELSE
            IF ("Trsf.-from Country/Region Code" = FILTER (<> '')) "Post Code" WHERE ("Country/Region Code" = FIELD ("Trsf.-from Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(
                  "Transfer-from City", "Transfer-from Post Code",
                  "Transfer-from County", "Trsf.-from Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(8; "Transfer-from City"; Text[30])
        {
            Caption = 'Transfer-from City';
            TableRelation = IF ("Trsf.-from Country/Region Code" = CONST ('')) "Post Code".City
            ELSE
            IF ("Trsf.-from Country/Region Code" = FILTER (<> '')) "Post Code".City WHERE ("Country/Region Code" = FIELD ("Trsf.-from Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(
                  "Transfer-from City", "Transfer-from Post Code",
                  "Transfer-from County", "Trsf.-from Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(9; "Transfer-from County"; Text[30])
        {
            Caption = 'Transfer-from State';
        }
        field(10; "Trsf.-from Country/Region Code"; Code[10])
        {
            Caption = 'Trsf.-from Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(11; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            TableRelation = Location WHERE ("Use As In-Transit" = CONST (false));

            trigger OnValidate()
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
                TestStatusOpen;
                if ("Transfer-from Code" = "Transfer-to Code") and
                   ("Transfer-to Code" <> '')
                then
                    Error(
                      Text001,
                      FieldCaption("Transfer-from Code"), FieldCaption("Transfer-to Code"),
                      TableCaption, "No.");
                if xRec."Transfer-to Code" <> "Transfer-to Code" then begin
                    if HideValidationDialog or
                       (xRec."Transfer-to Code" = '')
                    then
                        Confirmed := true
                    else
                        Confirmed := Confirm(Text002, false, FieldCaption("Transfer-to Code"));
                    if Confirmed then begin
                        if Location.Get("Transfer-to Code") then begin
                            "Transfer-to Name" := Location.Name;
                            "Transfer-to Name 2" := Location."Name 2";
                            "Transfer-to Address" := Location.Address;
                            "Transfer-to Address 2" := Location."Address 2";
                            "Transfer-to Post Code" := Location."Post Code";
                            "Transfer-to City" := Location.City;
                            "Transfer-to County" := Location.County;
                            "Trsf.-to Country/Region Code" := Location."Country/Region Code";
                            "Transfer-to Contact" := Location.Contact;
                            "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
                            TransferRoute.GetTransferRoute(
                              "Transfer-from Code", "Transfer-to Code", "In-Transit Code",
                              "Shipping Agent Code", "Shipping Agent Service Code");
                            TransferRoute.GetShippingTime(
                              "Transfer-from Code", "Transfer-to Code",
                              "Shipping Agent Code", "Shipping Agent Service Code",
                              "Shipping Time");
                            TransferRoute.CalcReceiptDate(
                              "Shipment Date",
                              "Receipt Date",
                              "Shipping Time",
                              "Outbound Whse. Handling Time",
                              "Inbound Whse. Handling Time",
                              "Transfer-from Code",
                              "Transfer-to Code",
                              "Shipping Agent Code",
                              "Shipping Agent Service Code");
                            TransLine.LockTable;
                            TransLine.SetRange("Document No.", "No.");
                            if TransLine.FindSet then;
                            Modify;
                        end;
                        UpdateTransLines(FieldNo("Transfer-to Code"));
                    end else begin
                        "Transfer-to Code" := xRec."Transfer-to Code";
                        exit;
                    end;
                end;
            end;
        }
        field(12; "Transfer-to Name"; Text[50])
        {
            Caption = 'Transfer-to Name';
        }
        field(13; "Transfer-to Name 2"; Text[50])
        {
            Caption = 'Transfer-to Name 2';
        }
        field(14; "Transfer-to Address"; Text[50])
        {
            Caption = 'Transfer-to Address';
        }
        field(15; "Transfer-to Address 2"; Text[50])
        {
            Caption = 'Transfer-to Address 2';
        }
        field(16; "Transfer-to Post Code"; Code[20])
        {
            Caption = 'Transfer-to ZIP Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(
                  "Transfer-to City", "Transfer-to Post Code", "Transfer-to County",
                  "Trsf.-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(17; "Transfer-to City"; Text[30])
        {
            Caption = 'Transfer-to City';
            TableRelation = IF ("Trsf.-to Country/Region Code" = CONST ('')) "Post Code".City
            ELSE
            IF ("Trsf.-to Country/Region Code" = FILTER (<> '')) "Post Code".City WHERE ("Country/Region Code" = FIELD ("Trsf.-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(
                  "Transfer-to City", "Transfer-to Post Code", "Transfer-to County",
                  "Trsf.-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(18; "Transfer-to County"; Text[30])
        {
            Caption = 'Transfer-to State';
        }
        field(19; "Trsf.-to Country/Region Code"; Code[10])
        {
            Caption = 'Trsf.-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(21; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TransferRoute.CalcReceiptDate(
                  "Shipment Date",
                  "Receipt Date",
                  "Shipping Time",
                  "Outbound Whse. Handling Time",
                  "Inbound Whse. Handling Time",
                  "Transfer-from Code",
                  "Transfer-to Code",
                  "Shipping Agent Code",
                  "Shipping Agent Service Code");
                UpdateTransLines(FieldNo("Shipment Date"));
            end;
        }
        field(22; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TransferRoute.CalcShipmentDate(
                  "Shipment Date",
                  "Receipt Date",
                  "Shipping Time",
                  "Outbound Whse. Handling Time",
                  "Inbound Whse. Handling Time",
                  "Transfer-from Code",
                  "Transfer-to Code",
                  "Shipping Agent Code",
                  "Shipping Agent Service Code");
                UpdateTransLines(FieldNo("Receipt Date"));
            end;
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;

            trigger OnValidate()
            begin
                UpdateTransLines(FieldNo(Status));
            end;
        }
        field(24; Comment; Boolean)
        {
            CalcFormula = Exist ("Inventory Comment Line" WHERE ("Document Type" = CONST ("Transfer Order"),
                                                                "No." = FIELD ("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(26; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(27; "In-Transit Code"; Code[10])
        {
            Caption = 'In-Transit Code';
            TableRelation = Location WHERE ("Use As In-Transit" = CONST (true));

            trigger OnValidate()
            begin
                TestStatusOpen;
                UpdateTransLines(FieldNo("In-Transit Code"));
            end;
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(29; "Last Shipment No."; Code[20])
        {
            Caption = 'Last Shipment No.';
            Editable = false;
            TableRelation = "Transfer Shipment Header";
        }
        field(30; "Last Receipt No."; Code[20])
        {
            Caption = 'Last Receipt No.';
            Editable = false;
            TableRelation = "Transfer Receipt Header";
        }
        field(31; "Transfer-from Contact"; Text[50])
        {
            Caption = 'Transfer-from Contact';
        }
        field(32; "Transfer-to Contact"; Text[50])
        {
            Caption = 'Transfer-to Contact';
        }
        field(33; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(34; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                TestStatusOpen;
                if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
                    Validate("Shipping Agent Service Code", '');
                UpdateTransLines(FieldNo("Shipping Agent Code"));
            end;
        }
        field(35; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE ("Shipping Agent Code" = FIELD ("Shipping Agent Code"));

            trigger OnValidate()
            begin
                TestStatusOpen;
                TransferRoute.GetShippingTime(
                  "Transfer-from Code", "Transfer-to Code",
                  "Shipping Agent Code", "Shipping Agent Service Code",
                  "Shipping Time");
                TransferRoute.CalcReceiptDate(
                  "Shipment Date",
                  "Receipt Date",
                  "Shipping Time",
                  "Outbound Whse. Handling Time",
                  "Inbound Whse. Handling Time",
                  "Transfer-from Code",
                  "Transfer-to Code",
                  "Shipping Agent Code",
                  "Shipping Agent Service Code");

                UpdateTransLines(FieldNo("Shipping Agent Service Code"));
            end;
        }
        field(36; "Shipping Time"; DateFormula)
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Time';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TransferRoute.CalcReceiptDate(
                  "Shipment Date",
                  "Receipt Date",
                  "Shipping Time",
                  "Outbound Whse. Handling Time",
                  "Inbound Whse. Handling Time",
                  "Transfer-from Code",
                  "Transfer-to Code",
                  "Shipping Agent Code",
                  "Shipping Agent Service Code");

                UpdateTransLines(FieldNo("Shipping Time"));
            end;
        }
        field(37; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(47; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(48; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(59; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(63; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(64; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;
        }
        field(5750; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;

            trigger OnValidate()
            begin
                /*IF "Shipping Advice" <> xRec."Shipping Advice" THEN BEGIN
                  TestStatusOpen;
                  WhseSourceHeader.TransHeaderVerifyChange(Rec,xRec);
                END;
                */

            end;
        }
        field(5751; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            CalcFormula = Min ("Transfer Line"."Completely Shipped" WHERE ("Document No." = FIELD ("No."),
                                                                          "Shipment Date" = FIELD ("Date Filter"),
                                                                          "Transfer-from Code" = FIELD ("Location Filter"),
                                                                          "Derived From Line No." = CONST (0)));
            Caption = 'Completely Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Completely Received"; Boolean)
        {
            CalcFormula = Min ("Transfer Line"."Completely Received" WHERE ("Document No." = FIELD ("No."),
                                                                           "Receipt Date" = FIELD ("Date Filter"),
                                                                           "Transfer-to Code" = FIELD ("Location Filter"),
                                                                           "Derived From Line No." = CONST (0)));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Outbound Whse. Handling Time';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TransferRoute.CalcReceiptDate(
                  "Shipment Date",
                  "Receipt Date",
                  "Shipping Time",
                  "Outbound Whse. Handling Time",
                  "Inbound Whse. Handling Time",
                  "Transfer-from Code",
                  "Transfer-to Code",
                  "Shipping Agent Code",
                  "Shipping Agent Service Code");

                UpdateTransLines(FieldNo("Outbound Whse. Handling Time"));
            end;
        }
        field(5794; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TransferRoute.CalcReceiptDate(
                  "Shipment Date",
                  "Receipt Date",
                  "Shipping Time",
                  "Outbound Whse. Handling Time",
                  "Inbound Whse. Handling Time",
                  "Transfer-from Code",
                  "Transfer-to Code",
                  "Shipping Agent Code",
                  "Shipping Agent Service Code");

                UpdateTransLines(FieldNo("Inbound Whse. Handling Time"));
            end;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(9000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            TableRelation = "User Setup";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Transfer-from Code", "Transfer-to Code", "Shipment Date", Status)
        {
        }
    }

    trigger OnDelete()
    var
        TransLine: Record "Transfer Line";
        InvtCommentLine: Record "Inventory Comment Line";
        ReservMgt: Codeunit "Reservation Management";
    begin
        TestField(Status, Status::Open);

        WhseRequest.SetRange("Source Type", DATABASE::"Transfer Line");
        WhseRequest.SetRange("Source No.", "No.");
        if not WhseRequest.IsEmpty then
            WhseRequest.DeleteAll(true);

        ReservMgt.DeleteDocumentReservation(DATABASE::"Transfer Line", 0, "No.", HideValidationDialog);

        TransLine.SetRange("Document No.", "No.");
        TransLine.DeleteAll(true);

        InvtCommentLine.SetRange("Document Type", InvtCommentLine."Document Type"::"Transfer Order");
        InvtCommentLine.SetRange("No.", "No.");
        InvtCommentLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        GetInventorySetup;
        if "No." = '' then begin
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;
        InitRecord;
        Validate("Shipment Date", WorkDate);
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: Label 'You cannot rename a %1.';
        Text001: Label '%1 and %2 cannot be the same in %3 %4.';
        Text002: Label 'Do you want to change %1?';
        Text003: Label 'The transfer order %1 has been deleted.';
        TransferRoute: Record "Transfer Route";
        TransHeader: Record "Transfer Header";
        TransLine: Record "Transfer Line";
        PostCode: Record "Post Code";
        InvtSetup: Record "Inventory Setup";
        WhseRequest: Record "Warehouse Request";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WhseSourceHeader: Codeunit "Whse. Validate Source Header";
        HideValidationDialog: Boolean;
        HasInventorySetup: Boolean;
        CalledFromWhse: Boolean;
        Text007: Label 'You may have changed a dimension.\\Do you want to update the lines?';

    [Scope('Internal')]
    procedure InitRecord()
    begin
        if "Posting Date" = 0D then
            Validate("Posting Date", WorkDate);
    end;

    [Scope('Internal')]
    procedure AssistEdit(OldTransHeader: Record "Transfer Header"): Boolean
    begin
        /*WITH TransHeader DO BEGIN
          TransHeader := Rec;
          GetInventorySetup;
          TestNoSeries;
          IF NoSeriesMgt.SelectSeries(GetNoSeriesCode,OldTransHeader."No. Series","No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            Rec := TransHeader;
            EXIT(TRUE);
          END;
        END;
        */

    end;

    local procedure TestNoSeries()
    begin
        InvtSetup.TestField("Transfer Order Nos.");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        exit(InvtSetup."Transfer Order Nos.");
    end;

    [Scope('Internal')]
    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            if TransferLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure GetInventorySetup()
    begin
        if not HasInventorySetup then begin
            InvtSetup.Get;
            HasInventorySetup := true;
        end;
    end;

    local procedure UpdateTransLines(FieldRef: Integer)
    var
        TransLine: Record "Transfer Line";
    begin
        TransLine.SetRange("Document No.", "No.");
        TransLine.SetFilter("Item No.", '<>%1', '');
        if TransLine.FindSet then begin
            TransLine.LockTable;
            repeat
                case FieldRef of
                    FieldNo("In-Transit Code"):
                        TransLine.Validate("In-Transit Code", "In-Transit Code");
                    FieldNo("Transfer-from Code"):
                        begin
                            TransLine.Validate("Transfer-from Code", "Transfer-from Code");
                            TransLine.Validate("Shipping Agent Code", "Shipping Agent Code");
                            TransLine.Validate("Shipping Agent Service Code", "Shipping Agent Service Code");
                            TransLine.Validate("Shipment Date", "Shipment Date");
                            TransLine.Validate("Receipt Date", "Receipt Date");
                            TransLine.Validate("Shipping Time", "Shipping Time");
                        end;
                    FieldNo("Transfer-to Code"):
                        begin
                            TransLine.Validate("Transfer-to Code", "Transfer-to Code");
                            TransLine.Validate("Shipping Agent Code", "Shipping Agent Code");
                            TransLine.Validate("Shipping Agent Service Code", "Shipping Agent Service Code");
                            TransLine.Validate("Shipment Date", "Shipment Date");
                            TransLine.Validate("Receipt Date", "Receipt Date");
                            TransLine.Validate("Shipping Time", "Shipping Time");
                        end;
                    FieldNo("Shipping Agent Code"):
                        begin
                            TransLine.Validate("Shipping Agent Code", "Shipping Agent Code");
                            TransLine.BlockDynamicTracking(true);
                            TransLine.Validate("Shipping Agent Service Code", "Shipping Agent Service Code");
                            TransLine.Validate("Shipment Date", "Shipment Date");
                            TransLine.Validate("Receipt Date", "Receipt Date");
                            TransLine.Validate("Shipping Time", "Shipping Time");
                            TransLine.BlockDynamicTracking(false);
                            TransLine.DateConflictCheck;
                        end;
                    FieldNo("Shipping Agent Service Code"):
                        begin
                            TransLine.BlockDynamicTracking(true);
                            TransLine.Validate("Shipping Agent Service Code", "Shipping Agent Service Code");
                            TransLine.Validate("Shipment Date", "Shipment Date");
                            TransLine.Validate("Receipt Date", "Receipt Date");
                            TransLine.Validate("Shipping Time", "Shipping Time");
                            TransLine.BlockDynamicTracking(false);
                            TransLine.DateConflictCheck;
                        end;
                    FieldNo("Shipment Date"):
                        begin
                            TransLine.BlockDynamicTracking(true);
                            TransLine.Validate("Shipment Date", "Shipment Date");
                            TransLine.Validate("Receipt Date", "Receipt Date");
                            TransLine.Validate("Shipping Time", "Shipping Time");
                            TransLine.BlockDynamicTracking(false);
                            TransLine.DateConflictCheck;
                        end;
                    FieldNo("Receipt Date"), FieldNo("Shipping Time"):
                        begin
                            TransLine.BlockDynamicTracking(true);
                            TransLine.Validate("Shipping Time", "Shipping Time");
                            TransLine.Validate("Receipt Date", "Receipt Date");
                            TransLine.BlockDynamicTracking(false);
                            TransLine.DateConflictCheck;
                        end;
                    FieldNo("Outbound Whse. Handling Time"):
                        TransLine.Validate("Outbound Whse. Handling Time", "Outbound Whse. Handling Time");
                    FieldNo("Inbound Whse. Handling Time"):
                        TransLine.Validate("Inbound Whse. Handling Time", "Inbound Whse. Handling Time");
                    FieldNo(Status):
                        TransLine.Validate(Status, Status);
                end;
                TransLine.Modify(true);
            until TransLine.Next = 0;
        end;
    end;

    [Scope('Internal')]
    procedure DeleteOneTransferOrder(var TransHeader2: Record "Transfer Header"; var TransLine2: Record "Transfer Line"): Boolean
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        WhseRequest: Record "Warehouse Request";
        InvtCommentLine: Record "Inventory Comment Line";
        No: Code[20];
        DoNotDelete: Boolean;
    begin
        No := TransHeader2."No.";
        if TransLine2.Find('-') then
            repeat
                if (TransLine2.Quantity <> TransLine2."Quantity Shipped") or
                   (TransLine2.Quantity <> TransLine2."Quantity Received") or
                   (TransLine2."Quantity (Base)" <> TransLine2."Qty. Shipped (Base)") or
                   (TransLine2."Quantity (Base)" <> TransLine2."Qty. Received (Base)") or
                   (TransLine2."Quantity Shipped" <> TransLine2."Quantity Received") or
                   (TransLine2."Qty. Shipped (Base)" <> TransLine2."Qty. Received (Base)")
                then
                    DoNotDelete := true;
            until TransLine2.Next = 0;

        if not DoNotDelete then begin
            WhseRequest.SetRange("Source Type", DATABASE::"Transfer Line");
            WhseRequest.SetRange("Source No.", No);
            if not WhseRequest.IsEmpty then
                WhseRequest.DeleteAll(true);

            InvtCommentLine.SetRange("Document Type", InvtCommentLine."Document Type"::"Transfer Order");
            InvtCommentLine.SetRange("No.", No);
            InvtCommentLine.DeleteAll;

            ItemChargeAssgntPurch.SetCurrentKey(
              "Applies-to Doc. Type", "Applies-to Doc. No.", "Applies-to Doc. Line No.");
            ItemChargeAssgntPurch.SetRange("Applies-to Doc. Type", ItemChargeAssgntPurch."Applies-to Doc. Type"::"Transfer Receipt");
            ItemChargeAssgntPurch.SetRange("Applies-to Doc. No.", TransLine2."Document No.");
            ItemChargeAssgntPurch.DeleteAll;

            if TransLine2.Find('-') then
                TransLine2.DeleteAll;

            TransHeader2.Delete;
            if not HideValidationDialog then
                Message(Text003, No);
            exit(true);
        end;
        exit(false);
    end;

    local procedure TestStatusOpen()
    begin
        if not CalledFromWhse then
            TestField(Status, Status::Open);
    end;

    [Scope('Internal')]
    procedure CalledFromWarehouse(CalledFromWhse2: Boolean)
    begin
        CalledFromWhse := CalledFromWhse2;
    end;

    [Scope('Internal')]
    procedure CreateInvtPutAwayPick()
    var
        WhseRequest: Record "Warehouse Request";
    begin
        TestField(Status, Status::Released);

        WhseRequest.Reset;
        WhseRequest.SetCurrentKey("Source Document", "Source No.");
        WhseRequest.SetFilter(
          "Source Document", '%1|%2',
          WhseRequest."Source Document"::"Inbound Transfer",
          WhseRequest."Source Document"::"Outbound Transfer");
        WhseRequest.SetRange("Source No.", "No.");
        REPORT.RunModal(REPORT::"Create Invt Put-away/Pick/Mvmt", true, false, WhseRequest);
    end;

    [Scope('Internal')]
    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", StrSubstNo('%1 %2', TableCaption, "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify;
            if TransferLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure TransferLinesExist(): Boolean
    begin
        TransLine.Reset;
        TransLine.SetRange("Document No.", "No.");
        exit(TransLine.FindFirst);
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
        ShippedLineDimChangeConfirmed: Boolean;
    begin
        // Update all lines with changed dimensions.

        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not Confirm(Text007) then
            exit;

        TransLine.Reset;
        TransLine.SetRange("Document No.", "No.");
        TransLine.LockTable;
        if TransLine.Find('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(TransLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if TransLine."Dimension Set ID" <> NewDimSetID then begin
                    TransLine."Dimension Set ID" := NewDimSetID;

                    VerifyShippedLineDimChange(ShippedLineDimChangeConfirmed);

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      TransLine."Dimension Set ID", TransLine."Shortcut Dimension 1 Code", TransLine."Shortcut Dimension 2 Code");
                    TransLine.Modify;
                end;
            until TransLine.Next = 0;
    end;

    local procedure VerifyShippedLineDimChange(var ShippedLineDimChangeConfirmed: Boolean)
    begin
        if TransLine.IsShippedDimChanged then
            if not ShippedLineDimChangeConfirmed then
                ShippedLineDimChangeConfirmed := TransLine.ConfirmShippedDimChange;
    end;

    [Scope('Internal')]
    procedure CheckBeforePost()
    begin
        TestField("Transfer-from Code");
        TestField("Transfer-to Code");
        if "Transfer-from Code" = "Transfer-to Code" then
            Error(
              Text001,
              FieldCaption("Transfer-from Code"), FieldCaption("Transfer-to Code"),
              TableCaption, "No.");
        TestField("In-Transit Code");
        TestField(Status, Status::Released);
        TestField("Posting Date");
    end;

    [Scope('Internal')]
    procedure CheckInvtPostingSetup()
    var
        InventoryPostingSetup: Record "Inventory Posting Setup";
    begin
        InventoryPostingSetup.SetRange("Location Code", "Transfer-from Code");
        InventoryPostingSetup.FindFirst;
        InventoryPostingSetup.SetRange("Location Code", "Transfer-to Code");
        InventoryPostingSetup.FindFirst;
    end;
}

