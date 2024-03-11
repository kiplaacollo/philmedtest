page 50429 "Employee Allowance_Deductions"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_allowances_and_deductions;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(transaction_code; Rec.transaction_code)
                {

                }
                field(transaction_name; Rec.transaction_name)
                {

                }
                field(amount; Rec.amount)
                {

                }
                field(period_code; Rec.period_code)
                {

                }
                field("Sacco Deduction"; Rec."Sacco Deduction")
                {
                    Enabled = false;
                    Editable = false;
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
    trigger OnOpenPage()
    BEGIN
        ObjPeriod.Reset();
        ObjPeriod.SetRange(Active, true);
        if ObjPeriod.Find('-') then
            Rec.setrange(period_code, ObjPeriod.period_code);
    END;

    var
        myInt: Integer;
        ObjPeriod: Record pr_periods;
}