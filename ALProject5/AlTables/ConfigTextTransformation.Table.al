table 8640 "Config. Text Transformation"
{
    Caption = 'Config. Text Transformation';

    fields
    {
        field(1; "Package Code"; Code[20])
        {
            Caption = 'Package Code';
            NotBlank = true;
            TableRelation = "Config. Package";
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" WHERE ("Object Type" = CONST (Table));

            trigger OnLookup()
            begin
                TableNameLookup;
            end;
        }
        field(3; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            TableRelation = "Config. Package Field"."Field ID" WHERE ("Table ID" = FIELD ("Table ID"));

            trigger OnLookup()
            begin
                FieldLookup;
            end;
        }
        field(4; "Transformation Type"; Option)
        {
            Caption = 'Transformation Type';
            OptionCaption = 'Uppercase,Lowercase,Title Case,Trim,Substring,Replace,Regular Expression,Remove Non-Alphanumeric Characters,Date and Time Formatting';
            OptionMembers = Uppercase,Lowercase,"Title Case",Trim,Substring,Replace,"Regular Expression","Remove Non-Alphanumeric Characters","Date and Time Formatting";
        }
        field(5; "Processing Order"; Integer)
        {
            Caption = 'Processing Order';
        }
        field(6; "Table Name"; Text[250])
        {
            CalcFormula = Lookup (AllObjWithCaption."Object Name" WHERE ("Object Type" = CONST (Table),
                                                                        "Object ID" = FIELD ("Table ID")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
            TableRelation = Field.FieldName WHERE (TableNo = FIELD ("Table ID"));

            trigger OnLookup()
            begin
                FieldLookup;
            end;
        }
        field(10; "Current Value"; Text[250])
        {
            Caption = 'Current Value';
        }
        field(11; "New Value"; Text[250])
        {
            Caption = 'New Value';
        }
        field(15; "Start Position"; Integer)
        {
            BlankZero = true;
            Caption = 'Start Position';

            trigger OnValidate()
            begin
                if "Start Position" <= 0 then
                    Error(MustBeGreaterThanZeroErr);
            end;
        }
        field(16; Length; Integer)
        {
            BlankZero = true;
            Caption = 'Length';

            trigger OnValidate()
            begin
                if Length < 0 then
                    Error(MustBeGreaterThanZeroErr);
            end;
        }
        field(18; Format; Text[30])
        {
            Caption = 'Format';
        }
        field(20; "Language ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Language ID';
            TableRelation = "Windows Language";
        }
        field(21; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }
        field(50; "Last Used Field ID"; Integer)
        {
            CalcFormula = Max ("Config. Text Transformation"."Processing Order" WHERE ("Package Code" = FIELD ("Package Code"),
                                                                                      "Table ID" = FIELD ("Table ID"),
                                                                                      "Field ID" = FIELD ("Field ID")));
            Caption = 'Last Used Field ID';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Package Code", "Table ID", "Field ID", "Processing Order")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        MustBeGreaterThanZeroErr: Label 'The Value entered must be greater than zero.';

    [Scope('Internal')]
    procedure GetLanguageID(): Integer
    begin
        if "Language ID" > 0 then
            exit("Language ID");
        exit(GlobalLanguage);
    end;

    local procedure FieldLookup()
    var
        "Field": Record "Field";
        FieldList: Page "Field List";
    begin
        Clear(FieldList);
        Field.SetRange(TableNo, "Table ID");
        FieldList.SetTableView(Field);
        FieldList.LookupMode := true;
        if FieldList.RunModal = ACTION::LookupOK then begin
            FieldList.GetRecord(Field);
            "Table ID" := Field.TableNo;
            Validate("Field ID", Field."No.");
            Validate("Field Name", Field.FieldName);
        end;
    end;

    local procedure TableNameLookup()
    var
        ConfigValidateManagement: Codeunit "Config. Validate Management";
    begin
        ConfigValidateManagement.LookupTable("Table ID");
        if "Table ID" <> 0 then
            Validate("Table ID");

        CalcFields("Table Name");
    end;
}

