page 50110 "Payslip Items Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payslip Items Setup Table";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Payslip Item"; Rec."Payslip Item")
                {
                    Enabled = true;
                }
                field("Payslip Item Type"; Rec."Payslip Item Type")
                {
                    Enabled = true;
                }
                field(Taxable; Rec.Taxable)
                {
                    Enabled = true;
                }
                field(Default; Rec.Default)
                {
                    Enabled = true;
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