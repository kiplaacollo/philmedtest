table 50151 "Loan Disbursement"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; "Client No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                BOAccounts: Record Customer;
            begin
                if BOAccounts.get("Client No") then begin
                    "Client Name" := BOAccounts."Full Name";
                end;
            end;
        }
        field(3; "Client Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Loan No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = loans."Loan Number" where("Loan Status" = filter(Approved), "Approval Status" = filter(Approved), "Member Number" = field("Client No"));
            trigger OnValidate()
            var
                Loans: Record Loans;
            begin
                if Loans.Get("Loan No") then begin
                    "Approved Amount" := Loans."Approved Amount";
                    "Loan Product Type" := Loans."Loan Product";
                    "ED Loan Account No" := Loans."ED Loan Account No";
                    "Disbursed Amount" := Loans."Amount Disbursed";
                    "Balance Outstanding" := "Approved Amount" - "Disbursed Amount";
                    "Approval Date" := Loans."Approval Date";
                    // end ELSE BEGIN
                    //     "Approved Amount" := 0;
                    //     "Balance Outstanding" := 0;
                    //     "Amount to Disburse" := 0;
                    //     "Disbursed Amount" := 0;
                    //     "Approval Date" := 0D;
                end;
            end;
        }
        field(5; "Approval Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Approved Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Disbursed Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Balance Outstanding"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Requested Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Amount to Disburse"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
        }
        field(12; "Booked By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(13; "Paying Bank"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            var
                BankAccount: Record "Bank Account";
            begin
                if BankAccount.get("Paying Bank") then
                    "Paying Bank Name" := BankAccount.Name;
            end;
        }
        field(14; "Mode of Disbursement"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Cheque,EFT,RTGS;
        }
        field(15; "Cheque No/Reference No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16; Posted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Repayment Frequency"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Daily,Weekly,Monthly,Quaterly;
        }
        field(19; "Instalment Period"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Grace Period - Principle (M)"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Grace Period - Interest (M)"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(22; Installments; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Installment Including Grace"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Repayment Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(25; "Repayment Method"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(26; Interest; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Loan Product Type"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(28; Repayment; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(29; "Loan Principle Repayment"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Loan Interest Repayment"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(31; "Loan Outstanding Balance"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(32; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(33; "Loan Disbursement Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(34; "Paying Bank Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(35; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(36; "Date Posted"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(37; "Time Posted"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(38; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(39; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(40; "Disbursement Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Full/Single disbursement","Tranche/Multiple Disbursement";
            trigger OnValidate()
            begin
                Validate("Loan No");
                "Requested Amount" := 0;
                "Amount to Disburse" := 0;
                if "Disbursement Type" = "Disbursement Type"::"Full/Single disbursement" then begin
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
            DataClassification = CustomerContent;
            OptionMembers = Corporate,"Ex-Staff";
        }
        field(42; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(43; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(44; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(45; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(46; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(47; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(48; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(49; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        // field(50; "Total Offset Amount"; Decimal)
        // {
        //     Description = 'Total amount from the Loans begin offset. The Amount includes the Outstanding Loan,Oustanding Interest,Commission on Loan Offset';
        //     FieldClass = FlowField;
        // }
        field(51; "ED Loan Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Loans."ED Loan Account No";
        }
        field(52; "Total Upfront Deductions"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup(Loans."Total Upfront Deductions" where("Loan Number" = field("Loan No"), "Member Number" = field("Client No")));
        }
        field(53; "RM Code"; Code[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."RM Code" where("Loan Number" = field("Loan No")));
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
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Perfection Charges" where("Loan Number" = field("Loan No"), "Member Number" = field("Client No")));
        }
        field(50006; "Loan Prepayments"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Prepayments" where("Loan Number" = field("Loan No"), "Member Number" = field("Client No")));
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
        key(key2; "Repayment Start Date")
        {

        }
    }

    var
        myInt: Integer;


    trigger OnInsert()
    var
        ObjGeneralSetup: Record "BO General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        "Booked By" := UserId;
        IF "No." = '' THEN BEGIN
            ObjGeneralSetup.GET;
            ObjGeneralSetup.TESTFIELD(ObjGeneralSetup."BO Loan Disbursement Nos");
            NoSeriesMgt.InitSeries(ObjGeneralSetup."BO Loan Disbursement Nos", ObjGeneralSetup."BO Loan Disbursement Nos", 0D, "No.", ObjGeneralSetup."BO Loan Disbursement Nos");
        END;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}