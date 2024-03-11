page 50128 "BO Statistics"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    Caption = 'Customer Statistics';

    layout
    {
        area(Content)
        {
            group("Basic Contributions")
            {
                field("New DepositContributionBalance"; Rec."New DepositContributionBalance")
                {
                    Caption = 'Deposit Contribution Balance';
                }
                field("New Share Capital Balance"; Rec."New Share Capital Balance")
                {
                    Caption = 'Share Capital';
                }
                field("New Benevolent Fund Balance"; Rec."New Benevolent Fund Balance")
                {
                    Caption = 'Benevolent Fund Balance';
                }
            }
            group("Loan Statistics")
            {
                field("Total Outstanding Loan"; Rec."Total Outstanding Loan")
                {

                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
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