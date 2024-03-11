page 50140 "Loans List(New)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Loans;
    CardPageId = 50141;
    SourceTableView = where("Approval Status" = const(Open));


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan Number"; Rec."Loan Number")
                {

                }
                field("Member Number"; Rec."Member Number")
                {

                }
                field("Full Name"; Rec."Full Name")
                {

                }
                field("Loan Product"; Rec."Loan Product")
                {

                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("System Recommended Amount"; Rec."System Recommended Amount")
                {
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Application Date"; Rec."Application Date")
                {

                }
                field("Created By"; Rec."Created By")
                {

                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Appraisal Report")
            {
                ApplicationArea = All;

                RunObject = report LoanApraisalReport;
            }
        }
    }

    var
        myInt: Integer;
}