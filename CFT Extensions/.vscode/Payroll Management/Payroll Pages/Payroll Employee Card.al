page 50427 "Payroll Employee Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = pr_employees;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(st_no; Rec.st_no)
                {

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
                    Editable = false;
                }
                field(joining_date; Rec.joining_date)
                {
                    ShowMandatory = true;
                    Caption = 'Joining Date';
                }
                field(basic_pay; Rec.basic_pay)
                {
                    Caption = 'Basic Pay';
                }
                field(Retainer; Rec.Retainer)
                {

                }
                field(posting_group; Rec.posting_group)
                {
                    Caption = 'Posting Group';
                }
                field(Supervisor; Rec.Supervisor)
                {

                }
                field(employee_email; Rec.employee_email)
                {
                    Caption = 'Employee Email';
                }
                field(department_code; Rec.department_code)
                {
                    Caption = 'Department';
                }
                field(job_title; Rec.job_title)
                {
                    Caption = 'Job Title';
                }
                field(id_no; Rec.id_no)
                {
                    Caption = 'ID Number';
                }
                field(Gender; Rec.Gender)
                {

                }
                field("Date of Birth"; Rec."Date of Birth")
                {

                }
                field("Nature of Contract"; Rec."Nature of Contract")
                {

                }
                field(contract_start_date; Rec.contract_start_date)
                {
                    Caption = 'Contract Start Date';
                }
                field(contract_end_date; Rec.contract_end_date)
                {
                    Caption = 'Contract End Date';
                }
                field("Probation End Date"; Rec."Probation End Date")
                {

                }
                field("Reason for Separation"; Rec."Reason for Separation")
                {

                }
                field("Last Working Date"; Rec."Last Working Date")
                {

                }
                field(status; Rec.status)
                {
                    ShowMandatory = true;
                }
                field("User ID"; Rec."User ID")
                {

                }
                field("Employee Job Group"; Rec."Employee Job Group")
                {

                }
                field("Office/Field Based"; Rec."Office/Field Based")
                {

                }
                field(Region; Rec.Region)
                {

                }

            }
            group("Statutory Details")
            {
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
                field(Pays_Housing; Rec.Pays_Housing)
                {
                    Caption = 'Pays Housing';
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
                    Caption = 'branch Name';
                }
                field(bank_account_no; Rec.bank_account_no)
                {
                    Caption = 'Bank Account No';
                }
            }
            group("Insurance Information")
            {
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
                field("Financial Institution"; Rec."Financial Institution")
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
                field("Pension Scheme"; Rec."Pension Scheme")
                {

                }
                field("Pension Scheme No"; Rec."Pension Scheme No")
                {

                }
                field("Pension Contribution"; Rec."Pension Contribution")
                {

                }
            }
            group("Employee Allowance Deductions")
            {
                part(employeedeductions; "Employee Allowance_Deductions")
                {
                    SubPageLink = st_no = field(st_no);
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