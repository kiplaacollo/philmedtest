table 50001 "Payment Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(11; "Document No"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payments Header"."No.";
        }
        field(12; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt,"Funds Transfer",Imprest,"Imprest Accounting",Claim,"Member Bill","Group Bill";
        }
        field(13; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(14; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Transaction Type"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            Editable = false;
        }
        field(17; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No." else
            if ("Account Type" = const(Customer)) Customer."No." else
            if ("Account Type" = const(Vendor)) Vendor."No." else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"."No.";
        }
        field(18; "Account Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Transaction Type Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Payment Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(21; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(23; "VAT Code"; Code[10])
        {
            DataClassification = CustomerContent;

        }
        field(24; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "VAT Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "W/TAX Code"; Code[10])
        {
            DataClassification = CustomerContent;

        }
        field(27; "W/TAX Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(28; "W/TAX Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(29; "Retention Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(30; "Retention Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(31; "Retention Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(32; "Net Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33; "Net Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(34; Committed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Vote Book"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Gen. Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Gen. Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(38; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(39; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(40; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Global Dimension 2 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(42; "Shortcut Dimension 3 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(43; "Shortcut Dimension 4 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(44; "Shortcut Dimension 5 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(45; "Shotcut Dimension 6 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(46; "Shortcut Dimension 7 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(47; "Shortcut Dimension 8 Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(48; "Applies-to Doc. Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(49; "Applies-to Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50; "Applies-to ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(51; "VAT Withheld"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(52; "VAT Withheld Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(53; "VAT Withheld Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(54; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
            Editable = false;
        }
        field(55; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(56; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(57; "Date Posted"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(58; "Time Posted"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(59; "Payment Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Normal,"Petty Cash",Express,"Cash Purchase",Mobile;
        }
        field(60; "Payment Mode"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Cash,Cheque,EFT,"Letter of Credit","Custom 3","Custom 4","Custom 5";
        }
        field(61; "Default Grouping"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(62; "Responsibility Center"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(63; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(64; "Payment Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Normal Payment","Meeting Payment";
        }
        field(66; Reversed; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(67; "Reversed By"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(68; "Reversal Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(69; "Reversal Time"; Time)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(71; "Bank Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(72; "Bank Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(73; "Posting Dates"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Payments Header"."Posting Date" where("No." = field("Document No")));
        }
        field(74; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }

    }

    keys
    {
        key(Key1; "Line No")
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