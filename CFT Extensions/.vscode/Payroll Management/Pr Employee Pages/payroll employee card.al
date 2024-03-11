page 50427 "Payroll Employee Card"
{
    // version Payroll Management v1.0.0

    PageType = Card;
    SourceTable = pr_employees;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = true;
                field(st_no; Rec.staff_no)
                {
                    Caption = 'Staff No';
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field(Name; Rec.Name)
                {
                    Caption = ' Name';
                }
                field(joining_date; Rec.joining_date)
                {
                    Caption = 'Joining Date';
                }
                field(basic_pay; Rec.basic_pay)
                {
                    Caption = 'Basic Pay';
                }
                field(posting_group; Rec.posting_group)
                {
                    Caption = 'Psoting Group';
                }
                field(employee_email; Rec.employee_email)
                {
                    Caption = 'Employee Email';
                }
                field(department_code; Rec.department_code)
                {
                    Caption = 'Department';
                }
                field(job_group; Rec.job_group)
                {
                    Caption = 'Job Group';
                }
                field(job_title; Rec.job_title)
                {
                    Caption = 'Job Title';
                }
                field(id_no; Rec.id_no)
                {
                    Caption = 'Id Number';
                }
                field(contract_start_date; Rec.contract_start_date)
                {
                    Caption = 'Contract Start Date';
                }
                field(contract_end_date; Rec.contract_end_date)
                {
                    Caption = 'Contract End Date';
                }
                field(status; Rec.status)
                {
                    Caption = 'Status';
                }
            }
            group("Statutory Details")
            {
                Editable = true;
                field(pays_paye; Rec.pays_paye)
                {
                    Caption = 'Pays PAYE';
                }
                field(pays_nssf; Rec.pays_nssf)
                {
                    Caption = 'Pays NSSF';
                }
                field(pays_nhif; Rec.pays_nhif)
                {
                    Caption = 'Pays NHIF';
                }
                field(nssf_no; Rec.nssf_no)
                {
                    Caption = 'NSSF No';
                }
                field(nhif_no; Rec.nhif_no)
                {
                    Caption = 'NHIF No';
                }
                field(pin_no; Rec.pin_no)
                {
                    Caption = 'PIN No';
                }
            }
            group("Payment Information")
            {
                Editable = Editable;
                field(bank_code; Rec.bank_code)
                {
                    Caption = 'Bank Code';
                }
                field(bank_name; Rec.bank_name)
                {
                    Caption = 'Bank Name';
                }
                field(branch_code; Rec.branch_code)
                {
                    Caption = 'Branch Code';
                }
                field(branch_name; Rec.branch_name)
                {
                    Caption = 'Branch Name';
                }
                field(bank_account_no; Rec.bank_account_no)
                {
                    Caption = 'Bank Account No';
                }
            }
            group("Insurance Information")
            {
                Editable = Editable;
                field("Insurance Company"; Rec."Insurance Company")
                {
                }
                field("Policy No"; Rec."Policy No")
                {
                }
                field("Instalment Premium"; Rec."Instalment Premium")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
            }
            group("Morgage Information")
            {
                Caption = 'Morgage Information';
                Editable = Editable;
                field("Finacial Institution"; Rec."Finacial Institution")
                {
                }
                field("Mortgage No"; Rec."Mortgage No")
                {
                }
                field("Mortgage Interest"; Rec."Mortgage Interest")
                {
                }
                field("Mortgage End Date"; Rec."Mortgage End Date")
                {
                }
            }
            group("Pension Information")
            {
                Caption = 'Pension Information';
                Editable = Editable;
                field("Pension Scheme"; Rec."Pension Scheme")
                {
                }
                field("Pension Scheme No"; Rec."Pension Scheme No")
                {
                }
                field("Pension Contribution"; rec."Pension Contribution")
                {
                }
            }
            part("Allowance and Deductions"; "Employee Allowance_Deductions")
            {
                Caption = 'Allowance and Deductions';
                Editable = Editable;
                SubPageLink = st_no = FIELD(staff_no);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if (Rec.status <> Rec.status::active) and (Rec.status <> Rec.status::" ") then
            Editable := false
        else
            Editable := true;
    end;

    trigger OnInit()
    begin
        //if UserSetup.Get(UserId) then
        // if not UserSetup."View Payroll" then
        //  Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
    end;

    var
        Editable: Boolean;
        UserSetup: Record "User Setup";
}

