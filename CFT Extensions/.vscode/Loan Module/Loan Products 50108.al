page 50108 "Loan Products"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Products";
    CardPageId = 50109;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {

                }
                field("Min Interest Rate"; Rec."Min Interest Rate")
                {

                }
                field("Max Interest Rate"; Rec."Max Interest Rate")
                {

                }
                field("Max Installments"; Rec."Max Installments")
                {

                }
                field("Activity Code"; Rec."Activity Code")
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