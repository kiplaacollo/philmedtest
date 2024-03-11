// codeunit 50007 "Gen. Jnl.-Post Lineext2"
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
//     local procedure boledgerentryinsert(var GenJournalLine: Record "Gen. Journal Line")
//     begin
//         if GenJnlLine."Account Type" <> GenJnlLine."Account Type"::Member then
//             exit;
//         boledgerentry.Init();
//         boledgerentry."BO No" := GenJnlLine."Account No.";
//         boledgerentry."Posting Date" := GenJnlLine."Posting Date";
//         boledgerentry."Document Type" := GenJnlLine."Document Type";
//         boledgerentry."Document No." := GenJnlLine."Document No.";
//         boledgerentry.Description := GenJnlLine.Description;
//         boledgerentry."Loan Number" := GenJnlLine."Loan Number";
//         boledgerentry."Amount (LCY)" := GenJnlLine."Amount (LCY)";
//         boledgerentry."Member Posting Group" := GenJnlLine."Posting Group";
//         boledgerentry."Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
//         boledgerentry."Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
//         boledgerentry."Dimension Set ID" := GenJnlLine."Dimension Set ID";
//         boledgerentry."Source Code" := GenJnlLine."Source Code";
//         boledgerentry."Reason Code" := GenJnlLine."Reason Code";
//         boledgerentry."Journal Batch Name" := GenJnlLine."Journal Batch Name";
//         boledgerentry."User ID" := UserId;
//         boledgerentry."Bal. Account Type" := GenJnlLine."Bal. Account Type";
//         boledgerentry."Bal. Account No." := GenJnlLine."Bal. Account No.";
//         boledgerentry."No. Series" := GenJnlLine."Posting No. Series";
//         boledgerentry."UnAllocated Account No" := GenJnlLine."Unallocated Account No";
//         boledgerentry."Paid From Prepayments" := GenJnlLine."Paid From Prepayments";
//         boledgerentry.Insert(true);
//     end;


//     procedure PostMember()
//     begin

//     end;

//     var
//         myInt: Integer;
//         boledgerentry: Record "BO Ledger Entry";
//         GenJnlLine: Record "Gen. Journal Line";
// }