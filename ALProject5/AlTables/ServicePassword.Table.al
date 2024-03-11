table 1261 "Service Password"
{
    Caption = 'Service Password';
    ObsoleteReason = 'The suggested way to store the secrets is Isolated Storage, therefore Service Password will be removed.';
    ObsoleteState = Pending;
    ReplicateData = false;

    fields
    {
        field(1; "Key"; Guid)
        {
            Caption = 'Key';
        }
        field(2; Value; BLOB)
        {
            Caption = 'Value';
        }
    }

    keys
    {
        key(Key1; "Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Key := CreateGuid;
    end;

    procedure SavePassword(PasswordText: Text)
    var
        EncryptionManagement: Codeunit "Encryption Management";
        OutStream: OutStream;
    begin
        if EncryptionManagement.IsEncryptionPossible then
            PasswordText := EncryptionManagement.Encrypt(PasswordText);
        Value.CreateOutStream(OutStream);
        OutStream.Write(PasswordText);
    end;

    procedure GetPassword(): Text
    var
        EncryptionManagement: Codeunit "Encryption Management";
        InStream: InStream;
        PasswordText: Text;
    begin
        CalcFields(Value);
        Value.CreateInStream(InStream);
        InStream.Read(PasswordText);
        if EncryptionManagement.IsEncryptionPossible then
            exit(EncryptionManagement.Decrypt(PasswordText));
        exit(PasswordText);
    end;
}

