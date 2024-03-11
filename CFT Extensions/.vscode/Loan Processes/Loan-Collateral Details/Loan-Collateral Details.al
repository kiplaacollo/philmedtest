table 52001 "Loan-Collateral Details"
{
    DataClassification = CustomerContent;
    LookupPageId = "Loan Collateral Security";
    DrillDownPageId = "Loan Collateral Security";

    fields
    {
        // field(1; "Serial No"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     AutoIncrement = true;
        // }
        field(2; "Loan No"; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Loans."Loan Number";
            trigger OnValidate()
            var
                LoanApplications: Record Loans;
            begin
                if LoanApplications.Get("Loan No") then begin
                    "Loan Type" := LoanApplications."Loan Product";
                    "Registered To" := LoanApplications."Member Number";
                end;
            end;
        }
        field(3; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Shares,Deposits,Collateral,"Fixed Deposit","Money Market","Tangible Asset","Children's Accounts",Land,Guarantors;
            NotBlank = true;
        }
        field(4; "Security Details"; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(5; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Loan Type"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Loan Products".Code;
        }
        field(7; Value; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Collateral Depr Appr Details".Value where("Document No" = field("Collateral Document No"), Voided = filter(false)));
        }
        field(8; "Guarantee Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Collateral-Register"."Guarantee Value" where("Document No" = field("Collateral Document No")));


        }
        field(9; Code; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Loan Collateral Set-up".Code;
            trigger OnValidate()
            var
                SecSetup: Record "Loan Collateral Set-up";
            begin
                SecSetup.Reset();
                SecSetup.SetRange(SecSetup.Code, Code);
                if SecSetup.Find('-') then begin
                    Type := SecSetup.Type;
                    "Security Details" := SecSetup."Security Description";
                    "Collateral Multiplier" := SecSetup."Collateral Multiplier";
                    "Guarantee Value" := Value * "Collateral Multiplier";
                    Category := SecSetup.Category;

                end;

            end;

        }
        field(10; Category; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Cash,"Government Securities","Corporate Bonds",Equity,"Morgage Securities";
        }
        field(11; "Collateral Multiplier"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "View Document"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Assesment Done"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Account No"; Code[20])
        {
            DataClassification = CustomerContent;
            // TableRelation = Vendor."No." where("Vendor Posting Group" = const(fixed));
        }
        field(16; "Title Deed No."; Code[150])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Comitted Collateral Value"; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "Collateral Register"."Guarantee Value" where("Registered To" = field("Registered To"));
        }
        field(20; "Vehicle Make"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Collateral Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Logbook,Title;
        }
        field(22; "Year of Manufacture"; Code[5])
        {
            DataClassification = CustomerContent;
        }
        field(23; Insurance; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(24; "Commencing Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(25; Owner; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(26; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Complete,Incomplete,Charged;
        }
        field(27; "Missing Documents"; Text[120])
        {
            DataClassification = CustomerContent;
        }
        field(28; "Contact No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Email Address"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(30; "Title Contents"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(31; "Date Released"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Date Charged"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(33; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(34; "Registered To"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "BO Accounts"."Member Number";
        }
        field(35; "Free Collateral"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(36; "Amount To Commit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(37; "OutStanding Bal"; Decimal)
        {
            // To update when Detailed BO Ledger Entry is Created
            FieldClass = FlowField;
            CalcFormula = sum("Collateral-Register"."Guarantee Value" where("Document No" = field("Collateral Document No")));

        }
        field(38; "Registration No"; Code[200])
        {
            DataClassification = CustomerContent;
        }
        field(39; "Total Comited Collateral Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Loan-Collateral Details"."Amount To Commit" where("Registered To" = field("Registered To"), "Collateral Document No" = field("Collateral Document No")));
        }
        field(40; No; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(41; "No. Series"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(42; "Collateral Document No"; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Collateral-Register"."Document No" where("Registered To" = field("Registered To"));
            trigger OnValidate()
            begin

            end;
        }
        field(43; "Loan Posted"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(44; Release; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(45; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }



    }


    keys
    {
        key(Key1; No, "Loan No", "Collateral Document No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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