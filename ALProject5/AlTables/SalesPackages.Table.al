table 50014 "Sales Packages"
{

    fields
    {
        field(1; "Package Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Sales Code".Code;

            trigger OnValidate()
            begin
                StandardSalesCode.Reset;
                StandardSalesCode.SetRange(Code, "Package Code");
                if StandardSalesCode.Find('-') then begin
                    Description := StandardSalesCode.Description;
                end;
            end;
        }
        field(2; "Total Amount"; Decimal)
        {
            CalcFormula = Sum ("Standard Sales Line"."Amount Excl. VAT" WHERE ("Standard Sales Code" = FIELD ("Package Code")));
            FieldClass = FlowField;
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Total Package Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Portal Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Downgradable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Tarrif ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Default DownGrade"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Sales Code".Code;

            trigger OnValidate()
            begin
                StandardSalesCode.Reset;
                StandardSalesCode.SetRange(Code, "Package Code");
                if StandardSalesCode.Find('-') then begin
                    Description := StandardSalesCode.Description;
                end;
            end;
        }
        field(9; "Can Recieve DownGrade"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                StandardSalesCode.Reset;
                StandardSalesCode.SetRange(Code, "Package Code");
                if StandardSalesCode.Find('-') then begin
                    Description := StandardSalesCode.Description;
                end;
            end;
        }
        field(10; "Can Recieve UPGrade"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                StandardSalesCode.Reset;
                StandardSalesCode.SetRange(Code, "Package Code");
                if StandardSalesCode.Find('-') then begin
                    Description := StandardSalesCode.Description;
                end;
            end;
        }
        field(11; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,DownGrade,UpGrade';
            OptionMembers = " ",DownGrade,UpGrade;
        }
        field(12; "Package +Installation"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; MBs; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "CRM Upgradable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Target Promotion Package"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Standard Sales Code".Code;
        }
    }

    keys
    {
        key(Key1; "Package Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Validate("Package Code");
    end;

    trigger OnModify()
    begin
        Validate("Package Code");
    end;

    var
        StandardSalesCode: Record "Standard Sales Code";
}

