page 50441 "HR Leave Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HR Leave Types";
    CardPageId = "HR Leave Types Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    StyleExpr = true;
                    Style = StandardAccent;
                }
                field(Description; Rec.Description)
                {

                }
                field(Days; Rec.Days)
                {

                }
                field(Gender; Rec.Gender)
                {

                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {

                }
                field("Inclusive of Non Working Days"; Rec."Inclusive of Non Working Days")
                {

                }
                field("Inclusive of Saturday"; Rec."Inclusive of Saturday")
                {
                    Visible = false;
                }
                field("Inclusive of Holidays"; Rec."Inclusive of Holidays")
                {

                }
                field("Upload Required"; Rec."Upload Required")
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