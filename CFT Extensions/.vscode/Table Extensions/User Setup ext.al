tableextension 50461 "User Setup Ext" extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Staff Travel Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50002; "Post JVs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Post Bank Rec"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "User Signature"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "View Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Create Vote"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Cancel Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Create Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Allow Registration Reversal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Can Allow Exam Attendance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Allow Neg. Amt Student Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Payroll User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Access Disciplinary Details"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Client Login"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'This Makes the client Application editable and have a view of all the clients Associated with the RMs if one has this right.';
        }
        field(50016; "Credit Management"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'For Loan Processing.This will filter to individual loans if one does not have this right.';
        }
        field(50017; "Mark Rejected Loans"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "InterClient Offset"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Post Disbursement Conditions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Send Notifications"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "IT Administration"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Lead Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Client Login Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Credit Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}