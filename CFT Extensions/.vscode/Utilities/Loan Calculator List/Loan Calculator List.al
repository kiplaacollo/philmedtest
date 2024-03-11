page 50178 "Loan Calculator List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Calculator";
    Editable = false;
    CardPageId = "Loan Calculator";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {

                }
                field("Calculator Type"; Rec."Calculator Type")
                {

                }
                field("Loan Type"; Rec."Loan Type")
                {

                }
                field("Product Description"; Rec."Product Description")
                {

                }
                field("Interest Rate"; Rec."Interest Rate")
                {

                }
                field("Loan Tenure"; Rec."Loan Tenure")
                {

                }
                field("Requested Amount"; Rec."Requested Amount")
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