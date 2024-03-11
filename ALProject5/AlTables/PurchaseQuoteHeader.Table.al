table 50603 "Purchase Quote Header"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin

                if "No." <> xRec."No." then begin
                    PurchSetup.Get;
                    NoSeriesMgt.TestManual(PurchSetup."Quotation Request No");
                    "No. Series" := '';
                end;
            end;
        }
        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = ToBeClassified;
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE ("Use As In-Transit" = CONST (false));

            trigger OnValidate()
            begin
                if "Ship-to Code" <> '' then begin
                    location.Get("Ship-to Code");
                    "Location Code" := "Ship-to Code";
                    "Ship-to Name" := location.Name;
                    "Ship-to Name 2" := location."Name 2";
                    "Ship-to Address" := location.Address;
                    "Ship-to Address 2" := location."Address 2";
                    "Ship-to City" := location.City;
                    "Ship-to Contact" := location.Contact;
                end
            end;
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
            DataClassification = ToBeClassified;
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
            DataClassification = ToBeClassified;
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
            DataClassification = ToBeClassified;
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = ToBeClassified;
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = ToBeClassified;
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            DataClassification = ToBeClassified;
        }
        field(19; "Expected Opening Date"; Date)
        {
            Caption = 'Expected Opening Date';
            DataClassification = ToBeClassified;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(21; "Expected Closing Date"; Date)
        {
            Caption = 'Expected Closing Date';
            DataClassification = ToBeClassified;
        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
            DataClassification = ToBeClassified;
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = ToBeClassified;
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
            DataClassification = ToBeClassified;
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = "Shipment Method";
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE ("Use As In-Transit" = CONST (false));
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(31; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PurchLine: Record "Purchase Line";
                Currency: Record Currency;
                RecalculatePrice: Boolean;
            begin
            end;
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            DataClassification = ToBeClassified;
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }
        field(43; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
            DataClassification = ToBeClassified;
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist ("Purch. Comment Line" WHERE ("Document Type" = FIELD ("Document Type"),
                                                             "No." = FIELD ("No."),
                                                             "Document Line No." = CONST (0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
            DataClassification = ToBeClassified;
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = ToBeClassified;
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Bal. Account Type" = CONST ("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST ("Bank Account")) "Bank Account";
        }
        field(57; Receive; Boolean)
        {
            Caption = 'Receive';
            DataClassification = ToBeClassified;
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
            DataClassification = ToBeClassified;
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum ("Purchase Line".Amount WHERE ("Document Type" = FIELD ("Document Type"),
                                                            "Document No." = FIELD ("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum ("Purchase Line"."Amount Including VAT" WHERE ("Document Type" = FIELD ("Document Type"),
                                                                            "Document No." = FIELD ("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
            DataClassification = ToBeClassified;
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = ToBeClassified;
        }
        field(64; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Type";
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            DataClassification = ToBeClassified;
            TableRelation = "Transport Method";
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
            DataClassification = ToBeClassified;
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(95; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PayToVend: Record Vendor;
            begin
            end;
        }
        field(97; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            DataClassification = ToBeClassified;
            TableRelation = "Entry/Exit Point";
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = ToBeClassified;
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            DataClassification = ToBeClassified;
            TableRelation = Area;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Specification";
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(109; "Receiving No. Series"; Code[10])
        {
            Caption = 'Receiving No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            DataClassification = ToBeClassified;
            TableRelation = "Tax Area";
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = ToBeClassified;
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }
        field(118; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
            end;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                ChangeLogMgt: Codeunit "Change Log Management";
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
            end;
        }
        field(120; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Closed,Cancelled,Stopped;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';
            DataClassification = ToBeClassified;
        }
        field(124; "IC Status"; Option)
        {
            Caption = 'IC Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(125; "Buy-from IC Partner Code"; Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126; "Pay-to IC Partner Code"; Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(129; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            DataClassification = ToBeClassified;
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(151; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            CalcFormula = Max ("Purchase Header Archive"."Version No." WHERE ("Document Type" = FIELD ("Document Type"),
                                                                             "No." = FIELD ("No."),
                                                                             "Doc. No. Occurrence" = FIELD ("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            DataClassification = ToBeClassified;
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = ToBeClassified;
            TableRelation = Campaign;
        }
        field(5052; "Buy-from Contact No."; Code[20])
        {
            Caption = 'Buy-from Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5053; "Pay-to Contact No."; Code[20])
        {
            Caption = 'Pay-to Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = Table56016;
        }
        field(5752; "Completely Received"; Boolean)
        {
            CalcFormula = Min ("Purchase Line"."Completely Received" WHERE ("Document Type" = FIELD ("Document Type"),
                                                                           "Document No." = FIELD ("No."),
                                                                           Type = FILTER (<> " "),
                                                                           "Location Code" = FIELD ("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
            DataClassification = ToBeClassified;
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
            DataClassification = ToBeClassified;
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
            DataClassification = ToBeClassified;
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            DataClassification = ToBeClassified;
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
            DataClassification = ToBeClassified;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5801; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
            DataClassification = ToBeClassified;
        }
        field(5802; "Return Shipment No. Series"; Code[10])
        {
            Caption = 'Return Shipment No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(5803; Ship; Boolean)
        {
            Caption = 'Ship';
            DataClassification = ToBeClassified;
        }
        field(5804; "Last Return Shipment No."; Code[20])
        {
            Caption = 'Last Return Shipment No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Return Shipment Header";
        }
        field(9000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(54240; Copied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54241; "Debit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54243; "PRF No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE ("Document Type" = CONST (Quote),
                                                           Status = FILTER (Released));

            trigger OnLookup()
            begin
                PurchHeader.Reset;
                PurchHeader.SetRange(PurchHeader."Document Type", PurchHeader."Document Type"::Quote);
                PurchHeader.SetRange(PurchHeader.DocApprovalType, PurchHeader.DocApprovalType::Requisition);
                PurchHeader.SetRange(PurchHeader.Status, PurchHeader.Status::Released);
                if PAGE.RunModal(53, PurchHeader) = ACTION::LookupOK then begin
                    "PRF No" := PurchHeader."No.";
                    Validate("PRF No");
                end;
            end;

            trigger OnValidate()
            begin
                AutoPopPurchLine;
            end;
        }
        field(54244; "Released By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54245; "Release Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55536; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55537; "Cancelled By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55538; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55539; DocApprovalType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(55540; "Procurement Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Table55511;
        }
        field(99008500; "Date Received"; Date)
        {
            Caption = 'Date Received';
            DataClassification = ToBeClassified;
        }
        field(99008501; "Time Received"; Time)
        {
            Caption = 'Time Received';
            DataClassification = ToBeClassified;
        }
        field(99008504; "BizTalk Purchase Quote"; Boolean)
        {
            Caption = 'BizTalk Purchase Quote';
            DataClassification = ToBeClassified;
        }
        field(99008505; "BizTalk Purch. Order Cnfmn."; Boolean)
        {
            Caption = 'BizTalk Purch. Order Cnfmn.';
            DataClassification = ToBeClassified;
        }
        field(99008506; "BizTalk Purchase Invoice"; Boolean)
        {
            Caption = 'BizTalk Purchase Invoice';
            DataClassification = ToBeClassified;
        }
        field(99008507; "BizTalk Purchase Receipt"; Boolean)
        {
            Caption = 'BizTalk Purchase Receipt';
            DataClassification = ToBeClassified;
        }
        field(99008508; "BizTalk Purchase Credit Memo"; Boolean)
        {
            Caption = 'BizTalk Purchase Credit Memo';
            DataClassification = ToBeClassified;
        }
        field(99008509; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
            DataClassification = ToBeClassified;
        }
        field(99008510; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
            DataClassification = ToBeClassified;
        }
        field(99008511; "BizTalk Request for Purch. Qte"; Boolean)
        {
            Caption = 'BizTalk Request for Purch. Qte';
            DataClassification = ToBeClassified;
        }
        field(99008512; "BizTalk Purchase Order"; Boolean)
        {
            Caption = 'BizTalk Purchase Order';
            DataClassification = ToBeClassified;
        }
        field(99008520; "Vendor Quote No."; Code[20])
        {
            Caption = 'Vendor Quote No.';
            DataClassification = ToBeClassified;
        }
        field(99008521; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
            DataClassification = ToBeClassified;
        }
        field(99008522; "Vendor Filter"; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = Vendor."No.";
        }
        field(99008523; "Purchase requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE (Completed = CONST (true));

            trigger OnValidate()
            begin

                PurchaseQuoteLine.Reset;
                PurchaseQuoteLine.SetRange("Document No.", "No.");
                PurchaseQuoteLine.DeleteAll;

                LineNo := 1000;
                PurchaseLine.Reset;
                PurchaseLine.SetRange("Document No.", "Purchase requisition No");
                if PurchaseLine.Find('-') then begin
                    repeat
                        PurchaseQuoteLine.Init;
                        PurchaseQuoteLine."Document Type" := PurchaseQuoteLine."Document Type"::"Quotation Request";
                        PurchaseQuoteLine."Document No." := "No.";
                        PurchaseQuoteLine."Line No." := PurchaseLine."Line No.";
                        PurchaseQuoteLine."Location Code" := 'NAIROBI';
                        PurchaseQuoteLine."Posting Group" := PurchaseLine."Posting Group";
                        PurchaseQuoteLine.Type := PurchaseLine.Type;
                        PurchaseQuoteLine."Unit of Measure" := PurchaseLine."Unit of Measure Code";
                        PurchaseQuoteLine.Validate(PurchaseQuoteLine.Type);
                        PurchaseQuoteLine.Quantity := PurchaseLine.Quantity;
                        PurchaseQuoteLine."No." := PurchaseLine."No.";
                        PurchaseQuoteLine.Validate(PurchaseQuoteLine."No.");
                        PurchaseQuoteLine.Insert;
                        // MESSAGE('Inserted Successfully');
                    until PurchaseLine.Next = 0;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Document Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Check if the number has been inserted by the user
        if "No." = '' then begin

            PurchSetup.Get;
            PurchSetup.TestField(PurchSetup."Quotation Request No");
            NoSeriesMgt.InitSeries(PurchSetup."Quotation Request No", xRec."No. Series", Today, "No.", "No. Series");
        end;

        "Posting Description" := Format("Document Type") + ' ' + "No.";
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        location: Record Location;
        PurchHeader: Record "Purchase Header";
        PParams: Record "Purchase Quote Params";
        Lines: Record "Purchase Quote Line";
        PQH: Record "Purchase Quote Header";
        Vend: Record "Quotation Request Vendors";
        Vendor: Record Vendor;
        SMTPSetup: Record "SMTP Mail Setup";
        Filename: Text;
        SMTPMail: Codeunit "SMTP Mail";
        Attachment: Text;
        PurchaseLine: Record "Purchase Line";
        PurchaseQuoteLine: Record "Purchase Quote Line";
        LineNo: Integer;

    [Scope('Internal')]
    procedure AutoPopPurchLine()
    var
        reqLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Quote Line";
        LineNo: Integer;
        delReqLine: Record "Purchase Quote Line";
    begin
        PurchLine2.SetRange("Document Type", "Document Type");
        PurchLine2.SetRange("Document No.", "No.");
        PurchLine2.DeleteAll;
        PurchLine2.Reset;

        //reqLine.SETRANGE(reqLine."Document Type","Document Type");
        reqLine.SetRange(reqLine."Document No.", "PRF No");

        if reqLine.Find('-') then begin
            PurchLine2.Init;
            repeat
                if reqLine.Quantity <> 0 then begin
                    LineNo := LineNo + 1000;
                    PurchLine2."Document Type" := "Document Type";
                    PurchLine2.Validate("Document Type");
                    PurchLine2."Document No." := "No.";
                    PurchLine2.Validate("Document No.");
                    PurchLine2."Line No." := LineNo;
                    PurchLine2.Type := reqLine.Type;
                    PurchLine2."Expense Code" := reqLine."Expense Code";    //Denno added---
                    PurchLine2."No." := reqLine."No.";
                    PurchLine2.Validate("No.");
                    PurchLine2.Description := reqLine.Description;
                    PurchLine2.Quantity := reqLine.Quantity;
                    PurchLine2.Validate(Quantity);
                    PurchLine2."Unit of Measure Code" := reqLine."Unit of Measure Code";
                    PurchLine2.Validate("Unit of Measure Code");
                    PurchLine2."Unit of Measure" := reqLine."Unit of Measure";
                    PurchLine2."Direct Unit Cost" := reqLine."Direct Unit Cost";
                    PurchLine2.Validate("Direct Unit Cost");
                    PurchLine2."Location Code" := reqLine."Location Code";
                    PurchLine2."Location Code" := "Location Code";
                    PurchLine2."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                    PurchLine2."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                    PurchLine2.Insert(true);
                end
            until reqLine.Next = 0;
        end;
    end;
}

