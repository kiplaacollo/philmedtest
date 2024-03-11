table 50448 "Journal Line Dimension"
{

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = AllObj."Object ID" WHERE ("Object Type" = CONST (Table));
        }
        field(2; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Journal Line No."; Integer)
        {
            Caption = 'Journal Line No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Allocation Line No."; Integer)
        {
            Caption = 'Allocation Line No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Dimension;

            trigger OnValidate()
            var
                DimMgt: Codeunit DimensionManagement;
            begin
                if not DimMgt.CheckDim("Dimension Code") then
                    Error(DimMgt.GetDimErr);
                "Dimension Value Code" := '';
            end;
        }
        field(7; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code" = FIELD ("Dimension Code"));

            trigger OnValidate()
            begin
                if not DimMgt.CheckDimValue("Dimension Code", "Dimension Value Code") then
                    Error(DimMgt.GetDimErr);
            end;
        }
        field(8; "New Dimension Value Code"; Code[20])
        {
            Caption = 'New Dimension Value Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code" = FIELD ("Dimension Code"));

            trigger OnValidate()
            begin
                if not DimMgt.CheckDimValue("Dimension Code", "New Dimension Value Code") then
                    Error(DimMgt.GetDimErr);
            end;
        }
    }

    keys
    {
        key(Key1; "Table ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;
}

