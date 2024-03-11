page 50429 "Employee Allowance_Deductions"
{
    // version Payroll Management v1.0.0

    PageType = ListPart;
    SourceTable = pr_allowances_and_deductions;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(transaction_code; Rec.transaction_code)
                {
                    Caption = 'Transaction Code';
                }
                field(transaction_name; Rec.transaction_name)
                {
                    Caption = 'Transaction Name';
                }
                field(period_code; Rec.period_code)
                {
                    Caption = 'Period code';
                }
                field(amount; Rec.amount)
                {
                    Caption = 'Amount';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        if UserSetup.Get(UserId) then begin
            // if not UserSetup."View Payroll" then
            Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
        end else
            Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
    end;

    trigger OnOpenPage()
    begin
        ObjPeriod.Reset;
        ObjPeriod.SetRange(Active, true);
        if ObjPeriod.Find('-') then
            ObjPeriod.SetRange(period_code, ObjPeriod.period_code);
    end;

    var
        ObjPeriod: Record pr_periods;
        UserSetup: Record "User Setup";
}

