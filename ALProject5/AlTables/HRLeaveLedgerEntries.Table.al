table 50439 "HR Leave Ledger Entries"
{
    DrillDownPageID = "HR Leave Ledger Entries";
    LookupPageID = "HR Leave Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Leave Period"; Code[20])
        {
            Caption = 'Leave Period';
            DataClassification = ToBeClassified;
        }
        field(3; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = ToBeClassified;
        }
        field(4; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
        }
        field(5; "Staff Name"; Text[70])
        {
            Caption = 'Staff Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Leave Entry Type"; Option)
        {
            Caption = 'Leave Entry Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Positive,Negative,Reimbursement';
            OptionMembers = Positive,Negative,Reimbursement;
        }
        field(8; "Leave Approval Date"; Date)
        {
            Caption = 'Leave Approval Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(10; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Table0.Field4;
        }
        field(12; "Job Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Table55622.Field23;
        }
        field(13; "Contract Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "No. of days"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'No. of days';
        }
        field(15; "Leave Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Leave Posting Description"; Text[50])
        {
            Caption = 'Leave Posting Description';
            DataClassification = ToBeClassified;
        }
        field(17; "Leave End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Leave Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(22; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE ("Use As In-Transit" = CONST (false));
        }
        field(23; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("User ID");
            end;
        }
        field(24; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(25; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
        }
        field(26; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(27; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
            DataClassification = ToBeClassified;
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(29; "Leave Recalled No."; Code[20])
        {
            Caption = 'Leave Application No.';
            DataClassification = ToBeClassified;
            TableRelation = "Hr Leave Application"."Application Code" WHERE ("Employee No" = FIELD ("Staff No."),
                                                                             Status = CONST (Approved));
        }
        field(30; "Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Hr Leave Types".Code;
        }
        field(31; "Medical Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Claim Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Inpatient,Outpatient;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

