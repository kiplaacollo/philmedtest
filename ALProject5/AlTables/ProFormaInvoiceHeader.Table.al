table 50010 "ProForma Invoice Header"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Line: Integer;
            begin
                ObjCustomer.Reset;
                ObjCustomer.SetRange("No.", "Customer No");
                if ObjCustomer.Find('-') then begin
                    ObjCustomer.CalcFields("Balance (LCY)", "Infrastructure Amount", "Package Amount Excl VAT", "Package Excise Duty", "Recurring Package", "Child Accounts Count");
                    "No. Series" := 'PRO-INV';
                    "Customer Name" := ObjCustomer.Name;
                    "Package Name" := ObjCustomer."Recurring Package";
                    "Customer Balance" := ObjCustomer."Balance (LCY)";
                    "Other Associated Acounts" := ObjCustomer."Child Accounts Count";
                    "Pro-forma Amount" := Round(ObjCustomer."Infrastructure Amount" + ObjCustomer."Package Amount Excl VAT" + ObjCustomer."Package Excise Duty" - WithHoldingAmount +
                        (0.16 * (ObjCustomer."Package Amount Excl VAT" + ObjCustomer."Package Excise Duty" + ObjCustomer."Infrastructure Amount")), 1, '>');

                    Modify;
                    ProformaInvoiceLines.Reset;
                    ProformaInvoiceLines.SetRange("Document No", "Document No");
                    if ProformaInvoiceLines.Find('-') then
                        ProformaInvoiceLines.DeleteAll;
                    Line := 1000;
                    /*ObjStandardCustomerSalesCodes.RESET;
                    ObjStandardCustomerSalesCodes.SETRANGE("Customer No.","Customer No");
                     IF ObjStandardCustomerSalesCodes.FIND('-') THEN
                     BEGIN
                       ObjStandardSalesLine.RESET;
                       ObjStandardSalesLine.SETRANGE("Standard Sales Code",ObjStandardCustomerSalesCodes.Code);
                       IF ObjStandardSalesLine.FIND('-') THEN BEGIN
                       REPEAT
                         ProformaInvoiceLines.INIT;
                         ProformaInvoiceLines."Entry Id":=Line;
                         ProformaInvoiceLines."Document No":="Document No";
                         ProformaInvoiceLines.Description:=ObjStandardSalesLine.Description;
                         ProformaInvoiceLines.Rate:=ObjStandardSalesLine."Amount Excl. VAT";
                         ProformaInvoiceLines.Quantity:=1;
                         ProformaInvoiceLines.Amount:=ObjStandardSalesLine."Amount Excl. VAT";
                         ProformaInvoiceLines.INSERT(TRUE);
                         Line:=Line+1;
                       UNTIL ObjStandardSalesLine.NEXT=0;
                       END;
                     END;
                     */
                    Line := Line + 1;
                    ObjCustomer2.Reset;
                    ObjCustomer2.SetRange("Parent Account No", ObjCustomer."No.");
                    if ObjCustomer2.Find('-') then begin
                        repeat
                            ObjCustomer2.CalcFields("Balance (LCY)", "Package Amount Excl VAT", "Package Excise Duty", "Infrastructure Amount", "Recurring Package");
                            ProformaInvoiceLines.Init;
                            ProformaInvoiceLines."Entry Id" := Line;
                            ProformaInvoiceLines."Document No" := "Document No";
                            ProformaInvoiceLines.Description := ObjCustomer2.Name;
                            ProformaInvoiceLines.Rate := Round(1.16 * (ObjCustomer2."Package Amount Excl VAT" + ObjCustomer2."Package Excise Duty" + ObjCustomer2."Infrastructure Amount"), 1, '>');
                            ProformaInvoiceLines.Quantity := 1;
                            ProformaInvoiceLines.Amount := Round(1.16 * (ObjCustomer2."Package Amount Excl VAT" + ObjCustomer2."Package Excise Duty" + ObjCustomer2."Infrastructure Amount"), 1, '>');
                            ProformaInvoiceLines."Package Name" := ObjCustomer2."Recurring Package";
                            ProformaInvoiceLines."Customer Balance" := ObjCustomer2."Balance (LCY)";
                            ProformaInvoiceLines."Customer No" := ObjCustomer2."No.";
                            ProformaInvoiceLines.Insert(true);
                            Line := Line + 1;
                        until ObjCustomer2.Next = 0;
                    end

                end;

            end;
        }
        field(3; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Customer Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Date Generated"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Pro-forma Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Package Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Other Associated Acounts"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
        key(Key2; "Customer No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            NoSeriesMgt.InitSeries(SalesSetup."Proforma invoice Nos", xRec."No. Series", 0D, "Document No", "No. Series");
            "Date Generated" := Today;
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        ObjCustomer: Record Customer;
        ProformaInvoiceLines: Record "Proforma Invoice Lines";
        ObjStandardCustomerSalesCodes: Record "Standard Customer Sales Code";
        ObjStandardSalesLine: Record "Standard Sales Line";
        WithHoldingAmount: Decimal;
        ObjCustomer2: Record Customer;
}

