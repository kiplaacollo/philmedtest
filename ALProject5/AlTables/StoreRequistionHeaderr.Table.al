table 50611 "Store Requistion Headerr"
{
    Caption = 'Store Requistion Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                //IF "No." = '' THEN BEGIN
                if "No." <> xRec."No." then begin
                    GenLedgerSetup.Get();
                    NoSeriesMgt.TestManual(GenLedgerSetup."Stores Requisition No");
                    "No." := '';
                end;
                //END;
            end;
        }
        field(2; "Request date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //IF "Request date" < TODAY THEN ERROR('Required date should be furture date');
            end;
        }
        field(5; "Required Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Required Date" < "Request date" then
                    Error('You cannot request date before the request date');
            end;
        }
        field(6; "Requester ID"; Code[100])
        {
            Caption = 'Requester ID';
            Editable = false;
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(7; "Request Description"; Text[150])
        {
        }
        field(9; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Cancelled,Posted,Rejected,Pending Acceptance,Accepted';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Cancelled,Posted,Rejected,"Pending Acceptance",Accepted;

            trigger OnValidate()
            begin
                /*
                IF Status=Status::Accepted THEN BEGIN
                  CftFactory.FnPostStoreRequisition("No.")
                  END;
                  */

            end;
        }
        field(11; Supplier; Code[100])
        {
            TableRelation = Vendor;
        }
        field(12; "Action Type"; Option)
        {
            OptionMembers = " ","Ask for Tender","Ask for Quote";

            trigger OnValidate()
            begin
                /*
                IF Type=Type::"G/L Account" THEN BEGIN
                   IF "Action Type"="Action Type"::Issue THEN
                            ERROR('You cannot Issue a G/L Account please order for it')
                END;


               //Compare Quantity in Store and Qty to Issue
                IF Type=Type::Item THEN BEGIN
                   IF "Action Type"="Action Type"::Issue THEN BEGIN
                    IF Quantity>"Qty in store" THEN
                      ERROR('You cannot Issue More than what is available in store')
                   END;
                END;
                */

            end;
        }
        field(29; Justification; Text[250])
        {
        }
        field(30; "User ID"; Code[150])
        {
            Editable = false;
        }
        field(31; "Global Dimension 1 Code"; Code[100])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

            trigger OnValidate()
            begin
                Dimval.Reset;
                Dimval.SetRange(Dimval."Global Dimension No.", 1);
                Dimval.SetRange(Dimval.Code, "Global Dimension 1 Code");
                if Dimval.Find('-') then
                    "Function Name" := Dimval.Name
            end;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[100])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));

            trigger OnValidate()
            begin
                Dimval.Reset;
                Dimval.SetRange(Dimval."Global Dimension No.", 2);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 2 Code");
                if Dimval.Find('-') then
                    "Budget Center Name" := Dimval.Name
            end;
        }
        field(57; "Function Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[100])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(81; "Shortcut Dimension 3 Code"; Code[70])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3));

            trigger OnValidate()
            begin
                Dimval.Reset;
                //Dimval.SETRANGE(Dimval."Global Dimension No.",3);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 3 Code");
                if Dimval.Find('-') then
                    Dim3 := Dimval.Name
            end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[70])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4));

            trigger OnValidate()
            begin
                Dimval.Reset;
                //Dimval.SETRANGE(Dimval."Global Dimension No.",4);
                Dimval.SetRange(Dimval.Code, "Shortcut Dimension 4 Code");
                if Dimval.Find('-') then
                    Dim4 := Dimval.Name
            end;
        }
        field(83; Dim3; Text[250])
        {
        }
        field(84; Dim4; Text[250])
        {
        }
        field(85; "Responsibility Center"; Code[100])
        {
            Caption = 'Responsibility Center';
            TableRelation = Departments;

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
                if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
                    Error(
                      Text001,
                      RespCenter.TableCaption, UserMgt.GetPurchasesFilter);
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */

            end;
        }
        field(86; TotalAmount; Decimal)
        {
            CalcFormula = Sum ("Store Requistion Liness"."Line Amount" WHERE ("Requistion No" = FIELD ("No.")));
            FieldClass = FlowField;
        }
        field(87; "Issuing Store"; Code[20])
        {
            TableRelation = Location WHERE ("Is Store" = FILTER (true));

            trigger OnValidate()
            begin

                ReqLines.Reset;
                ReqLines.SetRange(ReqLines."Requistion No", "No.");
                if ReqLines.Find('-') then begin
                    repeat
                        ReqLines."Issuing Store" := "Issuing Store";
                    until ReqLines.Next = 0;
                end;

                //Validate Supervisor Staff No
                stores.Reset;
                stores.SetRange(stores.Code, "Issuing Store");
                if stores.Find('-') then begin
                    "Supervisor Staff No" := stores."SuperVisor Staff No";
                end;
            end;
        }
        field(88; "Job No"; Code[20])
        {
        }
        field(89; "Posting Date"; Date)
        {
        }
        field(90; "Document Type"; Option)
        {
            OptionCaption = ' ,Grant,PR';
            OptionMembers = " ",Grant,PR;
        }
        field(91; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(92; Cancelled; Boolean)
        {
        }
        field(93; "Cancelled By"; Code[100])
        {
        }
        field(94; "Destination Store"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE (IsBaseStation = FILTER (true));

            trigger OnValidate()
            begin
                if "Destination Store" = "Issuing Store" then
                    Error('Destination store cannot be the same as the issuing store');
            end;
        }
        field(95; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Branch Requisition,Technician Requisition';
            OptionMembers = "Branch Requisition","Technician Requisition";
        }
        field(96; "Staff No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if HrEmp.Get("Staff No") then
                    "Staff Name" := HrEmp.Name;
            end;
        }
        field(97; "Staff Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(98; crm_id; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(99; "Supervisor Staff No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Issuing Store")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //  IF Status<>Status::Open THEN
        //     ERROR('You Cannot DELETE an already released Requisition')
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."Stores Requisition No");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Stores Requisition No", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        //EXIT(GetNoSeriesRelCode(NoSeriesCode));
        "Request date" := Today;
        "Posting Date" := Today;
        "User ID" := UserId;
    end;

    trigger OnModify()
    begin
        //  IF Status=Status::Released THEN
        //     ERROR('You Cannot modify an already Approved Requisition');

        // ReqLines.RESET;
        // ReqLines.SETRANGE(ReqLines."Requistion No","No.");
        // IF ReqLines.FIND('-') THEN BEGIN
        // REPEAT
        //  ReqLines."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
        //  ReqLines."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
        //  ReqLines."Shortcut Dimension 3 Code":="Shortcut Dimension 3 Code";
        //  ReqLines."Shortcut Dimension 4 Code":="Shortcut Dimension 4 Code";
        // UNTIL ReqLines.NEXT=0;
        // END;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Purchases & Payables Setup";
        UserDept: Record "Imprest Surrender Detailss";
        RespCenter: Record "Responsibility Center BRr";
        UserMgt: Codeunit "User Setup Management BRr";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        Dimval: Record "Dimension Value";
        ReqLines: Record "Store Requistion Liness";
        HrEmp: Record pr_employees;
        stores: Record Location;
        CftFactory: Codeunit "CFT Factory";

    [Scope('Internal')]
    procedure GetNoSeriesRelCode(NoSeriesCode: Code[20]): Code[10]
    var
        GenLedgerSetup: Record "General Ledger Setup";
        RespCenter: Record "Responsibility Center BRr";
        DimMgt: Codeunit DimensionManagement;
        NoSrsRel: Record "No. Series Relationship";
    begin
        //EXIT(GetNoSeriesRelCode(NoSeriesCode));GenLedgerSetup.GET;
        /*CASE GenLedgerSetup."Base No. Series" OF
          GenLedgerSetup."Base No. Series"::"Responsibility Center":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Responsibility Center");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          GenLedgerSetup."Base No. Series"::"Shortcut Dimension 1":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Global Dimension 1 Code");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          GenLedgerSetup."Base No. Series"::"Shortcut Dimension 2":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Shortcut Dimension 2 Code");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          GenLedgerSetup."Base No. Series"::"Shortcut Dimension 3":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Shortcut Dimension 3 Code");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          GenLedgerSetup."Base No. Series"::"Shortcut Dimension 4":
           BEGIN
            NoSrsRel.RESET;
            NoSrsRel.SETRANGE(Code,NoSeriesCode);
            NoSrsRel.SETRANGE("Series Filter","Shortcut Dimension 4 Code");
            IF NoSrsRel.FINDFIRST THEN
              EXIT(NoSrsRel."Series Code")
           END;
          ELSE EXIT(NoSeriesCode);
        END;*/

    end;

    local procedure GetNoSeriesCode(): Code[10]
    var
        NoSeriesCode: Code[20];
    begin
        /* GenLedgerSetup.GET();
         {
         IF "Document Type" = "Document Type"::Grant THEN
           GenLedgerSetup.TESTFIELD(GenLedgerSetup."Staff Grants Nos.")
        ELSE
        }
           GenLedgerSetup.TESTFIELD(GenLedgerSetup."Stores Requisition No");
         {
         IF "Document Type" = "Document Type"::Grant THEN
           NoSeriesCode:=GenLedgerSetup."Staff Grants Nos."
         ELSE
         }

           NoSeriesCode:=GenLedgerSetup."Stores Requisition No";

         EXIT(GetNoSeriesCode);
         */

    end;
}

