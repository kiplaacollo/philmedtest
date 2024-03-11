page 50423 "Payroll Transaction Types List"
{
    // version Payroll Management v1.0.0

    CardPageID = "Transaction Types Card";
    PageType = List;
    SourceTable = pr_transaction_types;
    SourceTableView = WHERE(Type = FILTER("Deduction/Allowance"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("code"; Rec.code)
                {
                    Caption = 'Code';
                }
                field(trans_name; Rec.trans_name)
                {
                    Caption = 'Transaction Name';
                }
                field(amount_reference; Rec.amount_reference)
                {
                    Caption = 'Reference';
                }
                field(taxable; Rec.taxable)
                {
                    Caption = 'Taxable';
                }
                field(frequency; Rec.frequency)
                {
                    Caption = 'Frequency';
                }
                field(acc_no; Rec.acc_no)
                {
                    Caption = 'GL Account No';
                }
                field(gl_account_name; Rec.gl_account_name)
                {
                    Caption = 'GL Account Name';
                }
                field(group_order; Rec.group_order)
                {
                    Caption = 'Group Order No';
                }
                field(sub_group_order; Rec.sub_group_order)
                {
                    Caption = 'Subgroup Order No';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Process Payroll")
            {
                Image = Planning;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //
                end;
            }
        }
    }

    trigger OnInit()
    begin
        if UserSetup.Get(UserId) then begin
            // if not UserSetup."View Payroll" then
            Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
        end else
            Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
    end;

    var
        UserSetup: Record "User Setup";
}

