page 50430 "Payroll Statutory Transactions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_transaction_types;
    SourceTableView = where(Type = filter(Statutory));
    CardPageId = "Transaction Types Card";

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
                    Caption = 'Group Order';
                }
                field(sub_group_order; Rec.sub_group_order)
                {
                    Caption = 'Subgroup Order';
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
    // trigger OnInit()
    // begin
    //     IF UserSetup.GET(USERID) THEN BEGIN
    //         IF NOT UserSetup."View Payroll" THEN
    //             ERROR('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
    //     END ELSE
    //         ERROR('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
    // end;

    var
        myInt: Integer;
        UserSetup: Record "User Setup";
}