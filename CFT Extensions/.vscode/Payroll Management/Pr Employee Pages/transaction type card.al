page 50424 "Transaction Types Card"
{
    // version Payroll Management v1.0.0

    PageType = Card;
    SourceTable = pr_transaction_types;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Type; Rec.Type)
                {
                }
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
                field(group_order; Rec.group_order)
                {
                    Caption = 'Group Order';
                }
                field(group_title; Rec.group_title)
                {
                    Caption = 'Group Title';
                }
                field(sub_group_order; Rec.sub_group_order)
                {
                    Caption = 'Sub group ORder';
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
                    Caption = 'Amount';
                }
                field(is_percentage; Rec.is_percentage)
                {
                    Caption = 'Is Percentage';
                }
                field(percentage; Rec.percentage)
                {
                    Caption = 'Percentage';
                }
            }
        }
    }

    actions
    {
    }
}

