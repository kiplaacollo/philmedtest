table 50141 Guarantors
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(2; "Loan Number"; Code[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(3; "Loanee Number"; Code[100])
        // Replaced With New Loanee Number
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'Number of the Loan applicant';
        }
        field(4; "Loanee Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Editable = false;
            Description = 'Applicants Total Deposits amount as at the time of appraisal';
        }
        field(5; "Loanee Current Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'Applicants Total Deposits amount as at TODAY or Date Filter';
        }
        field(6; "Guarantor Number"; Code[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'Number of the guarantor to the applicant';
            trigger OnValidate()
            var
                ObjBOAccount: Record "BO Accounts";
                ObjLoan: Record Loans;
                ObjLoanProducts: Record "Loan Products";

            begin
                if ObjBOAccount.Get("Guarantor Number") then
                    "Guarantor Full Name" := ObjBOAccount."Full Name";
                "ID Number" := ObjBOAccount."Full Name";
                "Phone No" := ObjBOAccount."ID Number";
                "Email Address" := ObjBOAccount."Email Address";
                if ObjLoan.get("Loan Number") then begin

                end;


            end;
        }
        field(7; "Guarantor Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Guarantors Total Deposits amount as at the time of appraisal';
            Enabled = true;
        }
        field(8; "Guarantor Current Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'Guarantors Total Deposits amount as at TODAY or Date Filter';
        }
        field(9; "Guaranteed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'The Total Shares The guarantor has agreed to guarantee a member.MUST be less or equal to Total Guarantor shares';
        }
        field(10; "Is Self Guarantee"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'If the Guarantor Number is equal to the Loanee Number, this field is automatically checked.it should be readonly field';
            Editable = false;
        }
        field(11; "Is Substituted"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'if the Guarantor is subsituted, this field is checked.Readonly';
            Editable = false;
        }
        field(12; "Is a Substitute"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'If a new guarantor added a substitute, this field is checked.Readonly';
            Editable = false;
        }
        field(13; "Substitution Date"; Date)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'The Date a Subsitution is effected';
        }
        field(14; "Outstanding Loan Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'The Balance of the Loan as at Filtered Date';
        }
        field(15; "Is Cleared"; Boolean)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
            Description = 'If a Loan is Cleared. This field is automatically checked.';

        }
        field(16; "Loanee Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(17; "Guarantor Full Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(40; "Date Filter"; Date)
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(41; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(42; "Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(43; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Enabled = true;
        }
        field(44; "New Loanee Number"; Code[100])
        // Replaced Loanee Number
        {
            FieldClass = FlowField;
            CalcFormula = lookup(loans."Member Number" where("Loan Number" = field("Loan Number")));
            Editable = false;
        }


    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}