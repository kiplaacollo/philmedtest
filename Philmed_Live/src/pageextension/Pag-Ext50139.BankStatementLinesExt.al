pageextension 50139 "Bank Statement Lines Ext" extends "Bank Acc. Reconciliation Lines"
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."View Sales Analysis Reports" then
            CurrPage.Editable := false;
    end;
}

