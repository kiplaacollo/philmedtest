table 50151 "Loan Disbursement"
{
    LookupPageID = 50210;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Client No"; Code[20])
        {
            TableRelation = Table50121.Field18;

            trigger OnValidate()
            begin
                ClearFields();
                if BOAccounts.GET("Client No") then begin
                    "Client Name" := BOAccounts."Full Name";
                end;
            end;
        }
        field(3; "Client Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Loan No"; Code[20])
        {
            TableRelation = Loans."Loan Number" WHERE ("Loan Status" = FILTER (Approved),
                                                       "Approval Status" = FILTER (Approved),
                                                       "Member Number" = FIELD ("Client No"));

            trigger OnValidate()
            begin
                if Loans.Get("Loan No") then begin
                    Loans.CalcFields(Loans."Amount Disbursed");
                    "Approved Amount" := Loans."Approved Amount";
                    "Loan Product Type" := Loans."Loan Product";
                    "ED Loan Account No" := Loans."ED Loan Account No";
                    //Amount Disbursed
                    "Disbursed Amount" := Loans."Amount Disbursed";//getDisbursedAmount("Client No","Loan No");
                                                                   //Loan Balance
                    "Balance Outstanding" := "Approved Amount" - "Disbursed Amount";
                    "Approval Date" := Loans."Approval Date";
                end else begin
                    "Approved Amount" := 0;
                    "Balance Outstanding" := 0;
                    "Amount to Disburse" := 0;
                    "Disbursed Amount" := 0;
                    "Approval Date" := 0D;
                end;
            end;
        }
        field(5; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(6; "Approved Amount"; Decimal)
        {
        }
        field(7; "Disbursed Amount"; Decimal)
        {
            Editable = false;
        }
        field(8; "Balance Outstanding"; Decimal)
        {
        }
        field(9; "Requested Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Requested Amount" > "Balance Outstanding" then
                    Error('The Requested Amount:' + Format("Requested Amount") + ' cannot be more than the Balance Outstanding:' + Format("Balance Outstanding"));

                "Amount to Disburse" := "Requested Amount";
            end;
        }
        field(10; "Amount to Disburse"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Amount to Disburse" > "Requested Amount" then
                    Error('Amount to Disburse ' + Format("Amount to Disburse") + ' cannot be more than the Requested Amount: ' + Format("Requested Amount"));
            end;
        }
        field(11; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
        }
        field(12; "Booked By"; Code[20])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(13; "Paying Bank"; Code[20])
        {
            Editable = true;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if BankAccount.Get("Paying Bank") then
                    "Paying Bank Name" := BankAccount.Name;
            end;
        }
        field(14; "Mode Of Disburesment"; Option)
        {
            OptionCaption = 'Cheque,EFT,RTGS';
            OptionMembers = Cheque,EFT,RTGS;
        }
        field(15; "Cheque No/Reference No"; Code[20])
        {
        }
        field(16; Posted; Boolean)
        {
            Editable = true;
        }
        field(17; "Posting Date"; Date)
        {
        }
        field(18; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;
        }
        field(19; "Instalment Period"; DateFormula)
        {
        }
        field(20; "Grace Period - Principle (M)"; Integer)
        {
        }
        field(21; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(22; Installments; Integer)
        {
        }
        field(23; "Installment Including Grace"; Integer)
        {
        }
        field(24; "Repayment Start Date"; Date)
        {
        }
        field(25; "Repayment Method"; Option)
        {
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(26; Interest; Decimal)
        {
        }
        field(27; "Loan Product Type"; Code[20])
        {
        }
        field(28; Repayment; Decimal)
        {
        }
        field(29; "Loan Principle Repayment"; Decimal)
        {
        }
        field(30; "Loan Interest Repayment"; Decimal)
        {
        }
        field(31; "Loan Outstanding Balance"; Decimal)
        {
        }
        field(32; "No. Series"; Code[20])
        {
        }
        field(33; "Loan Disbursment Date"; Date)
        {

            trigger OnValidate()
            begin
                // IF "Loan Disbursment Date"<>0D THEN BEGIN
                // "Posting Date":="Loan Disbursment Date";
                //  GenSetup.GET;
                //  Loans.GET("Loan No");
                //  IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Daily THEN BEGIN
                //      "Repayment Start Date":=CALCDATE('1D',"Loan Disbursment Date");
                //  END;
                //
                //  IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Monthly THEN BEGIN
                //    IF DATE2DMY("Loan Disbursment Date",1)>GenSetup."Disbursement Date Determinant" THEN
                //      "Repayment Start Date":=CALCDATE('CM',(CALCDATE('1M',"Loan Disbursment Date")))
                //    ELSE
                //      "Repayment Start Date":=CALCDATE('CM',"Loan Disbursment Date");
                //  END;
                //  IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Quaterly THEN BEGIN
                //    IF DATE2DMY("Loan Disbursment Date",1)>GenSetup."Disbursement Date Determinant" THEN
                //      "Repayment Start Date":=CALCDATE('CQ',(CALCDATE('1Q',"Loan Disbursment Date")))
                //    ELSE
                //      "Repayment Start Date":=CALCDATE('CQ',"Loan Disbursment Date");
                //  END;
                //  IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Termly THEN BEGIN
                //    NextPeriodTxt:='+'+FORMAT(Loans."Repayment UserDefined");
                //    EVALUATE(NextPeriod,NextPeriodTxt);
                //    "Repayment Start Date":=CALCDATE(NextPeriod,"Loan Disbursment Date");
                //  END;
                // END ELSE BEGIN
                // "Posting Date":=0D;
                // "Repayment Start Date":=0D;
                // END;
            end;
        }
        field(34; "Paying Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(35; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(36; "Date Posted"; Date)
        {
        }
        field(37; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(38; Description; Text[100])
        {
        }
        field(39; "Currency Code"; Code[10])
        {
        }
        field(40; "Disburesment Type"; Option)
        {
            OptionCaption = ' ,Full/Single disbursement,Tranche/Multiple Disbursement';
            OptionMembers = " ","Full/Single disbursement","Tranche/Multiple Disbursement";

            trigger OnValidate()
            begin
                Validate("Loan No");
                "Requested Amount" := 0;
                "Amount to Disburse" := 0;
                if "Disburesment Type" = "Disburesment Type"::"Full/Single disbursement" then begin
                    if "Balance Outstanding" > 0 then begin
                        "Requested Amount" := "Balance Outstanding";
                        "Amount to Disburse" := "Balance Outstanding";
                    end else begin
                        "Requested Amount" := "Approved Amount";
                        "Amount to Disburse" := "Approved Amount";
                    end;

                end;
            end;
        }
        field(41; "Loan Type"; Option)
        {
            OptionCaption = ' ,Corporate,Ex-Staff';
            OptionMembers = " ",Corporate,"Ex-Staff";
        }
        field(42; "Global Dimension1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(43; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(44; "Shortcut Dimension 3 Code"; Code[20])
        {
        }
        field(45; "Shortcut Dimension 4 Code"; Code[20])
        {
        }
        field(46; "Shortcut Dimension 5 Code"; Code[20])
        {
        }
        field(47; "Shortcut Dimension 6 Code"; Code[20])
        {
        }
        field(48; "Shortcut Dimension 7 Code"; Code[20])
        {
        }
        field(49; "Shortcut Dimension 8 Code"; Code[20])
        {
        }
        field(50; "Total Offset Amount"; Decimal)
        {
            CalcFormula = Sum (Table50164.Field12 WHERE (Field1 = FIELD ("Loan No")));
            Description = 'Total amount from the Loans begin offset. The Amount includes the Outstanding Loan,Oustanding Interest,Commission on Loan Offset';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "ED Loan Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Loans."ED Loan Account No";
        }
        field(52; "Total Upfront Deductions"; Decimal)
        {
            CalcFormula = Lookup (Loans."Total Upfront Deductions" WHERE ("Loan Number" = FIELD ("Loan No"),
                                                                         "Member Number" = FIELD ("Client No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; "RM Code"; Code[50])
        {
            CalcFormula = Lookup (Loans."RM Code" WHERE ("Loan Number" = FIELD ("Loan No")));
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3));
        }
        field(50001; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Reversed by"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Loan Perfection Charges"; Decimal)
        {
            CalcFormula = Lookup (Loans."Loan Perfection Charges" WHERE ("Loan Number" = FIELD ("Loan No"),
                                                                        "Member Number" = FIELD ("Client No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Loan Prepayments"; Decimal)
        {
            CalcFormula = Lookup (Loans."Loan Prepayments" WHERE ("Loan Number" = FIELD ("Loan No"),
                                                                 "Member Number" = FIELD ("Client No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Repayment Start Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Booked By" := UserId;

        if "No." = '' then begin
            ObjGeneralSetup.GET;
            ObjGeneralSetup.TESTFIELD(ObjGeneralSetup."BO Loan Disbursement Nos");
            NoSeriesMgt.InitSeries(ObjGeneralSetup."BO Loan Disbursement Nos", ObjGeneralSetup."BO Loan Disbursement Nos", 0D, "No.", ObjGeneralSetup."BO Loan Disbursement Nos");
        end;
    end;

    var
        Setup: Record "No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Customer: Record Customer;
        LoanRegister: Record Loans;
        PrevDayAmt: Decimal;
        StartDate: Date;
        EndDate: Date;
        BankAccount: Record "Bank Account";
        ObjGeneralSetup: Record Table50101;
        NextPeriod: DateFormula;
        NextPeriodTxt: Code[10];
        BOAccounts: Record Table50121;
        Loans: Record Loans;

    local procedure getDisbursedAmount(ClientNo: Code[20]; LoanNo: Code[20]): Decimal
    var
        DetCust: Record "Detailed Cust. Ledg. Entry";
    begin
        // DetCust.RESET;
        // DetCust.SETRANGE(DetCust."Customer No.",ClientNo);
        // DetCust.SETRANGE(DetCust."Loan No",LoanNo);
        // DetCust.SETRANGE(DetCust."Transaction Type",DetCust."Transaction Type"::"Loan Payment");
        // IF DetCust.FINDSET THEN BEGIN
        //   DetCust.CALCSUMS(DetCust.Amount);
        //   EXIT(DetCust.Amount);
        // END;
    end;

    local procedure ClearFields()
    begin
        ClearAll;
        "ED Loan Account No" := '';
        "Disburesment Type" := "Disburesment Type"::" ";
        "Loan No" := '';
        "Approved Amount" := 0;
        "Disbursed Amount" := 0;
        "Balance Outstanding" := 0;
        "Requested Amount" := 0;
        "Amount to Disburse" := 0;
    end;
}

