table 1313 "Activities Cue"
{
    Caption = 'Activities Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Due Date Filter"; Date)
        {
            Caption = 'Due Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(3; "Overdue Date Filter"; Date)
        {
            Caption = 'Overdue Date Filter';
            FieldClass = FlowFilter;
        }
        field(4; "Ongoing Sales Invoices"; Integer)
        {
            CalcFormula = Count ("Sales Header" WHERE ("Document Type" = FILTER (Invoice)));
            Caption = 'Ongoing Sales Invoices';
            FieldClass = FlowField;
        }
        field(5; "Ongoing Purchase Invoices"; Integer)
        {
            CalcFormula = Count ("Purchase Header" WHERE ("Document Type" = FILTER (Invoice)));
            Caption = 'Ongoing Purchase Invoices';
            FieldClass = FlowField;
        }
        field(6; "Sales This Month"; Decimal)
        {
            AutoFormatExpression = GetAmountFormat;
            AutoFormatType = 10;
            Caption = 'Sales This Month';
            DecimalPlaces = 0 : 0;
        }
        field(7; "Top 10 Customer Sales YTD"; Decimal)
        {
            AutoFormatExpression = '<Precision,1:1><Standard Format,9>%';
            AutoFormatType = 10;
            Caption = 'Top 10 Customer Sales YTD';
        }
        field(8; "Overdue Purch. Invoice Amount"; Decimal)
        {
            AutoFormatExpression = GetAmountFormat;
            AutoFormatType = 10;
            Caption = 'Overdue Purch. Invoice Amount';
            DecimalPlaces = 0 : 0;
        }
        field(9; "Overdue Sales Invoice Amount"; Decimal)
        {
            AutoFormatExpression = GetAmountFormat;
            AutoFormatType = 10;
            Caption = 'Overdue Sales Invoice Amount';
            DecimalPlaces = 0 : 0;
        }
        field(10; "Average Collection Days"; Decimal)
        {
            Caption = 'Average Collection Days';
            DecimalPlaces = 1 : 1;
        }
        field(11; "Ongoing Sales Quotes"; Integer)
        {
            CalcFormula = Count ("Sales Header" WHERE ("Document Type" = FILTER (Quote)));
            Caption = 'Ongoing Sales Quotes';
            FieldClass = FlowField;
        }
        field(12; "Requests to Approve"; Integer)
        {
            CalcFormula = Count ("Approval Entry" WHERE ("Approver ID" = FIELD ("User ID Filter"),
                                                        Status = FILTER (Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(13; "Sales Inv. - Pending Doc.Exch."; Integer)
        {
            CalcFormula = Count ("Sales Invoice Header" WHERE ("Document Exchange Status" = FILTER ("Sent to Document Exchange Service" | "Delivery Failed")));
            Caption = 'Sales Invoices - Pending Document Exchange';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Sales CrM. - Pending Doc.Exch."; Integer)
        {
            CalcFormula = Count ("Sales Cr.Memo Header" WHERE ("Document Exchange Status" = FILTER ("Sent to Document Exchange Service" | "Delivery Failed")));
            Caption = 'Sales Credit Memos - Pending Document Exchange';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(17; "Due Next Week Filter"; Date)
        {
            Caption = 'Due Next Week Filter';
            FieldClass = FlowFilter;
        }
        field(20; "My Incoming Documents"; Integer)
        {
            CalcFormula = Count ("Incoming Document" WHERE (Processed = CONST (false)));
            Caption = 'My Incoming Documents';
            FieldClass = FlowField;
        }
        field(21; "Non-Applied Payments"; Integer)
        {
            CalcFormula = Count ("Bank Acc. Reconciliation" WHERE ("Statement Type" = CONST ("Payment Application")));
            Caption = 'Non-Applied Payments';
            FieldClass = FlowField;
        }
        field(22; "Purch. Invoices Due Next Week"; Integer)
        {
            CalcFormula = Count ("Vendor Ledger Entry" WHERE ("Document Type" = FILTER (Invoice | "Credit Memo"),
                                                             "Due Date" = FIELD ("Due Next Week Filter"),
                                                             Open = CONST (true)));
            Caption = 'Purch. Invoices Due Next Week';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Sales Invoices Due Next Week"; Integer)
        {
            CalcFormula = Count ("Cust. Ledger Entry" WHERE ("Document Type" = FILTER (Invoice | "Credit Memo"),
                                                            "Due Date" = FIELD ("Due Next Week Filter"),
                                                            Open = CONST (true)));
            Caption = 'Sales Invoices Due Next Week';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Ongoing Sales Orders"; Integer)
        {
            CalcFormula = Count ("Sales Header" WHERE ("Document Type" = FILTER (Order)));
            Caption = 'Ongoing Sales Orders';
            FieldClass = FlowField;
        }
        field(25; "Inc. Doc. Awaiting Verfication"; Integer)
        {
            CalcFormula = Count ("Incoming Document" WHERE ("OCR Status" = CONST ("Awaiting Verification")));
            Caption = 'Inc. Doc. Awaiting Verfication';
            FieldClass = FlowField;
        }
        field(26; "Purchase Orders"; Integer)
        {
            CalcFormula = Count ("Purchase Header" WHERE ("Document Type" = FILTER (Order)));
            Caption = 'Purchase Orders';
            FieldClass = FlowField;
        }
        field(27; "Uninvoiced Bookings"; Integer)
        {
            Caption = 'Uninvoiced Bookings';
            Editable = false;
        }
        field(28; "IC Inbox Transactions"; Integer)
        {
            CalcFormula = Count ("IC Inbox Transaction");
            Caption = 'IC Inbox Transactions';
            FieldClass = FlowField;
        }
        field(29; "IC Outbox Transactions"; Integer)
        {
            CalcFormula = Count ("IC Outbox Transaction");
            Caption = 'IC Outbox Transactions';
            FieldClass = FlowField;
        }
        field(31; "Outstanding Vendor Invoices"; Integer)
        {
            CalcFormula = Count ("Vendor Ledger Entry" WHERE ("Document Type" = FILTER (Invoice),
                                                             Open = CONST (true)));
            Caption = 'Outstanding Vendor Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Coupled Data Synch Errors"; Integer)
        {
            CalcFormula = Count ("CRM Integration Record" WHERE (Skipped = CONST (true)));
            Caption = 'Coupled Data Synch Errors';
            FieldClass = FlowField;
        }
        field(33; "CDS Integration Errors"; Integer)
        {
            CalcFormula = Count ("Integration Synch. Job Errors");
            Caption = 'CDS Integration Errors';
            FieldClass = FlowField;
        }
        field(110; "Last Date/Time Modified"; DateTime)
        {
            Caption = 'Last Date/Time Modified';
        }
        field(111; "Approved Leave Application"; Integer)
        {
            CalcFormula = Count ("Hr Leave Application" WHERE (Status = FILTER (Approved)));
            FieldClass = FlowField;
        }
        field(112; "Active Employees"; Integer)
        {
            CalcFormula = Count (pr_employees WHERE (status = FILTER (active)));
            FieldClass = FlowField;
        }
        field(113; "Pending Leave Application"; Integer)
        {
            CalcFormula = Count ("Hr Leave Application" WHERE (Status = FILTER ("Pending Approval")));
            FieldClass = FlowField;
        }
        field(114; "Male Employees"; Integer)
        {
            CalcFormula = Count (pr_employees WHERE (status = FILTER (active),
                                                    Gender = FILTER (MALE)));
            FieldClass = FlowField;
        }
        field(115; "Female Employees"; Integer)
        {
            CalcFormula = Count (pr_employees WHERE (status = FILTER (active),
                                                    Gender = FILTER (FEMALE)));
            FieldClass = FlowField;
        }
        field(116; "InActive Employees"; Integer)
        {
            CalcFormula = Count (pr_employees WHERE (status = FILTER (<> active)));
            FieldClass = FlowField;
        }
        field(117; Items; Decimal)
        {
            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE (Quantity = FILTER (<> 0)));
            FieldClass = FlowField;
        }
        field(118; "Used Items"; Decimal)
        {
            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE ("Variant Code" = FILTER ('USED'),
                                                                  Quantity = FILTER (<> 0)));
            FieldClass = FlowField;
        }
        field(119; "New Items"; Decimal)
        {
            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE ("Variant Code" = CONST ('NEW'),
                                                                  Quantity = FILTER (<> 0)));
            FieldClass = FlowField;
        }
        field(120; "Major Item 1"; Decimal)
        {
            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE ("Item No." = CONST ('ITEM-006'),
                                                                  Quantity = FILTER (<> 0)));
            FieldClass = FlowField;
        }
        field(121; "Major Item 2"; Decimal)
        {
            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE ("Item No." = CONST ('ITEM-012'),
                                                                  Quantity = FILTER (<> 0)));
            FieldClass = FlowField;
        }
        field(122; "Items instal today"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(123; "Purchase order open"; Integer)
        {
            CalcFormula = Count ("Purchase Header" WHERE (Status = FILTER (Open)));
            FieldClass = FlowField;
        }
        field(124; "Purchase order pending"; Integer)
        {
            CalcFormula = Count ("Purchase Header" WHERE (Status = FILTER ("Pending Approval")));
            FieldClass = FlowField;
        }
        field(125; "Approved purchase order"; Integer)
        {
            CalcFormula = Count ("Purchase Header" WHERE (Status = FILTER (Released)));
            FieldClass = FlowField;
        }
        field(126; "Open transfer order"; Integer)
        {
            CalcFormula = Count ("Transfer Header" WHERE (Status = FILTER (Open)));
            FieldClass = FlowField;
        }
        field(127; "Pending transfer order"; Integer)
        {
            CalcFormula = Count ("Transfer Header" WHERE (Status = FILTER ("Pending Approval")));
            FieldClass = FlowField;
        }
        field(128; "Approved transfer prder"; Integer)
        {
            CalcFormula = Count ("Transfer Header" WHERE (Status = FILTER (Approved)));
            FieldClass = FlowField;
        }
        field(129; "Posted transfer shipment"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Posted transfer Receipts"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure GetAmountFormat(): Text
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserPersonalization: Record "User Personalization";
        CurrencySymbol: Text[10];
    begin
        GeneralLedgerSetup.Get;
        CurrencySymbol := GeneralLedgerSetup.GetCurrencySymbol;

        if UserPersonalization.Get(UserSecurityId) and (CurrencySymbol <> '') then
            case UserPersonalization."Locale ID" of
                1030, // da-DK
              1053, // sv-Se
              1044: // no-no
                    exit('<Precision,0:0><Standard Format,0>' + CurrencySymbol);
                2057, // en-gb
              1033, // en-us
              4108, // fr-ch
              1031, // de-de
              2055, // de-ch
              1040, // it-it
              2064, // it-ch
              1043, // nl-nl
              2067, // nl-be
              2060, // fr-be
              3079, // de-at
              1035, // fi
              1034: // es-es
                    exit(CurrencySymbol + '<Precision,0:0><Standard Format,0>');
            end;

        exit(GetDefaultAmountFormat);
    end;

    local procedure GetDefaultAmountFormat(): Text
    begin
        exit('<Precision,0:0><Standard Format,0>');
    end;
}

