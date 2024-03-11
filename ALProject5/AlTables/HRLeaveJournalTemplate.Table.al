table 50441 "HR Leave Journal Template"
{

    fields
    {
        field(1; Name; Code[20])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Test Report ID"; Integer)
        {
            Caption = 'Test Report ID';
            DataClassification = ToBeClassified;
            TableRelation = Object.ID WHERE (Type = CONST (Report));
        }
        field(6; "Form ID"; Integer)
        {
            Caption = 'Form ID';
            DataClassification = ToBeClassified;
            TableRelation = Object.ID WHERE (Type = CONST (Page));
        }
        field(7; "Posting Report ID"; Integer)
        {
            Caption = 'Posting Report ID';
            DataClassification = ToBeClassified;
            TableRelation = Object.ID WHERE (Type = CONST (Report));
        }
        field(8; "Force Posting Report"; Boolean)
        {
            Caption = 'Force Posting Report';
            DataClassification = ToBeClassified;
        }
        field(10; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(11; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(13; "Test Report Name"; Text[80])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE ("Object Type" = CONST (Report),
                                                                           "Object ID" = FIELD ("Test Report ID")));
            Caption = 'Test Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Form Name"; Text[80])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE ("Object Type" = CONST (Page),
                                                                           "Object ID" = FIELD ("Form ID")));
            Caption = 'Form Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Posting Report Name"; Text[80])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE ("Object Type" = CONST (Report),
                                                                           "Object ID" = FIELD ("Posting Report ID")));
            Caption = 'Posting Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

