table 823 "Name/Value Buffer"
{
    Caption = 'Name/Value Buffer';
    ReplicateData = false;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
            DataClassification = SystemMetadata;
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(3; Value; Text[250])
        {
            Caption = 'Value';
            DataClassification = SystemMetadata;
        }
        field(4; "Value BLOB"; BLOB)
        {
            Caption = 'Value BLOB';
            DataClassification = SystemMetadata;
        }
        field(5; "Value Long"; Text[2048])
        {
            Caption = 'Value Long';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Name)
        {
        }
        fieldgroup(Brick; Name, Value)
        {
        }
    }

    var
        TemporaryErr: Label 'The record must be temporary.';

    procedure AddNewEntry(NewName: Text[250]; NewValue: Text)
    var
        NewID: Integer;
    begin
        if not IsTemporary then
            Error(TemporaryErr);

        Clear(Rec);

        NewID := 1;
        if FindLast then
            NewID := ID + 1;

        ID := NewID;
        Name := NewName;
        SetValueWithoutModifying(NewValue);

        Insert(true);
    end;

    procedure GetValue(): Text
    var
        TempBlob: Record TempBlob;
        CR: Text[1];
    begin
        if not "Value BLOB".HasValue then
            exit(Value);
        CR[1] := 10;
        CalcFields("Value BLOB");
        TempBlob.Blob := "Value BLOB";
        exit(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;

    procedure SetValue(NewValue: Text)
    begin
        SetValueWithoutModifying(NewValue);
        Modify;
    end;

    procedure SetValueWithoutModifying(NewValue: Text)
    var
        TempBlob: Record TempBlob;
    begin
        Clear("Value BLOB");
        Value := CopyStr(NewValue, 1, MaxStrLen(Value));
        if StrLen(NewValue) <= MaxStrLen(Value) then
            exit; // No need to store anything in the blob
        if NewValue = '' then
            exit;
        TempBlob.WriteAsText(NewValue, TEXTENCODING::Windows);
        "Value BLOB" := TempBlob.Blob;
    end;
}

