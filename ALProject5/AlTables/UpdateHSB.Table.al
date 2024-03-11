table 50007 "Update HSB"
{

    fields
    {
        field(1; No; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Churn,Not Paid,Suspended';
            OptionMembers = Active,Churn,"Not Paid",Suspended;
        }
        field(4; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,HSB,Enterprise,EOS,Merchant';
            OptionMembers = " ",HSB,Enterprise,EOS,Merchant;
        }
        field(5; "Date Field"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Package Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

