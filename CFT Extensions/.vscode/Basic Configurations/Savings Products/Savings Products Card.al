page 50085 "Savings Products Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Savings Products Setup";


    layout
    {
        area(Content)
        {
            group("General Information")
            {
                field(Code; Rec.Code)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Global Dimension 1"; Rec."Global Dimension 1")
                {

                }
                field("Account Prefix"; Rec."Account Prefix")
                {

                }
                field("Product Code"; Rec."Product Code")
                {

                }
                field("Minimum Balance"; Rec."Minimum Balance")
                {

                }
                field("Maximum Deposit Amount"; Rec."Maximum Deposit Amount")
                {

                }
                field("Maximum Withdrawable Amount"; Rec."Maximum Withdrawable Amount")
                {

                }
            }
            group("Checks and Controls")
            {
                field("Is Default Account"; Rec."Is Default Account")
                {

                }
                field("Is Current Account"; Rec."Is Current Account")
                {

                }
                field("Can Earn Interest"; Rec."Can Earn Interest")
                {

                }
                field("Requires Initial Deposit"; Rec."Requires Initial Deposit")
                {

                }
                field("Can Allow Loan Application"; Rec."Can Allow Loan Application")
                {

                }
                field("Can Fix Deposit"; Rec."Can Fix Deposit")
                {

                }
                field("Requires Closure Notice"; Rec."Requires Closure Notice")
                {

                }
            }
            group("Product Duration Controls")
            {
                field("Dormancy Period(M)"; Rec."Dormancy Period(M)")
                {

                }
                field("Minimum Savings Duration"; Rec."Minimum Savings Duration")
                {

                }
                field("Minimum Interest Period"; Rec."Minimum Interest Period")
                {

                }
                field("Minimum Withdrawal Period"; Rec."Minimum Withdrawal Period")
                {

                }
                field("Closure Notice Period"; Rec."Closure Notice Period")
                {

                }
            }
            group("Fees and Commissions")
            {
                field("Interest Rate"; Rec."Interest Rate")
                {

                }
                field("Account Opening Deposit"; Rec."Account Opening Deposit")
                {

                }
                field("Tax on Interest %"; Rec."Tax on Interest %")
                {

                }
                field("Maintenance Fee"; Rec."Maintenance Fee")
                {

                }
                field("Re-activation Fee"; Rec."Re-activation Fee")
                {

                }
                field("Pre-Mature Withdrawal Fee"; Rec."Pre-Mature Withdrawal Fee")
                {

                }
            }
            group("G/L Accounts")
            {
                field("Product Control GL"; Rec."Product Control GL")
                {

                }
            }
            group(Audit)
            {
                field("Modified by"; Rec."Modified by")
                {

                }
                field("Date Modified"; Rec."Date Modified")
                {

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