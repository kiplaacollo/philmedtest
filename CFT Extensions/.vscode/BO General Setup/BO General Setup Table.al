table 50101 "BO General Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Max Non Contribution Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Min Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Min Share Capital Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Monthly Insurance Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Benevolent Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Min Member Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Max Member Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Min Loan Share Ratio"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Days for Checkoff"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Default Customer Posting Group"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(11; "Default Micro Credit Posting G"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(12; "Registration Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Majority Members Employed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Default BO Activity Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(15; "Min Existence Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Maximum Profitability Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Maximum Possible DBR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "ABB EMI Ratio(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Institution Founding Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Recovery Since Founding Date"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Go Live Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Add Loan Charges"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Is Paid Via Mpesa"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Accept Negative Int Payments"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Defaulter Loan Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(31; "BO Application Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(32; "BO Receipt Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(33; "BO Loan Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34; "BO Transfers Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(35; "BO exit Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(36; "BO CheckOff Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(37; "BO Loan Batch Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(38; "BO Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        //From Cloud
        field(39; "BO Checkoff Advice Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(40; "CFT Income Accrual Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(60; "FO Cashier Transactions Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(61; "FO Treasury Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(62; "FO Loans Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(63; "FO Standing Orders Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(64; "FO ATM Applications Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(65; "FO Salary processing Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(66; "FO Loan Batch Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(67; "Savings Application Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(68; "Savings Account Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(69; "FO Interest Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(90; "INV Investor Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(91; "INV Property Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(92; "INV Project Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(120; Admin; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(121; "BO Loan Disbursement Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(123; "CRM Client Log In Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(124; "CRM Potential Opportonity Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(125; "CRM Lead Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(126; "BO Member Receipt"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(127; "BO Bulk Receipt"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(128; "BO Interest Accrual Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(129; "Collateral Security Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(130; "Credit Life (Spouse) %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(131; "Credit Life (Non-Spouse)%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(132; "Credit Life Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(133; "BO Loan Write Off Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(134; "BO Loan Number"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(135; "Loan Provision Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Balance Sheet"));
        }
        field(136; "Loan Loss Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));
        }
        field(137; "RM Taget Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(138; "BO Account Update"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(139; "Loan Perfection Charges AC"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Balance Sheet"));
        }
        field(140; "Credit Life  Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        //Added From Cloud Enterprise
        field(141; "USSD Vendor Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }
        field(142; "CFT Subscription Amount"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }
        field(143; "Checkoff Advice Template"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = "Partial Block","Distributed","Full Block","Partial Distributed","Hybrid Distributed";

            OptionCaption = 'Partial Block, Distributed, Full Block, Partial Distributed,Hybrid Distributed';

        }
        field(144; "Block Loans Recovery Mode"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = "Priority","Age","Priority & Age","Age & Priority";
            OptionCaption = 'Priority, Age, Priority & Age, Age & Priority';

        }
        field(145; "Late Notification%"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(146; "Withholding Tax%"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(147; "Maintenance Fee%"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(148; "Registration Fee Account"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));

        }
        field(149; "Checks Activation Fees"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(150; "Activation Fee Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));

        }
        field(151; "Late Notification Fee Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));

        }
        field(152; "Excise Duty Account"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));

        }
        field(153; "Validate Member By ID"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(154; "Is Microfinance"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        //From Cloud Enterprises
        field(165; "Dividends Processing Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(166; "Dividends Payment Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(167; "Shares Dividends Rate%"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(168; "Deposits Interest Rate%"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(169; "Withholding Tax Account Income"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(170; "WHT Account Expense"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(171; "Processing Fee Income"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(172; "Processing Fee Expense"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(173; "Dividend Expenses"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(174; "Use Disbursement Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No","Yes";
            OptionCaption = 'No, Yes';


        }

        //Cash Basis Accounts
        field(175; "Cash Basis Interest Receivable"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }

        field(176; "Cash Basis Interest Income"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(177; "Maximum Noncontribution Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }





    }

    keys
    {
        // key(Key1; "G/L Account")
        // {
        //     Clustered = true;
        // }
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