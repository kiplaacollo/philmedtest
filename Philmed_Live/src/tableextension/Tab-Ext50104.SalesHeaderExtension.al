tableextension 50104 SalesHeaderExtension extends "Sales Header"
{
    fields
    {
        field(50100; "Cash Sale Order"; Boolean)
        {
            Caption = 'Cash Sale Order';
            Editable = false;
        }
        field(50101; "Route Plan"; Code[20])
        {
            Caption = 'Route Plan';
            Editable = false;
        }
        field(50102; "Urgent Comments"; Text[100])
        {
            Caption = 'Urgent Comments';
        }
        field(50103; "Host Name"; Text[250])
        {
            Caption = 'Host Name';
            Editable = false;
        }
        field(50104; "Time Created"; DateTime)
        {
            Caption = 'Order Creation Time';
            Editable = false;
        }
        field(50106; "Awaiting Kra Posting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Posted To KRA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Posted To KRA Error"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Kra Error Descripion"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(50110; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()
            var
                SH: Record "Sales Header";

            begin

                SH.SetRange("Applies-to Doc. No.", "Applies-to Doc. No.");

                IF SH.GET("Applies-to Doc. No.") then
                    Rec."Invoice Date" := Rec."Posting Date";

            end;

        }


        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                lvCustomer: Record Customer;
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "Sell-to Customer No." <> '' then begin
                    lvCustomer.Get("Sell-to Customer No.");
                    "Cash Sale Order" := lvCustomer."Cash Sale Customer";
                    If "Cash Sale Order" then begin
                        SalesSetup.Get();
                        if SalesSetup."Cash Sale Posting Nos." <> '' then begin
                            "Posting No. Series" := SalesSetup."Cash Sale Posting Nos.";
                        end;
                    end;
                    if lvCustomer."Route Plan" <> '' then
                        "Route Plan" := lvCustomer."Route Plan";
                    if lvCustomer."Location Code" <> '' then
                        "Location Code" := lvCustomer."Location Code";

                end;

            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
                lvCustomer: Record Customer;
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "Sell-to Customer No." <> '' then begin
                    lvCustomer.Get("Sell-to Customer No.");
                    If "Cash Sale Order" then begin
                        SalesSetup.Get();
                        if SalesSetup."Cash Sale Posting Nos." <> '' then begin
                            "Posting No. Series" := SalesSetup."Cash Sale Posting Nos.";
                        end;
                    end;

                end;

            end;
        }
        modify("Salesperson Code")
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Blocked = filter(false));

            trigger OnAfterValidate()
            var
                lvSalesPerson: Record "Salesperson/Purchaser";

            begin
                if "Salesperson Code" <> '' then begin
                    lvSalesPerson.Get("Salesperson Code");
                    If lvSalesPerson.Blocked then
                        Error('This SalesPerson is Blocked!');

                    if lvSalesPerson."Location Code" <> '' then begin
                        "Location Code" := lvSalesPerson."Location Code";
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

    procedure CheckCustomerCreditLimit(SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
        SalesOrderAmount: Decimal;
    begin
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) Then begin
            Customer.Get(SalesHeader."Sell-to Customer No.");
            if Customer."Credit Limit (LCY)" <> 0 then begin
                Customer.CalcFields("Balance (LCY)");
                //Calculate current Order Amount
                SalesHeader.CalcFields("Amount Including VAT");
                SalesOrderAmount := SalesHeader."Amount Including VAT";

                if (Customer."Balance (LCY)" + SalesOrderAmount) > Customer."Credit Limit (LCY)" then begin
                    Error('This Order Amount plus the current customer Balance will surpass Customer Credit Limit. Advise the Customer to top up Account!');
                end;
            end;
        end;
    end;

    procedure InsertCashSaleGiftItem(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        CashSalesGiftItem: Record "Cash Sale Gift Item";
        LineNo: Integer;
        LimitBand: Decimal;
    begin
        if SalesHeader."Cash Sale Order" then begin
            SalesHeader.CalcFields("Amount Including VAT");
            CashSalesGiftItem.Reset();
            CashSalesGiftItem.SetAscending("Cash Sale Limit (LCY)", false);
            CashSalesGiftItem.SetFilter("Cash Sale Limit (LCY)", '<=%1', SalesHeader."Amount Including VAT");
            if CashSalesGiftItem.FindFirst() then
                LimitBand := CashSalesGiftItem."Cash Sale Limit (LCY)";

            If LimitBand <> 0 then begin
                CashSalesGiftItem.Reset();
                CashSalesGiftItem.SetRange("Cash Sale Limit (LCY)", LimitBand);
                if CashSalesGiftItem.FindSet() then begin
                    //First Delete Gift Items if they Exists
                    SalesLine2.Reset();
                    SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
                    SalesLine2.SetRange("Document No.", SalesHeader."No.");
                    SalesLine2.SetRange("Cash Sale Gift Item", true);
                    SalesLine2.SetFilter("Quantity Shipped", '=%1', 0);
                    if SalesLine2.FindSet() then
                        repeat
                            SalesLine2.Delete(true);
                        until SalesLine2.Next() = 0;

                    Commit();

                    repeat
                        //Insert the Cash Sale Gift Item
                        //Get the Line number
                        SalesLine2.Reset();
                        SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine2.SetRange("Document No.", SalesHeader."No.");
                        if SalesLine2.FindLast() then begin
                            LineNo := SalesLine2."Line No." + 10000;
                        end;

                        //Insert the gift Item
                        SalesLine.Init();
                        SalesLine."Document Type" := SalesHeader."Document Type";
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Line No." := LineNo;
                        SalesLine.Type := SalesLine.Type::Item;
                        SalesLine.Validate("No.", CashSalesGiftItem."Item Code");
                        SalesLine."Location Code" := SalesHeader."Location Code";
                        SalesLine.Validate("Unit of Measure Code", CashSalesGiftItem."Unit of Measure Code");
                        SalesLine.Validate(Quantity, CashSalesGiftItem.Quantity);
                        SalesLine.Validate("Unit Price", 0);
                        SalesLine."Cash Sale Gift Item" := true;
                        SalesLine.Insert(true);
                    until CashSalesGiftItem.Next() = 0;

                    Message('Cash Sale Gift Item(s) Successfully Added');
                end;
            end;
        end;
    end;

    trigger OnAfterInsert()
    var
        ActiveSession: Record "Active Session";
    begin
        ActiveSession.RESET;
        ActiveSession.SETRANGE("Session ID", SESSIONID);
        IF ActiveSession.FINDFIRST THEN BEGIN
            "Host Name" := ActiveSession."Client Computer Name";
        end;
    end;
}
