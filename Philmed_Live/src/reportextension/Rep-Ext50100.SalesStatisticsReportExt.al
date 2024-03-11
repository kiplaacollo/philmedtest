reportextension 50100 "Sales Statistics Report Ext" extends "Sales Statistics"
{
    dataset
    {
    }
    trigger OnPreReport()
    var
        lvUserSetup: Record "User Setup";
    begin
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');
    end;
}

reportextension 50101 ECSalesListExt extends "EC Sales List"
{
    dataset
    {
    }
    trigger OnPreReport()
    var
        lvUserSetup: Record "User Setup";
    begin
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');
    end;
}

reportextension 50102 CustomerSalesListExt extends "Customer - Sales List"
{
    dataset
    {
    }
    trigger OnPreReport()
    var
        lvUserSetup: Record "User Setup";
    begin
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');
    end;
}

reportextension 50103 SalesCyleAnalysisExt extends "Sales Cycle - Analysis"
{
    dataset
    {
    }
    trigger OnPreReport()
    var
        lvUserSetup: Record "User Setup";
    begin
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');
    end;
}

reportextension 50104 SalesPersonSalesStatisticsExt extends "Salesperson - Sales Statistics"
{
    dataset
    {
    }
    trigger OnPreReport()
    var
        lvUserSetup: Record "User Setup";
    begin
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');
    end;
}

reportextension 50105 SalesPersonCommissionExt extends "Salesperson - Commission"
{
    dataset
    {
    }
    trigger OnPreReport()
    var
        lvUserSetup: Record "User Setup";
    begin
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');
    end;
}

reportextension 50106 DayBookCustLedgerEntry extends "Day Book Cust. Ledger Entry"
{
    dataset
    {
    }
    trigger OnPreReport()
    var
        lvUserSetup: Record "User Setup";
    begin
        lvUserSetup.Get(UserId);
        if not lvUserSetup."View Sales Analysis Reports" then
            Error('You have no rights to view this report!');
    end;
}
