page 50084 "Savings Products"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Savings Products Setup";
    CardPageId = 50085;

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
                field("Product Control GL"; Rec."Product Control GL")
                {

                }
                field("Is Default Account"; Rec."Is Default Account")
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