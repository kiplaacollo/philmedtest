table 50423 "pr_transaction_types"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "trans_name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "amount_reference"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,INCOME,DEDUCTION;
        }
        field(4; taxable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; frequency; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Fixed,Varied;
        }
        field(6; "group_order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "group_title"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "sub_group_order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "acc_no"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";
            begin
                if GLAccount.Get(acc_no) then
                    gl_account_name := GLAccount.Name
                else
                    gl_account_name := '';
            end;
        }
        field(10; "gl_account_name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "is_mandatory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "is_percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "group_no"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Deduction/Allowance",Statutory;
        }
        field(17; Benefit; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Sacco Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Group Title Validator"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = DEDUCTION,ALLOWANCE,BENEFIT;
            trigger OnValidate()
            begin
                group_title := Format("Group Title Validator");
            end;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, trans_name)
        {

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