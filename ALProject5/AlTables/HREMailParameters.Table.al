table 50744 "HR E-Mail Parameters"
{

    fields
    {
        field(1; "Associate With"; Option)
        {
            Caption = 'Associate With';
            DataClassification = ToBeClassified;
            OptionCaption = ',Vacancy Advertisements,Interview Invitations,General,HR Jobs,Regret Notification,Reliever Notifications,Leave Notifications,Activity Notifications,Send Payslip Email';
            OptionMembers = ,"Vacancy Advertisements","Interview Invitations",General,"HR Jobs","Regret Notification","Reliever Notifications","Leave Notifications","Activity Notifications","Send Payslip Email";
        }
        field(2; "Sender Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Sender Address"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Recipients; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Subject; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Body; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Body 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; HTMLFormatted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Body 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Body 4"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Body 5"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Associate With")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

