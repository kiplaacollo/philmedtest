table 50099 "Budgetary Control Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Current Budget Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Enabled = true;
            TableRelation = "G/L Budget Name".Name;

        }
        field(3; "Current Budget Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Enabled = true;
        }
        field(4; "Current Budget End Date"; Date)
        {
            DataClassification = CustomerContent;
            Enabled = true;
        }
        field(5; "Budget Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Enabled = true;
            TableRelation = Dimension;
        }
        field(6; "Budget Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(7; "Budget Dimension 3 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(8; "Budget Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(9; "Budget Dimension 5 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(10; "Budget Dimension 6 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(11; "Analysis View Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Analysis View".Code;
        }
        field(12; "Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(13; "Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(14; "Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(15; "Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(16; Mandatory; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Allow OverExpenditure"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Current Item Budget"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item Budget Name".Name;
        }
        field(19; "Budget Check Criteria"; Boolean)
        {
            DataClassification = CustomerContent;

        }
        field(20; "Actual Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "G/L Entry","Analysis View Entry";
            OptionCaption = 'G/L Entry,Analysis View Entry';
        }
        field(21; "Partial Budgetary Check"; Boolean)
        {
            DataClassification = CustomerContent;
        }



    }

    keys
    {
        key(Key1; "Primary Key")
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