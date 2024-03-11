page 50060 "Budgetary Control Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Budgetary Control Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Current Budget Code"; Rec."Current Budget Code")
                {

                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {

                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {

                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {

                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {

                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {

                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {

                }
                field("Budget Dimension 5 Code"; Rec."Budget Dimension 5 Code")
                {

                }
                field("Budget Dimension 6 Code"; Rec."Budget Dimension 6 Code")
                {

                }
                field("Analysis View Code"; Rec."Analysis View Code")
                {

                }
                field("Dimension 1 Code"; Rec."Dimension 1 Code")
                {

                }
                field("Dimension 2 Code"; Rec."Dimension 2 Code")
                {

                }
                field("Dimension 3 Code"; Rec."Dimension 3 Code")
                {

                }
                field("Dimension 4 Code"; Rec."Dimension 4 Code")
                {

                }
                field(Mandatory; Rec.Mandatory)
                {

                }
                field("Allow OverExpenditure"; Rec."Allow OverExpenditure")
                {

                }
                field("Current Item Budget"; Rec."Current Item Budget")
                {

                }
                field("Budget Check Criteria"; Rec."Budget Check Criteria")
                {

                }
                field("Actual Source"; Rec."Actual Source")
                {

                }
                field("Partial Budgetary Check"; Rec."Partial Budgetary Check")
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