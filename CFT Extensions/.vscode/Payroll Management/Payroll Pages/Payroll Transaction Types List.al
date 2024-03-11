page 50423 "Payroll Transaction Types List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_transaction_types;
    CardPageId = "Transaction Types Card";
    SourceTableView = where(Type = filter("Deduction/Allowance"));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {

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

                }
                field(frequency; Rec.frequency)
                {

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