page 50442 "HR Leave Types Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HR Leave Types";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field(Days; Rec.Days)
                {

                }
                field("Accrue Days"; Rec."Accrue Days")
                {

                }
                field("Unlimited Days"; Rec."Unlimited Days")
                {

                }
                field(Gender; Rec.Gender)
                {

                }
                field(Balance; Rec.Balance)
                {

                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {

                }
                field("Carry Forward Allowed"; Rec."Carry Forward Allowed")
                {

                }
                field("Inclusive of Non Working Days"; Rec."Inclusive of Non Working Days")
                {

                }
                field("Inclusive of Saturday"; Rec."Inclusive of Saturday")
                {

                }
                field("Inclusive of Sunday"; Rec."Inclusive of Sunday")
                {

                }
                field("Inclusive of Holidays"; Rec."Inclusive of Holidays")
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