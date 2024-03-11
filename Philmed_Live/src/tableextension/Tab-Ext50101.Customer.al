tableextension 50101 Customer extends Customer
{
    fields
    {
        field(50100; "Route Plan"; Code[20])
        {
            Caption = 'Route Plan';
            TableRelation = "Route Plan".Code;
        }
        field(50101; "Customer Region"; Code[20])
        {
            Caption = 'Customer Region';
            TableRelation = "Customer Region".code;
        }
        field(50102; "Cash Sale Customer"; Boolean)
        {
            Caption = 'Cash Sale Customer';
        }
        field(50103; "Eligible For Sales Gift"; Boolean)
        {
            Caption = 'Eligible For Sales Gift';
        }
        field(50104; "Last Payment Date"; Date)
        {
            Caption = 'Last Payment Date';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" WHERE("Customer No." = field("No."), "Document Type" = filter(Payment), Reversed = filter(FALSE)));
        }
        field(50105; "Dormant"; Boolean)
        {
            Caption = 'Dormant';
            Editable = false;
        }
        field(50106; "PD Cheques Total"; Decimal)
        {
            Caption = 'PD Cheques Total';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Gen. Journal Line".Amount WHERE("Account No." = field("No."), "Journal Template Name" = filter('CASH RECE'), "Journal Batch Name" = filter('POSTDCHECK')));
        }
        field(50107; "MPESA Phone No."; Code[20])
        {
            Caption = 'MPESA Phone No.';
            Editable = false;
        }
        field(50108; "Account Creation Date"; Date)
        {
            Caption = 'Account Creation Date';
            Editable = false;
        }
        field(50109; "Payroll No."; Code[30])
        {
            Caption = 'Payroll No.';
        }
        field(50110; "Food Deductions"; Decimal)
        {
            Caption = 'Food Deductions';
            FieldClass = FlowField;
            CalcFormula = sum("Value Entry"."Sales Amount (Actual)" where("Posting Date" = field("Date Filter"), "Item Ledger Entry Type" =
                            filter(Sale), "Source Type" = filter(Customer), "Source No." = field("No."),
                            "Inventory Posting Group" = filter('NON-FOOD' | 'FOOD')));

        }
        field(50111; "Drugs Deductions"; Decimal)
        {
            Caption = 'Drugs Deductions';
            FieldClass = FlowField;
            CalcFormula = sum("Value Entry"."Sales Amount (Actual)" where("Posting Date" = field("Date Filter"), "Item Ledger Entry Type" =
                            filter(Sale), "Source Type" = filter(Customer), "Source No." = field("No."),
                            "Inventory Posting Group" = filter('NON-PHARMACY' | 'OTC' | 'PHARMACY')));

        }
        field(50112; "Payments By Date"; Decimal)
        {
            Caption = 'Payments By Date';
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Posting Date" = field("Date Filter"), "Entry Type" =
                            filter("Initial Entry"), "Document Type" = filter(Payment), "Customer No." = field("No.")));

        }


        field(50150; "Current Balance"; Decimal)
        {
            Caption = 'Current Balance';
            Editable = false;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                        "Entry Type" = FILTER("Initial Entry"),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
        }
        field(50151; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cash Sale, Credit, Staff';
            OptionMembers = " ","Cash Sale","Credit","Staff";

        }
        field(50152; "Customer Target"; Decimal)
        {
            Caption = 'Customer Target';
            DataClassification = ToBeClassified;

        }
        modify("VAT Registration No.")
        {
            Caption = 'PIN No.';
        }

        modify(County)
        {
            TableRelation = County.Code;
        }
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                lvCustomer: Record Customer;
            begin
                if Name <> '' then begin
                    lvCustomer.SetRange("Search Name", UpperCase(Name));
                    if lvCustomer.FindFirst() then
                        Error('Customer No. %1 exists with the same Name!', lvCustomer."No.");
                end;
            end;
        }
        modify("Mobile Phone No.")
        {
            trigger OnAfterValidate()
            begin
                IF STRLEN("Mobile Phone No.") < 9 THEN
                    "MPESA Phone No." := '';
                //Error('Invalide Mobile Phone Number! The number has to be 9 or more charasters');

                IF STRLEN("Mobile Phone No.") = 9 THEN
                    "MPESA Phone No." := '254' + "Mobile Phone No.";

                IF STRLEN("Mobile Phone No.") >= 9 THEN
                    "MPESA Phone No." := '254' + COPYSTR("Mobile Phone No.", STRLEN("Mobile Phone No.") - 8, 9);
            end;
        }


    }
    trigger OnAfterModify()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Modify Customers" then
            Error('You have no user rights to Modify Customer Record');

        If (Name <> xRec.Name) AND (Name = '') then
            Error('Customer Name cannot be Blank!')

    end;

    trigger OnAfterInsert()
    begin
        "Account Creation Date" := Today;
    end;
}
