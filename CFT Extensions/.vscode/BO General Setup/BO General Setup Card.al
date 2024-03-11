page 50101 "BO General Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO General Setup";

    layout
    {
        area(Content)
        {
            group("General Information")
            {
                field("Institution Founding Date"; Rec."Institution Founding Date")
                {
                    ApplicationArea = All;
                }
                field("Recovery Since Founding Date"; Rec."Recovery Since Founding Date")
                {
                    ApplicationArea = All;
                }
                field("Go Live Date"; Rec."Go Live Date")
                {
                    ApplicationArea = All;
                }

                // field("Max Non Contribution Period"; Rec."Max Non Contribution Period")
                // {
                //     ApplicationArea = All;
                // }
                field("Maximum Noncontribution Period"; Rec."Maximum Noncontribution Period")
                {

                }
                field("Min Deposit Contribution"; Rec."Min Deposit Contribution")
                {
                    ApplicationArea = All;
                }
                field("Min Share Capital Contribution"; Rec."Min Share Capital Contribution")
                {
                    ApplicationArea = All;
                }
                field("Monthly Insurance Contribution"; Rec."Monthly Insurance Contribution")
                {
                    ApplicationArea = All;
                }
                field("Benevolent Contribution"; Rec."Benevolent Contribution")
                {
                    ApplicationArea = All;
                }
                field("Min Existence Period"; Rec."Min Existence Period")
                {
                    ApplicationArea = All;
                }
                field("Min Member Age"; Rec."Min Member Age")
                {
                    ApplicationArea = All;
                }
                field("Max Member Age"; Rec."Max Member Age")
                {
                    ApplicationArea = All;
                }
                field("Min Loan Share Ratio"; Rec."Min Loan Share Ratio")
                {
                    ApplicationArea = All;
                }
                field("Days for Checkoff"; Rec."Days for Checkoff")
                {
                    ApplicationArea = All;
                }
                field("Default Customer Posting Group"; Rec."Default Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Default Micro Credit Posting G"; Rec."Default Micro Credit Posting G")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = All;
                }

                field("Default BO Activity Code"; Rec."Default BO Activity Code")
                {
                    ApplicationArea = All;
                }

                field("Maximum Profitability Margin"; Rec."Maximum Profitability Margin")
                {
                    ApplicationArea = All;
                }
                field("Loan Provision Account"; Rec."Loan Provision Account")
                {
                    ApplicationArea = All;
                }
                field("Loan Loss Account"; Rec."Loan Loss Account")
                {
                    ApplicationArea = All;
                }
                field("Loan Perfection Charges AC"; Rec."Loan Perfection Charges AC")
                {
                    ApplicationArea = All;
                }
                field("USSD Vendor Account"; Rec."USSD Vendor Account")
                {
                    ApplicationArea = All;
                }
                field("Checkoff Advice Template"; Rec."Checkoff Advice Template")
                {
                    ApplicationArea = All;
                }
                field("Add Loan Charges"; Rec."Add Loan Charges")
                {
                    ApplicationArea = All;
                }
                field("Is paid via Mpesa"; Rec."Is Paid Via Mpesa")
                {
                    ApplicationArea = All;
                }
                field("Accept Negative Interest Payments"; Rec."Accept Negative Int Payments")
                {
                    ApplicationArea = All;
                }
                field("Block Loans Recovery Mode"; Rec."Block Loans Recovery Mode")
                {
                    ApplicationArea = All;
                }
                field("Late Notification%"; Rec."Late Notification%")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax%"; Rec."Withholding Tax%")
                {
                    ApplicationArea = All;
                }
                field("Maintenance Fee%"; Rec."Maintenance Fee%")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee Account"; Rec."Registration Fee Account")
                {
                    ApplicationArea = All;
                }
                field("Checks Activation Fees"; Rec."Checks Activation Fees")
                {
                    ApplicationArea = All;
                }
                field("Activation Fee Account"; Rec."Activation Fee Account")
                {
                    ApplicationArea = All;
                }
                field("Late Notification Fee Account"; Rec."Late Notification Fee Account")
                {
                    ApplicationArea = All;
                }
                field("Excise Duty Account"; Rec."Excise Duty Account")
                {
                    ApplicationArea = All;
                }
                field("Validate Member By ID"; Rec."Validate Member By ID")
                {
                    ApplicationArea = All;
                }
                field("Is Microfinance"; Rec."Is Microfinance")
                {
                    ApplicationArea = All;
                }

                field("Majority Members Employed"; Rec."Majority Members Employed")
                {
                    ApplicationArea = All;
                }

            }
            group("BackOffice Numbers")
            {
                field("Defaulter Loan Nos"; Rec."Defaulter Loan Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Application Nos"; Rec."BO Application Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Receipt Nos"; Rec."BO Receipt Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Loan Nos"; Rec."BO Loan Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Loan Number"; Rec."BO Loan Number")
                {
                    ApplicationArea = All;

                }
                field("BO Transfers Nos"; Rec."BO Transfers Nos")
                {
                    ApplicationArea = All;

                }
                field("BO exit Nos"; Rec."BO exit Nos")
                {
                    ApplicationArea = All;

                }
                field("BO CheckOff Nos"; Rec."BO CheckOff Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Loan Batch Nos"; Rec."BO Loan Batch Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Nos"; Rec."BO Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Loan Disbursement Nos"; Rec."BO Loan Disbursement Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Member Receipt"; Rec."BO Member Receipt")
                {
                    ApplicationArea = All;

                }
                field("BO Bulk Receipt"; Rec."BO Bulk Receipt")
                {
                    ApplicationArea = All;

                }
                field("BO Interest Accrual Nos"; Rec."BO Interest Accrual Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Loan Write Off Nos"; Rec."BO Loan Write Off Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Account Update"; Rec."BO Account Update")
                {
                    ApplicationArea = All;

                }

            }
            group("Collateral Numbers")
            {
                field("Collateral Security Nos"; Rec."Collateral Security Nos")
                {
                    ApplicationArea = All;

                }

            }

            group("Front Office Numbers")
            {
                field("FO Cashier Transactions Nos"; Rec."FO Cashier Transactions Nos")
                {
                    ApplicationArea = All;

                }
                field("FO Treasury Nos"; Rec."FO Treasury Nos")
                {
                    ApplicationArea = All;

                }
                field("FO Loans Nos"; Rec."FO Loans Nos")
                {
                    ApplicationArea = All;

                }
                field("FO Standing Orders Nos"; Rec."FO Standing Orders Nos")
                {
                    ApplicationArea = All;

                }
                field("FO ATM Applications Nos"; Rec."FO ATM Applications Nos")
                {
                    ApplicationArea = All;

                }
                field("FO Salary processing Nos"; Rec."FO Salary processing Nos")
                {
                    ApplicationArea = All;

                }
                field("FO Loan Batch Nos"; Rec."FO Loan Batch Nos")
                {
                    ApplicationArea = All;

                }

            }
            group("Savings Transaction Nos ")
            {
                field("Savings Application Nos"; Rec."Savings Application Nos")
                {
                    ApplicationArea = All;

                }
                field("Savings Accounts Nos"; Rec."Savings Account Nos")
                {
                    ApplicationArea = All;

                }
                field("FO Interest Nos"; Rec."FO Interest Nos")
                {
                    ApplicationArea = All;

                }

            }

            group("Dividend Processing")
            {
                field("Dividends Processing Nos"; Rec."Dividends Processing Nos")
                {
                    ApplicationArea = All;

                }
                field("Dividends Payment Nos"; Rec."Dividends Payment Nos")
                {
                    ApplicationArea = All;

                }
                field("Shares Dividends Rate%"; Rec."Shares Dividends Rate%")
                {
                    ApplicationArea = All;

                }
                field("Deposits Interest Rate%"; Rec."Deposits Interest Rate%")
                {
                    ApplicationArea = All;

                }
                field("WHT Account Income"; Rec."Withholding Tax Account Income")
                {
                    ApplicationArea = All;

                }
                field("WHT Account Expense"; Rec."WHT Account Expense")
                {
                    ApplicationArea = All;

                }
                field("Processing Fee Income"; Rec."Processing Fee Income")
                {
                    ApplicationArea = All;

                }
                field("Processing Fee Expense"; Rec."Processing Fee Expense")
                {
                    ApplicationArea = All;

                }
                field("Dividends Expenses"; Rec."Dividend Expenses")
                {
                    ApplicationArea = All;

                }
                field("Use Disbursement Account Type"; Rec."Use Disbursement Account Type")
                {
                    ApplicationArea = All;

                }

            }
            group("Cash Basis Accounts")
            {
                field("Cash Basis Interest Receivable"; Rec."Cash Basis Interest Receivable")
                {
                    ApplicationArea = All;

                }
                field("Cash Basis Interest Income"; Rec."Cash Basis Interest Income")
                {
                    ApplicationArea = All;

                }

            }
            group("Customer Relation Management")
            {
                field("CRM Lead Nos"; Rec."CRM Lead Nos")
                {
                    ApplicationArea = All;

                }
                field("CRM Potential Opportonity Nos"; Rec."CRM Potential Opportonity Nos")
                {
                    ApplicationArea = All;

                }
                field("CRM Client Log In Nos"; Rec."CRM Client Log In Nos")
                {
                    ApplicationArea = All;

                }
                field("RM Taget Nos"; Rec."RM Taget Nos")
                {
                    ApplicationArea = All;

                }
                field("Credit Life  Nos"; Rec."Credit Life  Nos")
                {
                    ApplicationArea = All;

                }

            }


            group("Investment Numbers")
            {
                field("INV Investor Nos"; Rec."INV Investor Nos")
                {
                    ApplicationArea = All;

                }
                field("INV Property Nos"; Rec."INV Property Nos")
                {
                    ApplicationArea = All;

                }
                field("INV Project Nos"; Rec."INV Project Nos")
                {
                    ApplicationArea = All;

                }

            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}