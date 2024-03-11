page 50151 "Payslip Information"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Payslip;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan Number"; Rec."Loan Number")
                {
                    Editable = false;
                }
                field("Payslip Item"; Rec."Payslip Item")
                {

                }
                field("Payslip Item Type"; Rec."Payslip Item Type")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field(Taxable; Rec.Taxable)
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