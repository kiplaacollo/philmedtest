page 50185 "Collateral Register List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Collateral Register";
    CardPageId = "Collateral Register Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {

                }
                field("Registration No"; Rec."Registration No")
                {

                }
                field("Registered To"; Rec."Registered To")
                {

                }
                field(Type; Rec.Type)
                {

                }
                field("Member Name"; Rec."Member Name")
                {

                }
                field("Security Details"; Rec."Security Details")
                {

                }
                field("New Book Value"; Rec."New Book Value")
                {
                    Caption = 'Book Value';
                }
                field("Guarantee Value"; Rec."Guarantee Value")
                {

                }
                field("New Comitted Collateral Value"; Rec."New Comitted Collateral Value")
                {
                    Caption = 'Comitted Collateral Value';
                }
                field("Free Collateral"; Rec."Free Collateral")
                {

                }
                field(Code; Rec.Code)
                {

                }
                field(Category; Rec.Category)
                {

                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field("Expiry Date"; Rec."Expiry Date")
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