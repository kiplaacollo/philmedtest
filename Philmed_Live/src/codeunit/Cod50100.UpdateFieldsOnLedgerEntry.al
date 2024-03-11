codeunit 50100 UpdateFieldsOnLedgerEntry
{
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesHeader(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header")
    Var

    begin
        ItemJnlLine."Route Plan" := SalesHeader."Route Plan";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    Var
        RoutePlan: Record "Route Plan";
        RouteGroup: Record "Route Group";
    begin
        NewItemLedgEntry."Route Plan" := ItemJournalLine."Route Plan";

        //Route group code and Route group Sales Person
        if ItemJournalLine."Route Plan" <> '' then begin
            RoutePlan.SetRange(Code, ItemJournalLine."Route Plan");
            if RoutePlan.FindFirst() then begin
                If RoutePlan."Route Group" <> '' then begin
                    RouteGroup.SetRange("Route Group Code", RoutePlan."Route Group");
                    if RouteGroup.FindFirst() then begin
                        NewItemLedgEntry."Route Group" := RouteGroup."Route Group Code";
                        NewItemLedgEntry."Route Group SalesPerson" := RouteGroup."Salesperson Code";
                    end;
                end;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitValueEntry', '', false, false)]
    local procedure OnAfterInitValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; var ValueEntryNo: Integer; ItemLedgEntry: Record "Item Ledger Entry")
    Var
        RoutePlan: Record "Route Plan";
        RouteGroup: Record "Route Group";
    begin
        ValueEntry."Route Plan" := ItemJournalLine."Route Plan";

        //Route group code and Route group Sales Person
        if ItemJournalLine."Route Plan" <> '' then begin
            RoutePlan.SetRange(Code, ItemJournalLine."Route Plan");
            if RoutePlan.FindFirst() then begin
                If RoutePlan."Route Group" <> '' then begin
                    RouteGroup.SetRange("Route Group Code", RoutePlan."Route Group");
                    if RouteGroup.FindFirst() then begin
                        ValueEntry."Route Group" := RouteGroup."Route Group Code";
                        ValueEntry."Route Group SalesPerson" := RouteGroup."Salesperson Code";
                    end;
                end;
            end;
        end;
    end;

    //Bank Account Block Balances Below Zero for some banks
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnAfterBankAccLedgEntryInsert', '', false, false)]
    local procedure OnPostBankAccOnAfterBankAccLedgEntryInsert(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account")
    var
        Bank: Record "Bank Account";
    begin
        Bank.Get(BankAccount."No.");
        if Bank."Block Balances Below Zero" then begin
            Bank.CalcFields("Balance (LCY)");
            if Bank."Balance (LCY)" < 0 then
                Error('Bank Account Balance for %1 cannot be Negative! Please check your Transactions', Bank."No.");
        end;
    end;

    //Prevent Posting Transfer Shipment with no authorization
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeTransferOrderPostShipment', '', true, false)]
    local procedure OnBeforeTransferOrderPostShipment(var TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    var
        TransferUserMatrix: Record "Inventory Transfer User Matrix";
        TransferUserMatrix2: Record "Inventory Transfer User Matrix";
    begin
        TransferUserMatrix.SETRANGE("User ID", USERID);
        IF TransferUserMatrix.FINDFIRST THEN BEGIN
            TransferUserMatrix2.SETRANGE("User ID", USERID);
            TransferUserMatrix2.SETRANGE("Transfer Type", TransferUserMatrix2."Transfer Type"::Ship);
            TransferUserMatrix2.SETRANGE("Location Code", TransferHeader."Transfer-from Code");
            IF NOT TransferUserMatrix2.FINDFIRST THEN
                ERROR('Your are not authorised to Ship Inventory FROM the Location %1', TransferHeader."Transfer-from Code");
        END;
    end;

    //Prevent Posting Transfer Receipt with no authorization
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransferOrderPostReceipt', '', true, false)]
    local procedure OnBeforeTransferOrderPostReceipt(var TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    var
        TransferUserMatrix: Record "Inventory Transfer User Matrix";
        TransferUserMatrix2: Record "Inventory Transfer User Matrix";
    begin
        TransferUserMatrix.SETRANGE("User ID", USERID);
        IF TransferUserMatrix.FINDFIRST THEN BEGIN
            TransferUserMatrix2.SETRANGE("User ID", USERID);
            TransferUserMatrix2.SETRANGE("Transfer Type", TransferUserMatrix2."Transfer Type"::Receive);
            TransferUserMatrix2.SETRANGE("Location Code", TransferHeader."Transfer-to Code");
            IF NOT TransferUserMatrix2.FINDFIRST THEN
                ERROR('Your are not authorised to Receive Inventory INTO the Location %1', TransferHeader."Transfer-to Code");
        END;
    end;

    //Bank Account Recon Yes/No
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Recon. Post (Yes/No)", 'OnBeforeBankAccReconPostYesNo', '', false, false)]
    local procedure OnBeforeBankAccReconPostYesNo(var BankAccReconciliation: Record "Bank Acc. Reconciliation"; var Result: Boolean; var Handled: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Post Bank Reconciliation" then
            Error('You have NO Rights to Post Bank Reconciliation');
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", 'OnBeforeInitPost', '', false, false)]
    local procedure OnBeforeInitPost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Post Bank Reconciliation" then
            Error('You have NO Rights to Post Bank Reconciliation');
    end;
}
