page 50426 "Payroll Employees List-Exit"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_employees;
    CardPageId = "Payroll Employee Card";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = where(status = filter(exited));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(st_no; Rec.st_no)
                {
                    Caption = 'No';
                }
                field(Name; Rec.Name)
                {

                }
                field(basic_pay; Rec.basic_pay)
                {
                    Caption = 'Basic Pay';
                }
                field(bank_account_no; Rec.bank_account_no)
                {
                    Caption = 'Bank Account No';
                }
                field(nssf_no; Rec.nssf_no)
                {
                    Caption = 'Nssf No';
                }
                field(nhif_no; Rec.nhif_no)
                {
                    Caption = 'Nhif No';
                }
                field(pin_no; Rec.pin_no)
                {
                    Caption = 'PIN No';
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