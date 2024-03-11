tableextension 50010 "Customer Table Ext" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50000; No; code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Description = 'Start of Basic Information';

        }
        field(50001; "First Name"; Text[100])
        {
            DataClassification = CustomerContent;
            NotBlank = true;

        }
        field(50002; "Middle Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50004; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            ;
        }
        field(50007; "KRA Pin"; Code[20])
        {
            DataClassification = ToBeClassified;


        }
        field(50008; "Member Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = A,B;
            OptionCaption = 'A,B';
        }
        field(50009; "Registry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,ReEntrance;
            OptionCaption = 'New,ReEntrance';
        }
        field(50010; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            ;
        }
        field(50011; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50012; "Member Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Customer Posting Group".Code;

        }
        field(50013; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
            editable = false;
            trigger OnValidate()
            begin
                if "Approval Status" = "Approval Status"::Approved then begin
                    "Date Approved" := Today;
                end;
            end;
        }
        field(50014; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50015; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; "Date Processed"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50017; "Member Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; "Monthly Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Activity Code"; Code[20])

        {
            DataClassification = ToBeClassified;

            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

        }
        field(50021; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50022; "Membership Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Application,Active,Dormant,Withdrawal,Inactive;
            OptionCaption = 'Application,Active,Dormant,Withdrawal,Inactive';
        }
        field(50023; "FO No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Front office Information';
        }
        field(50024; "BO No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "BO Accounts"."Member Number";

        }
        field(50025; "FO Account Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Products Setup";
        }
        field(50026; "FO Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Joint,Group,Corporate;
            OptionCaption = 'Single,Joint,Group,Corporate';
        }
        field(50027; "Is Current Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Current Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Is Employed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'End of Basic Information';
        }
        // field(50030; "Address"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'Start of Communication Information';
        // }
        // field(50031; County; Code[50])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "BO County".Code;
        // }
        field(50032; "Mobile Number"; Code[12])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Secondary Mobile Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Workplace Extension"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; Location; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Sub-Location"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; District; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Contact Person"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50039; "Contact Person Phone"; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF StrLen("Contact Person Phone") <> 12 then
                    Error('Contact Person phone No. Can not be more or less than 12 Characters');
            end;
        }
        field(50040; "Contact Person Designation"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'End of Communication Information';
        }
        field(50042; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Personal Information';

        }
        field(50043; Age; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50044; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Male,Female;
        }
        field(50045; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Single,Married;
        }
        field(50046; "Passport Photo"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Signature"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50048; Disabled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Employment Information';
            TableRelation = "BO Employer".Code;

        }
        field(50050; "Employer Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50051; "Department Code"; Code[50])

        {
            DataClassification = ToBeClassified;
            TableRelation = "BO Department".Code;

        }
        field(50052; "Department Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50053; Occupation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Payroll Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Casual,Permanent;
            Description = 'End of Employment Information';
        }
        field(50056; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Audit Information';
        }
        field(50057; "Capture Date Time"; dateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Processed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Processed Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'End of Audit Information';
        }
        field(50060; "Deposit Contribution Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Balances Information';
            Editable = false;
        }
        field(50061; "Share Capital Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50062; "Benevolent Fund Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'End of Balance Information';
        }
        // field(50063; "Date Filter"; Date)
        // {
        //     FieldClass = FlowFilter;
        //     Description = 'Start of Filters';
        // }
        field(50064; "Referee Name"; Code[40])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Referee information';
        }
        field(50065; "Referee ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Referee Mobile Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Bank Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of External Banking Information';
            Editable = false;
        }
        field(50068; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Codes"."Bank Code";
            trigger OnValidate()
            var
                BankCodes: Record "Bank Codes";
            begin
                if BankCodes.Get("Bank Code") then
                    "Bank Name" := BankCodes."Bank Name";
            end;

        }
        field(50069; "Bank Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches Table"."Branch Code" where("Bank Code" = field("Bank Code"));
        }
        field(50070; "Bank Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Bank Branch Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'End of External Banking Information';
        }
        field(50074; "RM Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50075; "RM Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Member Account Type"; enum "BO Enums")
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "New DepositContributionBalance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Deposit Contribution")));
        }
        field(50078; "New Share Capital Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Share Capital")));

        }
        field(50079; "New Benevolent Fund Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Benevolent Fund")));

        }
        field(50080; "Total Outstanding Loan"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = filter("Loan" | "Principal Repayment")));
        }
        field(50081; "Outstanding Interest"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = filter("Interest Due" | "Interest Paid")));
        }
        field(50082; "New FO Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."), "Transaction Type" = const("Fosa Transaction")));

        }
        field(50083; "Referee Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }


    }
    fieldgroups
    {
        addlast(DropDown; "Full Name")
        {

        }
    }

    var
        myInt: Integer;

}