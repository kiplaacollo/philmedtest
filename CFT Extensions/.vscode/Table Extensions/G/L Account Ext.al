tableextension 50462 "G/L Account Ext" extends "G/L Account"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Old Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Budget Controlled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Global Dimension 3 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50005; "Global Dimension 4 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50006; "Expense Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Donor Defined Account"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Select if the Account is donor Defined';
        }
        field(50008; Test; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Grant Expense"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(50011; "Resposibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        // field(50012; "Budget Committment"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula=sum(committ)
        // }
        field(50013; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        // field(50014; "Budget Expense"; Decimal)
        // {
        //     FieldClass = FlowField;
        // }
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