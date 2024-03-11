// table 50115 "Credit Manager Cue"
// {
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Primary Key"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Primary Key';
//         }
//         field(2; "User ID Filter"; Code[50])
//         {
//             Caption = 'User ID Filter';
//             FieldClass = FlowFilter;
//         }

//         field(3; "Requests to Approve"; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
//                                                         Status = FILTER(Open)));
//         }
//         field(4; "Requests Sent for Approval"; Integer)
//         {
//             CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
//                                                         Status = FILTER(Open)));
//             Caption = 'Requests Sent for Approval';
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1; "Primary Key")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//         // Add changes to field groups here
//     }

//     var
//         myInt: Integer;

//     trigger OnInsert()
//     begin

//     end;

//     trigger OnModify()
//     begin

//     end;

//     trigger OnDelete()
//     begin

//     end;

//     trigger OnRename()
//     begin

//     end;

// }