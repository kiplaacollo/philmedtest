codeunit 50101 "MPESA SQLConnection"
{
    trigger OnRun()
    begin
        SQLConnection();
    end;

    local procedure SQLConnection()
    var
        DatabaseName: Text;
        DatabaseConnectionString: Text;
    begin
        DatabaseName := 'mpesadb';
        IF HASTABLECONNECTION(TABLECONNECTIONTYPE::ExternalSQL, DatabaseName) THEN
            UNREGISTERTABLECONNECTION(TABLECONNECTIONTYPE::ExternalSQL, DatabaseName);

        DatabaseConnectionString := 'Server=169.239.252.132;Database=mpesadb;User ID=mpesauser;Password=mpesaUser123!';

        REGISTERTABLECONNECTION(TABLECONNECTIONTYPE::ExternalSQL, DatabaseName, DatabaseConnectionString);

        SETDEFAULTTABLECONNECTION(TABLECONNECTIONTYPE::ExternalSQL, DatabaseName);
    end;
}
