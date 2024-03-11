// table 50738 "HR Employee Requisitions"
// {
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(2; "Job ID"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             NotBlank = true;
//         }
//         field(3; "Requisition Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4; Priority; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = High,Medium,Low;
//         }
//         field(5; Positions; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(6; Approved; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(7; "Date Approved"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(8; "Job Description"; Text[200])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(9; Stage; Code[20])
//         {
//             FieldClass = FlowFilter;
//         }
//         field(10; Score; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(11; "Stage Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(12; Qualified; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(13; "Job Supervisor/Manager"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(14; "Global Dimension 2 Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
//         }
//         field(17; "Turn Around Time"; Integer)
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(21; "Grace Period"; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(25; Closed; Boolean)
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(26; "Requisition Type"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = ,Internal,External,Both;
//         }
//         field(27; "Closing Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(28; status; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = New,"Pending Approval",Approved;
//             Editable = false;
//         }
//         field(38; "Required Positions"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(39; "Vacant Positions"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(3949; "Reason for Request(other)"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3950; "Any Additional Information"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3958; "Job Grade"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(3964; "Type of Contract Required"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3965; "Reason for Request"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = "New Vacancy",Replacement,Retirement,Retrenchment,Demise,Other;
//         }
//         field(3966; Requestor; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(3967; "No. Series"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3968; "Requisition No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3969; "Responsibility Center"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Responsibility Center".Code;
//         }
//         field(3970; "Shortlisting Comitte"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(Key1; "Job ID")
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