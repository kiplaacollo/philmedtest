table 50125 "BO Applications"
{
    DataClassification = ToBeClassified;
    LookupPageId = "BO Applications List";
    DrillDownPageId = "BO Applications List";

    fields
    {
        // Customer Table Fields
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(3; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        // field(5; Address; Text[100])
        // {
        //     Caption = 'Address';
        // }
        field(5; "Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Communication Information';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8; Contact; Text[100])
        {
            Caption = 'Contact';

        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(11; "Document Sending Profile"; Code[20])
        {
            Caption = 'Document Sending Profile';
            TableRelation = "Document Sending Profile".Code;
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("No."));
        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));


        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));


        }
        field(18; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name';
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(20; "Credit Limit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Credit Limit (LCY)';
        }
        field(21; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

        }
        field(23; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(25; "Registration Number"; Text[50])
        {
            Caption = 'Registration No.';

        }
        field(26; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";

        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            TableRelation = "Finance Charge Terms";
        }
        field(29; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));


        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";


        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";


        }
        field(32; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export';
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = Customer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(34; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";


        }
        field(36; "Collection Method"; Code[20])
        {
            Caption = 'Collection Method';
        }
        field(37; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Customer),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Enum "Customer Blocked")
        {
            Caption = 'Blocked';


        }
        field(40; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies';
        }

        field(41; "Last Statement No."; Integer)
        {
            Caption = 'Last Statement No.';
        }
        field(42; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements';
        }
        field(45; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(46; Priority; Integer)
        {
            Caption = 'Priority';
        }
        field(47; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

        }
        field(53; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        // field(55; "Date Filter"; Date)
        // {
        //     Caption = 'Date Filter';
        //     FieldClass = FlowFilter;
        // }
        field(55; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Description = 'Start of Filters';
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(58; Balance; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Cust. Ledger Entry"."Sales (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Sales (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Cust. Ledger Entry"."Profit (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                         "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                         "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Profit (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Inv. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Cust. Ledger Entry"."Inv. Discount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Posting Date" = FIELD("Date Filter"),
                                                                                "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Inv. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Pmt. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER("Payment Discount" .. "Payment Discount (VAT Adjustment)"),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                         "Initial Entry Due Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Due Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; Payments; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Payment),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Customer No." = FIELD("No."),
                                                                          "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Payments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "Invoice Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Invoice),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Invoice Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Cr. Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Credit Memo"),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Customer No." = FIELD("No."),
                                                                          "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Cr. Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Finance Charge Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Finance Charge Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74; "Payments (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Payment),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Customer No." = FIELD("No."),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Payments (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(75; "Inv. Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Invoice),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Inv. Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Cr. Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Credit Memo"),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Customer No." = FIELD("No."),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Cr. Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Fin. Charge Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Fin. Charge Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78; "Outstanding Orders"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = CONST(Order),
                                                                       "Bill-to Customer No." = FIELD("No."),
                                                                       "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                       "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Shipped Not Invoiced"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Shipped Not Invoiced" WHERE("Document Type" = CONST(Order),
                                                                         "Bill-to Customer No." = FIELD("No."),
                                                                         "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                         "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Shipped Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Application Method"; Enum "Application Method")
        {
            Caption = 'Application Method';
        }
        field(82; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
        }
        field(83; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';


        }
        field(87; "Combine Shipments"; Boolean)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Combine Shipments';
        }
        field(88; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(89; Picture; BLOB)
        {
            Caption = 'Picture';
            ObsoleteReason = 'Replaced by Image field';
            ObsoleteState = Removed;
            SubType = Bitmap;
            ObsoleteTag = '19.0';
        }
        field(90; GLN; Code[13])
        {
            Caption = 'GLN';
            Numeric = true;

        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        // field(92; County; Text[30])
        // {
        //     CaptionClass = '5,1,' + "Country/Region Code";
        //     Caption = 'County';
        // }
        field(50031; County; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "BO County".Code;
        }
        field(93; "EORI Number"; Text[40])
        {
            Caption = 'EORI Number';
        }
        field(95; "Use GLN in Electronic Document"; Boolean)
        {
            Caption = 'Use GLN in Electronic Documents';
        }
        field(97; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Debit Amount" WHERE("Customer No." = FIELD("No."),
                                                                                 "Entry Type" = FILTER(<> Application),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Credit Amount" WHERE("Customer No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER(<> Application),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                       "Entry Type" = FILTER(<> Application),
                                                                                       "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                       "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                       "Posting Date" = FIELD("Date Filter"),
                                                                                       "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Credit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                        "Entry Type" = FILTER(<> Application),
                                                                                        "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                        "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                                        "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(104; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            TableRelation = "Reminder Terms";
        }
        field(105; "Reminder Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Reminder),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Reminder Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(106; "Reminder Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Reminder),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Reminder Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(110; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(111; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Order),
                                                                             "Bill-to Customer No." = FIELD("No."),
                                                                             "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(114; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Shipped Not Invoiced (LCY)" WHERE("Document Type" = CONST(Order),
                                                                               "Bill-to Customer No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Shipped Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(115; Reserve; Enum "Reserve Method")
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Reserve';
            InitValue = Optional;
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER("Payment Discount Tolerance" | "Payment Discount Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Disc. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(118; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER("Payment Tolerance" | "Payment Tolerance (VAT Adjustment)" | "Payment Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(119; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(120; Refunds; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Refund),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Refunds';
            FieldClass = FlowField;
        }
        field(121; "Refunds (LCY)"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Refund),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Refunds (LCY)';
            FieldClass = FlowField;
        }
        field(122; "Other Amounts"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(" "),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Other Amounts';
            FieldClass = FlowField;
        }
        field(123; "Other Amounts (LCY)"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(" "),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Other Amounts (LCY)';
            FieldClass = FlowField;
        }
        field(124; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(125; "Outstanding Invoices (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Invoice),
                                                                             "Bill-to Customer No." = FIELD("No."),
                                                                             "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Invoices (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(126; "Outstanding Invoices"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = CONST(Invoice),
                                                                       "Bill-to Customer No." = FIELD("No."),
                                                                       "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                       "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Bill-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = Count("Sales Header Archive" WHERE("Document Type" = CONST(Order),
                                                              "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(131; "Sell-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = Count("Sales Header Archive" WHERE("Document Type" = CONST(Order),
                                                              "Sell-to Customer No." = FIELD("No.")));
            Caption = 'Sell-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(132; "Partner Type"; Enum "Partner Type")
        {
            Caption = 'Partner Type';
        }
        field(133; "Intrastat Partner Type"; Enum "Partner Type")
        {
            Caption = 'Intrastat Partner Type';
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(150; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';

            trigger OnValidate()
            begin
                if "Privacy Blocked" then
                    Blocked := Blocked::All
                else
                    Blocked := Blocked::" ";
            end;
        }
        field(160; "Disable Search by Name"; Boolean)
        {
            Caption = 'Disable Search by Name';
            DataClassification = SystemMetadata;
        }
        field(175; "Allow Multiple Posting Groups"; Boolean)
        {
            Caption = 'Allow Multiple Posting Groups';
            DataClassification = SystemMetadata;
        }
        field(288; "Preferred Bank Account Code"; Code[20])
        {
            Caption = 'Preferred Bank Account Code';
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("No."));
        }
        field(720; "Coupled to CRM"; Boolean)
        {
            Caption = 'Coupled to Dataverse';
            Editable = false;
            ObsoleteReason = 'Replaced by flow field Coupled to Dataverse';
#if not CLEAN23
            ObsoleteState = Pending;
            ObsoleteTag = '23.0';
#else
            ObsoleteState = Removed;
            ObsoleteTag = '26.0';
#endif
        }
        field(721; "Coupled to Dataverse"; Boolean)
        {
            FieldClass = FlowField;
            Caption = 'Coupled to Dataverse';
            Editable = false;
            CalcFormula = exist("CRM Integration Record" where("Integration ID" = field(SystemId), "Table ID" = const(Database::Customer)));
        }
        field(840; "Cash Flow Payment Terms Code"; Code[10])
        {
            Caption = 'Cash Flow Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(5049; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            TableRelation = Contact;

        }
        field(5050; "Contact Type"; Enum "Contact Type")
        {
            Caption = 'Contact Type';
        }
        field(5061; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;

        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5750; "Shipping Advice"; Enum "Sales Header Shipping Advice")
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Shipping Advice';
        }
        field(5790; "Shipping Time"; DateFormula)
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Time';
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));

        }
        field(5900; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            TableRelation = "Service Zone";
        }
        field(5902; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Contract Gain/Loss Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                       "Ship-to Code" = FIELD("Ship-to Filter"),
                                                                       "Change Date" = FIELD("Date Filter")));
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5903; "Ship-to Filter"; Code[10])
        {
            Caption = 'Ship-to Filter';
            FieldClass = FlowFilter;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("No."));
        }
        field(5910; "Outstanding Serv. Orders (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Service Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Order),
                                                                               "Bill-to Customer No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Serv. Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5911; "Serv Shipped Not Invoiced(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Service Line"."Shipped Not Invoiced (LCY)" WHERE("Document Type" = CONST(Order),
                                                                                 "Bill-to Customer No." = FIELD("No."),
                                                                                 "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Serv Shipped Not Invoiced(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5912; "Outstanding Serv.Invoices(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Service Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Invoice),
                                                                               "Bill-to Customer No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Serv.Invoices(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';

            trigger OnValidate()
            var
                PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
                PriceType: Enum "Price Type";
            begin
                if "Price Calculation Method" <> "Price Calculation Method"::" " then
                    PriceCalculationMgt.VerifyMethodImplemented("Price Calculation Method", PriceType::Sale);
            end;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7171; "No. of Quotes"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Quote),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7172; "No. of Blanket Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Blanket Order"),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7173; "No. of Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7174; "No. of Invoices"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Invoice),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7175; "No. of Return Orders"; Integer)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Return Order"),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7176; "No. of Credit Memos"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Credit Memo"),
                                                      "Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7177; "No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = Count("Sales Shipment Header" WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7178; "No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = Count("Sales Invoice Header" WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7179; "No. of Pstd. Return Receipts"; Integer)
        {
            CalcFormula = Count("Return Receipt Header" WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Pstd. Return Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7180; "No. of Pstd. Credit Memos"; Integer)
        {
            CalcFormula = Count("Sales Cr.Memo Header" WHERE("Sell-to Customer No." = FIELD("No.")));
            Caption = 'No. of Pstd. Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7181; "No. of Ship-to Addresses"; Integer)
        {
            CalcFormula = Count("Ship-to Address" WHERE("Customer No." = FIELD("No.")));
            Caption = 'No. of Ship-to Addresses';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7182; "Bill-To No. of Quotes"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Quote),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7183; "Bill-To No. of Blanket Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Blanket Order"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7184; "Bill-To No. of Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7185; "Bill-To No. of Invoices"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Invoice),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7186; "Bill-To No. of Return Orders"; Integer)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Return Order"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7187; "Bill-To No. of Credit Memos"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST("Credit Memo"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7188; "Bill-To No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = Count("Sales Shipment Header" WHERE("Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7189; "Bill-To No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = Count("Sales Invoice Header" WHERE("Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7190; "Bill-To No. of Pstd. Return R."; Integer)
        {
            CalcFormula = Count("Return Receipt Header" WHERE("Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Pstd. Return R.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7191; "Bill-To No. of Pstd. Cr. Memos"; Integer)
        {
            CalcFormula = Count("Sales Cr.Memo Header" WHERE("Bill-to Customer No." = FIELD("No.")));
            Caption = 'Bill-To No. of Pstd. Cr. Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(7601; "Copy Sell-to Addr. to Qte From"; Enum "Contact Type")
        {
            AccessByPermission = TableData Contact = R;
            Caption = 'Copy Sell-to Addr. to Qte From';
        }
        field(7602; "Validate EU Vat Reg. No."; Boolean)
        {
            Caption = 'Validate EU VAT Reg. No.';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
            ObsoleteState = Removed;
            ObsoleteReason = 'This functionality will be replaced by the systemID field';
            ObsoleteTag = '22.0';
        }
        field(8001; "Currency Id"; Guid)
        {
            Caption = 'Currency Id';
            TableRelation = Currency.SystemId;

        }
        field(8002; "Payment Terms Id"; Guid)
        {
            Caption = 'Payment Terms Id';
            TableRelation = "Payment Terms".SystemId;

        }
        field(8003; "Shipment Method Id"; Guid)
        {
            Caption = 'Shipment Method Id';
            TableRelation = "Shipment Method".SystemId;

        }
        field(8004; "Payment Method Id"; Guid)
        {
            Caption = 'Payment Method Id';
            TableRelation = "Payment Method".SystemId;

        }
        field(9003; "Tax Area ID"; Guid)
        {
            Caption = 'Tax Area ID';

        }
        field(9004; "Tax Area Display Name"; Text[100])
        {
            CalcFormula = Lookup("Tax Area".Description WHERE(Code = FIELD("Tax Area Code")));
            Caption = 'Tax Area Display Name';
            FieldClass = FlowField;
            ObsoleteReason = 'This field is not needed and it should not be used.';
            ObsoleteState = Removed;
            ObsoleteTag = '15.0';
        }
        field(9005; "Contact ID"; Guid)
        {
            Caption = 'Contact ID';
        }
        field(9006; "Contact Graph Id"; Text[250])
        {
            Caption = 'Contact Graph Id';
        }
        // End of Customer Table Fields
        field(50000; No; code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Description = 'Start of Basic Information';

        }
        field(50001; "First Name"; Text[100])
        {
            DataClassification = CustomerContent;
            NotBlank = true;


        }
        field(50002; "Middle Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50004; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            ;
        }
        field(50007; "KRA Pin"; Code[20])
        {
            DataClassification = ToBeClassified;


        }
        field(50008; "Member Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = A,B;
            OptionCaption = 'A,B';
        }
        field(50009; "Registry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,ReEntrance;
            OptionCaption = 'New,ReEntrance';
        }
        field(50010; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            ;
        }
        field(50011; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50012; "Member Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Customer Posting Group".Code;

        }
        field(50013; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
            editable = false;
            trigger OnValidate()
            begin
                if "Approval Status" = "Approval Status"::Approved then begin
                    "Date Approved" := Today;
                end;
            end;
        }
        field(50014; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
            // Editable = false;
            trigger OnValidate()
            var
                customeraccounts: Record Customer;
            begin
                if Processed then begin

                    customeraccounts.TransferFields(Rec, true);
                    customeraccounts.Insert(true);
                end;
            end;
        }
        field(50015; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; "Date Processed"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50017; "Member Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; "Monthly Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Activity Code"; Code[20])

        {
            DataClassification = ToBeClassified;

            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

        }
        field(50021; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50022; "Membership Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Application,Active,Dormant,Withdrawal,Inactive;
            OptionCaption = 'Application,Active,Dormant,Withdrawal,Inactive';
        }
        field(50023; "FO No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Front office Information';
        }
        field(50024; "BO No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Member Posting Group" = const('BO'));
            trigger OnValidate()

            begin

                BOAccounts.Reset();
                BOAccounts.SetRange("No.", "BO No");
                if BOAccounts.FindFirst then begin
                    // Basic Information
                    // No := BOAccounts.No;
                    "First Name" := BOAccounts."First Name";
                    "Middle Name" := BOAccounts."Middle Name";
                    "Last Name" := BOAccounts."Last Name";
                    Validate("Last Name");
                    "Full Name" := BOAccounts."Full Name";
                    "Account Name" := BOAccounts."Account Name";
                    "ID Number" := BOAccounts."ID Number";
                    "KRA Pin" := BOAccounts."KRA Pin";
                    "Application Date" := Today;
                    "Member Posting Group" := 'FO';
                    "Activity Code" := 'FOSA';
                    // Communication Information    
                    County := BOAccounts.County;
                    "Mobile Number" := BOAccounts."Mobile Number";
                    "Workplace Extension" := BOAccounts."Workplace Extension";
                    "Email Address" := BOAccounts."Email Address";
                    District := BOAccounts.District;
                    Location := BOAccounts.Location;
                    "Sub-Location" := BOAccounts."Sub-Location";
                    "Contact Person" := BOAccounts."Contact Person";
                    "Contact Person Phone" := BOAccounts."Contact Person Phone";
                    "Contact Person Designation" := BOAccounts."Contact Person Designation";
                    // Personal Information
                    "Date of Birth" := BOAccounts."Date of Birth";
                    Validate("Date of Birth");
                    Gender := BOAccounts.Gender;
                    "Marital Status" := BOAccounts."Marital Status";
                    Disabled := BOAccounts.Disabled;
                    // Employment Information
                    "Employer Code" := BOAccounts."Employer Code";
                    Validate("Employer Code");
                    "Department Code" := BOAccounts."Department Code";
                    Validate("Department Code");
                    Occupation := BOAccounts.Occupation;
                    "Terms of Employment" := BOAccounts."Terms of Employment";
                    "Payroll Number" := BOAccounts."Payroll Number";
                    // Bank Details
                    "Bank Code" := BOAccounts."Bank Code";
                    "Branch Code" := BOAccounts."Branch Code";
                    "Bank Account No." := BOAccounts."Bank Account No.";
                    "Swift Code" := BOAccounts."Swift Code";
                    // Referee Details
                    "Referee Name" := BOAccounts."Referee Name";
                    "Referee Mobile Phone No" := BOAccounts."Referee Mobile Phone No";
                    "Referee ID No" := BOAccounts."Referee ID No";








                end;
            end;
        }
        field(50025; "FO Account Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Products Setup";
        }
        field(50026; "FO Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Joint,Group,Corporate;
            OptionCaption = 'Single,Joint,Group,Corporate';
        }
        field(50027; "Is Current Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Current Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Is Employed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'End of Basic Information';
        }
        // field(50030; "Address"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'Start of Communication Information';
        // }
        // field(50031; County; Code[50])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "BO County".Code;
        // }

        field(50032; "Mobile Number"; Code[12])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Secondary Mobile Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Workplace Extension"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; Location; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Sub-Location"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; District; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Contact Person"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50039; "Contact Person Phone"; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF StrLen("Contact Person Phone") <> 12 then
                    Error('Contact Person phone No. Can not be more or less than 12 Characters');
            end;
        }
        field(50040; "Contact Person Designation"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'End of Communication Information';
        }
        field(50042; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Personal Information';
            trigger OnValidate()
            var
                ObjGeneralSetup: Record "BO General Setup";
            begin
                Age := CDates.GetAge("Date of Birth", Today);
                // if "Date of Birth" <> 0D then begin
                //     ObjGeneralSetup.Get();
                //     if (CalcDate(ObjGeneralSetup."Min Member Age", "Date of Birth") > Today) then
                //         Error('Minimum Age For Member is 18');
                // end;
            end;
        }
        field(50043; Age; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50044; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Male,Female;
        }
        field(50045; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Single,Married;
        }
        field(50046; "Passport Photo"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Signature"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; Disabled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Employment Information';
            TableRelation = "BO Employer".Code;
            trigger OnValidate()
            begin
                if ObjEmployer.Get("Employer Code") then
                    "Employer Description" := ObjEmployer.Description;
            end;
        }
        field(50050; "Employer Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50051; "Department Code"; Code[50])

        {
            DataClassification = ToBeClassified;
            TableRelation = "BO Department".Code;
            trigger OnValidate()
            begin
                if ObjDepartment.Get("Department Code") then
                    "Department Description" := ObjDepartment.Description;

            end;
        }
        field(50052; "Department Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50053; Occupation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Payroll Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Casual,Permanent;
            Description = 'End of Employment Information';
        }
        field(50056; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Audit Information';
        }
        field(50057; "Capture Date Time"; dateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Processed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Processed Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'End of Audit Information';
        }
        field(50060; "Deposit Contribution Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Balances Information';
            Editable = false;
        }
        field(50061; "Share Capital Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50062; "Benevolent Fund Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'End of Balance Information';
        }
        // field(50063; "Date Filter"; Date)
        // {
        //     FieldClass = FlowFilter;
        //     Description = 'Start of Filters';
        // }
        field(50064; "Referee Name"; Code[40])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Referee information';
            TableRelation = Customer where("Member Posting Group" = filter('bo'));
            trigger OnValidate()
            begin
                BOAccounts.Reset();
                if BOAccounts.Get("Referee Name") then begin
                    "Referee ID No" := BOAccounts."Referee ID No";
                    "Referee Mobile Phone No" := BOAccounts."Referee Mobile Phone No";
                    "Referee Full Name" := BOAccounts."Full Name";
                end
            end;
        }
        field(50065; "Referee ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Referee Mobile Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Bank Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of External Banking Information';
            Editable = false;
        }
        field(50068; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Codes"."Bank Code";
            trigger OnValidate()
            var
                BankCodes: Record "Bank Codes";
            begin
                if BankCodes.Get("Bank Code") then
                    "Bank Name" := BankCodes."Bank Name";
            end;

        }
        field(50069; "Bank Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches Table"."Branch Code" where("Bank Code" = field("Bank Code"));
        }
        field(50070; "Bank Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Bank Branch Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'End of External Banking Information';
        }
        field(50074; "RM Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50075; "RM Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Member Account Type"; enum "BO Enums")
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "New DepositContributionBalance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Deposit Contribution")));
        }
        field(50078; "New Share Capital Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Share Capital")));

        }
        field(50079; "New Benevolent Fund Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Benevolent Fund")));

        }
        field(50080; "Total Outstanding Loan"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = filter("Loan" | "Principal Repayment")));
        }
        field(50081; "Outstanding Interest"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = filter("Interest Due" | "Interest Paid")));
        }
        field(50082; "New FO Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Fosa Transaction")));

        }
        field(50083; "Referee Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
        key(key2; "Full Name")
        {

        }
    }

    var
        myInt: Integer;
        recBoGeneralSetup: Record "BO General Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;
        RecApp: Record "BO Applications";
        fullname: Codeunit "Full Name";
        ObjDepartment: Record "BO Department";
        ObjEmployer: Record "BO Employer";
        objBOAccounts: Record "BO Accounts";
        BOAccounts: Record Customer;
        CDates: Codeunit "CFT Dates Library";
        SavingsAccount: Record "Savings Table4";
        BOApplications: Record "BO Applications";




    trigger OnInsert()

    begin
        if No = '' then begin
            recBoGeneralSetup.Get();
            recBoGeneralSetup.TestField(recBoGeneralSetup."BO Application Nos");
            NoSeriesMngt.InitSeries(recBoGeneralSetup."BO Application Nos", recBoGeneralSetup."BO Application Nos", 0D, No, recBoGeneralSetup."BO Application Nos");

            Rec."Application Date" := Today;
            "Captured By" := UserId;
            "Capture Date Time" := CurrentDateTime;
            "Customer Posting Group" := 'Customer';
            "Member Account Type" := "Member Account Type"::BO;
            if recBoGeneralSetup."Majority Members Employed" then begin
                "Is Employed" := true;

            end;





        end;




    end;

    trigger OnModify()

    begin
        Rec."Full Name" := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
        rec."Account Name" := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
        // Update Savings Account
        // SavingsAccount.Init();
        // SavingsAccount."Savings Product" := 'ORDINARY';
        // SavingsAccount."Account Name" := "Full Name";
        // SavingsAccount.Insert(true);
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;



}