table 5371 "Service Connection Error"
{
    Caption = 'Service Connection Error';

    fields
    {
        field(1; "Code"; Guid)
        {
            Caption = 'Code';
        }
        field(2; "Server Address"; Text[250])
        {
            Caption = 'Dynamics CRM URL';
            TableRelation = "CRM Connection Setup"."Server Address";
        }
        field(3; "Last Occurrence"; DateTime)
        {
            Caption = 'Last Occurrence';
        }
        field(4; Error; BLOB)
        {
            Caption = 'Error';
        }
        field(5; Hash; Integer)
        {
            Caption = 'Hash';
        }
        field(6; "First Occurrence"; DateTime)
        {
            Caption = 'First Occurrence';
        }
        field(7; "Occurrence Count"; Integer)
        {
            Caption = 'Occurrence Count';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Hash)
        {
        }
    }

    fieldgroups
    {
    }

    var
        ConfirmQst: Label 'Are you sure that you want to delete connection failure errors?';

    [Scope('Internal')]
    procedure SetError(ErrorMsg: Text)
    var
        DataStream: OutStream;
    begin
        Clear(Error);
        Error.CreateOutStream(DataStream);
        DataStream.Write(ErrorMsg);
        Modify;
    end;

    [Scope('Internal')]
    procedure GetError() ErrorMsg: Text
    var
        DataStream: InStream;
    begin
        ErrorMsg := '';
        CalcFields(Error);
        if Error.HasValue then begin
            Error.CreateInStream(DataStream);
            DataStream.Read(ErrorMsg);
        end;
    end;

    [Scope('Internal')]
    procedure CanInsertRecord(Error: Text; HostName: Text): Boolean
    var
        HashText: Text;
    begin
        HashText := Format(CreateHash(Error, HostName));
        SetFilter(Hash, HashText);
        exit(not FindSet);
    end;

    [Scope('Internal')]
    procedure DeleteEntries(DaysOld: Integer)
    begin
        if not Confirm(ConfirmQst) then
            exit;
        SetFilter("First Occurrence", '<=%1', CreateDateTime(Today - DaysOld, Time));
        DeleteAll;
    end;

    [Scope('Internal')]
    procedure CreateHash(Error: Text; HostName: Text): Integer
    var
        DotNetString: DotNet String;
    begin
        DotNetString := DotNetString.Concat(HostName, Error);
        DotNetString := DotNetString.ToUpper;
        exit(DotNetString.GetHashCode);
    end;
}

