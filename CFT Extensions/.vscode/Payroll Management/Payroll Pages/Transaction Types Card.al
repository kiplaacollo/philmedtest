page 50424 "Transaction Types Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_transaction_types;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Type; Rec.Type)
                {

                }
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
                field(group_order; Rec.group_order)
                {
                    Caption = 'Group Order';
                }
                field("Group Title Validator"; Rec."Group Title Validator")
                {
                    Caption = 'Group Title';
                }
                field(sub_group_order; Rec.sub_group_order)
                {
                    Caption = 'Sub Group Order';
                }
                field(acc_no; Rec.acc_no)
                {
                    Caption = 'GL Account No';
                }
                field(gl_account_name; Rec.gl_account_name)
                {
                    Caption = 'GL Account Name';
                }
                field(is_mandatory; Rec.is_mandatory)
                {
                    Caption = 'Is Mandatory';
                }
                field(amount; Rec.amount)
                {

                }
                field(is_percentage; Rec.is_percentage)
                {
                    Caption = 'Is Percentage';
                }
                field(percentage; Rec.percentage)
                {

                }
                field(Benefit; Rec.Benefit)
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