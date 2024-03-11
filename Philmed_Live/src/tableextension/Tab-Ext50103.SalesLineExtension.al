tableextension 50103 SalesLineExtension extends "Sales Line"
{
    fields
    {
        field(50100; "Cash Sale Gift Item"; Boolean)
        {
            Caption = 'Cash Sale Gift Item';
            Editable = false;
        }
        field(50101; "Batch No."; Code[20])
        {
            Caption = 'Batch No.';
            Editable = false;
        }
        field(50102; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            Editable = false;
        }
        field(50103; "Inventory Balance"; Decimal)
        {
            Caption = 'Inventory Balance (W)';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity WHERE("Item No." = field("No."), "Location Code" = field("Location Code")));
        }
        field(50104; "Minimum Unit Price"; Decimal)
        {
            Caption = 'Minimum Unit Price';
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
                ItemLedgerEntry: Record "Item Ledger Entry";
                lvItem: Record Item;
            begin
                If "No." <> '' then begin
                    SalesHeader.SetRange("Document Type", "Document Type");
                    SalesHeader.SetRange("No.", "Document No.");
                    If SalesHeader.FindFirst() then begin
                        SalesHeader.TestField("Salesperson Code");
                        SalesHeader.TestField("Location Code");
                        SalesHeader.TestField("Shortcut Dimension 1 Code");
                        //Sales Line
                        SalesLine.SetRange("Document Type", "Document Type");
                        SalesLine.SetRange("Document No.", "Document No.");
                        SalesLine.SetRange(Type, Type::Item);
                        SalesLine.SetRange("No.", "No.");
                        if SalesLine.FindFirst() then
                            Error('This Item already exists in this Order on Line No. %2', SalesLine."Line No.");

                    end;

                    //Batch No. and Expiry Date
                    ItemLedgerEntry.SetCurrentKey("Posting Date");
                    ItemLedgerEntry.SetRange("Item No.", "No.");
                    ItemLedgerEntry.SetRange(Open, true);
                    ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                    If ItemLedgerEntry.FindFirst() then begin
                        ItemLedgerEntry.CalcFields("Batch No.", "Expiry Date");
                        "Batch No." := ItemLedgerEntry."Batch No.";
                        "Expiry Date" := ItemLedgerEntry."Expiry Date";
                    end;

                    //History of minimin unit price
                    if lvItem.Get("No.") then
                        "Minimum Unit Price" := lvItem."Minimum Unit Price";

                end;
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                PhysicalInvJournal: Record "Item Journal Line";
                lvItem: Record Item;
            begin

                If ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Invoice) then begin
                    CheckCustomerCreditLimit(Rec);
                    CalcFields("Inventory Balance");
                    lvItem.Get("No.");
                    if ("Quantity (Base)" > "Inventory Balance") and (lvItem.Type = lvItem.Type::Inventory) then
                        Error('The available inventory for item %1 is lower than the entered quantity at this location', "No.");

                end;
                if Quantity < 0 then
                    Error('Quantity Cannot be Negative for this Document');

                //Check Item from Physical Inventory Journal
                If ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Invoice) then begin
                    if type = Type::Item then begin
                        PhysicalInvJournal.SetRange("Journal Template Name", 'PHYS. INVE');
                        PhysicalInvJournal.SetRange("Item No.", "No.");
                        PhysicalInvJournal.SetRange("Location Code", "Location Code");
                        if PhysicalInvJournal.FindFirst() then
                            Error('This Item is under stock count in this Location under the Batch %1', PhysicalInvJournal."Journal Batch Name");
                    end;
                end;

            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
                lvItem: Record Item;
                lvUserSetup: Record "User Setup";
            begin
                lvuserSetup.Get(UserId);
                if ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Quote) Then begin

                    if (Type = Type::Item) AND ("No." <> '') then begin
                        lvItem.Get("No.");
                        if (lvItem."Minimum Unit Price" <> 0) and ("Unit of Measure Code" = lvItem."Base Unit of Measure") and
                                    (NOT lvUserSetup."Allow Sales Order Price Change") then begin
                            if "Unit Price" < lvItem."Minimum Unit Price" then
                                Error('Unit Price cannot be adjusted below Item Minimum Price  which is set at %1', lvItem."Minimum Unit Price");
                        end;

                        //Unit of measure different from Base Unit of Measure 18042023
                        if (lvItem."Minimum Unit Price" <> 0) and ("Unit of Measure Code" <> lvItem."Base Unit of Measure") and
                                    (NOT lvUserSetup."Allow Sales Order Price Change") then begin
                            if "Unit Price" < (lvItem."Minimum Unit Price" * "Qty. per Unit of Measure") then
                                Error('Unit Price cannot be adjusted below Item Minimum Price  which is set at %1', Round((lvItem."Minimum Unit Price" * "Qty. per Unit of Measure"), 0.01));
                        end;
                    end;


                    //Restrict Selling below Unit cost
                    //if (Type = Type::Item) AND ("No." <> '') then begin
                    //lvItem.Get("No.");

                    //if (lvItem."Unit Cost" <> 0) and ("Unit of Measure Code" = lvItem."Base Unit of Measure") then begin
                    //if "Unit Price" <= ((lvItem."Unit Cost" + lvItem."Last Direct Cost") / 2) then
                    //Error('Unit Price cannot be adjusted below Item Cost Price  which is set at %1', lvItem."Unit Cost");
                    //end;
                    //end;

                    //Restrict Changing Price for PCS
                    //if (Type = Type::Item) AND ("No." <> '') then begin
                    //lvItem.Get("No.");
                    //if ("Unit of Measure Code" <> lvItem."Base Unit of Measure") then begin
                    //if ("Unit Price" < (lvItem."Unit Price" * "Qty. per Unit of Measure")) then
                    //Error('Unit Price for other units of measure cannot be adjusted downwards below Wholesale Price');
                    //end;
                    //end;

                end;
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            var
                lvItem: Record Item;
            begin
                if ("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Invoice) Then begin
                    if (Type = Type::Item) AND ("No." <> '') then begin
                        lvItem.Get("No.");
                        if "Line Discount %" > lvItem."Discount % Allowed" then
                            Error('Line Discount % cannot be more than Item Discount % Allowed  which is set at %1', lvItem."Discount % Allowed");
                    end;
                end;
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                lvLocation: Record Location;
            begin
                if "Location Code" <> '' then begin
                    lvLocation.Get("Location Code");
                    if lvLocation."Block Sales From Location" then
                        Error('This Location is Blocked for use in Sales Orders!');
                end;
            end;
        }


    }
    trigger OnAfterModify()
    var

    begin
        If "Cash Sale Gift Item" then begin
            if Quantity <> xRec.Quantity then
                Error('You cannot edit Quantity for Cash Sale Gift Items');
        end;
    end;

    procedure CheckCustomerCreditLimit(SalesLine: Record "Sales Line")
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesOrderAmount: Decimal;
    begin
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) Then begin

            Customer.Get(SalesLine."Sell-to Customer No.");
            if Customer."Credit Limit (LCY)" <> 0 then begin
                Customer.CalcFields("Balance (LCY)");
                //Calculate current Order Amount
                SalesHeader.SetRange("Document Type", SalesLine."Document Type");
                SalesHeader.SetRange("No.", SalesLine."Document No.");
                if SalesHeader.FindFirst() then begin
                    SalesHeader.CalcFields("Amount Including VAT");
                    SalesOrderAmount := SalesHeader."Amount Including VAT";

                end;

                if (Customer."Balance (LCY)" + SalesOrderAmount) > Customer."Credit Limit (LCY)" then begin
                    Error('This Order Amount plus the current customer Balance will surpass Customer Credit Limit. Advise the Customer to top up Account!');
                end;
            end;
        end;
    end;


}

