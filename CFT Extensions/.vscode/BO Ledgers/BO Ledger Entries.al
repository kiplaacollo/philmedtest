// page 50129 "Bo Ledger Entries"
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "BO Ledger Entry";
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     DeleteAllowed = false;

//     layout
//     {
//         area(Content)
//         {
//             repeater(Group)
//             {
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ToolTip = 'Specifies the employee entrys posting date.';
//                 }
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ToolTip = 'Specifies the document type that the employee entry belongs to.';
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ToolTip = 'Specifies the employee entrys document number.';
//                 }
//                 field("BO No"; Rec."BO No")
//                 {
//                     ToolTip = 'Specifies the number of the employee that the entry is linked to.';
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ToolTip = 'Specifies a description of the employee entry.';
//                 }
//                 field("Message to Recipient"; Rec."Message to Recipient")
//                 {
//                     ToolTip = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.';
//                 }
//                 field("Payment Method Code"; Rec."Payment Method Code")
//                 {
//                     ToolTip = 'Specifies the payment method that was used to make the payment that resulted in the entry.';
//                 }
//                 field("Original Amount"; Rec."Original Amount")
//                 {
//                     ToolTip = 'Specifies the amount of the original entry.';
//                 }
//                 field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
//                 {
//                     ToolTip = 'Specifies the amount that the entry originally consisted of, in LCY.';
//                     Visible = false;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     ToolTip = 'Specifies the amount of the entry.';
//                 }
//                 field("Amount (LCY)"; Rec."Amount (LCY)")
//                 {
//                     Visible = false;
//                     ToolTip = 'Specifies the amount of the entry in LCY.';
//                 }
//                 field("Remaining Amount"; Rec."Remaining Amount")
//                 {
//                     ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
//                 }
//                 field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
//                 {
//                     ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
//                 }
//                 field("Bal. Account Type"; Rec."Bal. Account Type")
//                 {
//                     Visible = false;
//                     Editable = false;
//                     ToolTip = 'Specifies the type of balancing account that is used for the entry.';
//                 }
//                 field("Bal. Account No."; Rec."Bal. Account No.")
//                 {
//                     Visible = false;
//                     Editable = false;
//                     ToolTip = 'Specifies the number of the balancing account that is used for the entry.';
//                 }
//                 field(Open; Rec.Open)
//                 {
//                     ToolTip = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.';
//                 }
//                 field("Entry No."; Rec."Entry No.")
//                 {
//                     ToolTip = 'Specifies the entry number that is assigned to the entry.';
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin

//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }