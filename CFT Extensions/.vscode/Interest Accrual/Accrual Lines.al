page 50221 "Accrual Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Accrual Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(no; Rec.no)
                {

                }
                field("Client Code"; Rec."Client Code")
                {

                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Payroll Number"; Rec."Payroll Number")
                {

                }
                field("Loan Number"; Rec."Loan Number")
                {

                }
                field("Loan Product"; Rec."Loan Product")
                {

                }
                field("Gl Account"; Rec."Gl Account")
                {

                }
                field("Interest Rate"; Rec."Interest Rate")
                {

                }

                field("Calculation Method"; Rec."Loan Calculation Method")
                {

                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {

                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {

                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {

                }
                field(Amount; Rec.Amount)
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