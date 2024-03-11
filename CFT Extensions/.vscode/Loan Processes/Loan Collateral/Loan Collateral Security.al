page 50155 "Loan Collateral Security"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Loan Collateral Details";
    // AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan No"; Rec."Loan No")
                {
                    Editable = false;
                }
                field("Collateral Document No"; Rec."Collateral Document No")
                {

                }
                field("Registered To"; Rec."Registered To")
                {
                    Editable = false;
                }
                field("Registration No"; Rec."Registration No")
                {
                    Editable = false;
                }
                field("Security Details"; Rec."Security Details")
                {

                }
                field(Type; Rec.Type)
                {

                }
                field(Code; Rec.Code)
                {

                }
                field("New Value"; Rec."New Value")
                {
                    Caption = 'Value';
                }
                field("New Guarantee Value"; Rec."New Guarantee Value")
                {
                    Editable = false;
                    Caption = 'Guarantee Value';
                }
                field("Free Collateral"; Rec."Free Collateral")
                {
                    Editable = false;
                }
                field("Comitted Collateral Value"; Rec."Comitted Collateral Value")
                {

                }
                field("Amount To Commit"; Rec."Amount To Commit")
                {

                }
                field(Category; Rec.Category)
                {
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
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