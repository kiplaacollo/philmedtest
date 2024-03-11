table 50121 "BO Accounts"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Basic Information';
            Editable = false;
        }
        field(2; "First Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Middle Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "KRA Pin"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Member Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = A,B;
        }
        field(10; "Registry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,ReEntrance;
        }
        field(11; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Member Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(14; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            trigger OnValidate()
            begin
                if "Approval Status" = "Approval Status"::Approved then begin
                    "Date Approved" := Today;
                end;
            end;
        }
        field(15; "Processed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Date Processed"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Member Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Monthly Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Activity Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(22; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Membership Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Application,Active,Dormant,Withdrawal,Inactive;
        }
        field(25; "FO No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Front office Information';
        }
        field(26; "BO No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(27; "FO Account Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Savings Products Setup";
        }
        field(28; "FO Account Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Joint,Group,Corporate;
        }
        field(29; "Is Current Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Current Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "FO Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Is Employed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'End of Basic Information';
        }
        field(41; Address; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Communication Information';
        }
        field(42; County; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Mobile Number"; Code[12])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Secondary Mobile Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Workplace Extension"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(46; Location; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Sub-Location"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(48; District; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Contact Person"; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50; "Contact Person Phone"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Contact Person Designation"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'End of Communication Information';
        }
        field(61; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Personal Information';
        }
        field(62; Age; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(63; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Male,Female;
        }
        field(64; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Single,Married;
        }
        field(65; "Passport Photo"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(66; Signature; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(80; Disabled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Employer Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Employment Information';
            TableRelation = "BO Employer".Code;
        }
        field(82; "Employer Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(83; "Department Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "BO Employer".Code;
        }
        field(84; "Department Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(85; Occupation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Payroll Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Terms of Employment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Casual,Permanent;
            Description = 'End of Employment Information';
        }
        field(101; "Captured By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Audit Information';
        }
        field(102; "Capture Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(104; "Processed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Processed Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'End of Audit Information';
        }
        field(120; "Deposit Contribution Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Balances Information';
            Editable = false;
        }
        field(121; "Share Capital Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(130; "Benevolent Fund Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'End of Balance Information';
            Editable = false;
        }
        field(131; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Description = 'Start of Filters';
        }
        field(162; "Referee Name"; Code[40])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of Referee information';
            Editable = false;
        }
        field(163; "Referee ID No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(164; "Referee Mobile Phone No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Description = 'End of Referee Information';
        }
        field(185; "Bank Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Start of External Banking Information';
            Editable = false;
        }
        field(186; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(187; "Bank Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(188; "Bank Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(189; "Bank Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Bank Branch Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(200; "Swift Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'End of External Banking Information';
        }
        field(210; "RM Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(211; "RM Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(212; "Application Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Manual,"Apply to Oldest";
        }
    }

    keys
    {
        key(Key1; "Member Number")
        {
            Clustered = true;
        }
        key(Key2; "Full Name")
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Member Number", "Full Name", No)
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    var
        Rec: Record "BO Applications";
        fullname: Codeunit "Full Name";
    begin

        if (Rec.Get(Rec."First Name")) then begin
            fullname.GenerateFullName(Rec);
            Rec.Modify()
        end;

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}