page 50152 "Payslip Summary"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Loans;

    layout
    {
        area(Content)
        {
            group("Payslip Summary")
            {
                field("New Basic Pay"; Rec."New Basic Pay")
                {

                }
                field("New Total Allowance"; Rec."New Total Allowance")
                {

                }
                field("New Gross Salary"; Rec."New Gross Salary")
                {

                }
                field("Taxable Pay"; Rec."Taxable Pay")
                {

                }
                field("New Provident Fund"; Rec."New Provident Fund")
                {

                }
                field("New Satutory Deductions"; Rec."New Satutory Deductions")
                {

                }
                field("New Other Deductions"; Rec."New Other Deductions")
                {

                }
                field(PAYE; Rec.PAYE)
                {

                }
                field("Net Pay"; Rec."Net Pay")
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