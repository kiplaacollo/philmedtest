page 50452 "Sacco Activities"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "System admin cue table";
    RefreshOnActivate = true;
    Caption = 'Activities';

    layout
    {
        area(Content)
        {
            cuegroup("MEMBERSHIP CUE")
            {

                field("Active Members"; Rec."Active Members")
                {
                    Caption = 'ACTIVE MEMBERS';
                    DrillDownPageId = "Member Accounts";
                }
                field("Dormant Members"; Rec."Dormant Members")
                {
                    Caption = 'DORMANT MEMBERS';
                    DrillDownPageId = "Member Accounts";
                }
                field("Non-Active Members"; Rec."Non-Active Members")
                {
                    Caption = 'NON-ACTIVE MEMBERS';
                    DrillDownPageId = "Member Accounts";
                }
                field("Deceased Members"; Rec."Deceased Members")
                {
                    Caption = 'DECEASED MEMBERS';
                    DrillDownPageId = "Member Accounts";
                }
                field("Withdrawn Members"; Rec."Withdrawn Members")
                {
                    Caption = 'WITHDRAWN MEMBERS';
                    DrillDownPageId = "Member Accounts";
                }
            }
            cuegroup("ACCOUNT CATEGORIES")
            {
                field("Female Members"; Rec."Female Members")
                {
                    Caption = 'FEMALE MEMBERS';
                    DrillDownPageId = "Member Accounts";
                }
                field("Male Members"; Rec."Male Members")
                {
                    Caption = 'MALE MEMBERS';
                    DrillDownPageId = "Member Accounts";
                }
                field("Cooporate Members"; Rec."Cooporate Members")
                {
                    Caption = 'COOPORATE MEMBERS';
                    DrillDownPageId = "Member Accounts";
                }
            }
            cuegroup("BACK OFFICE LOANS")
            {
                field("Normal Loans"; Rec."Normal Loans")

                {
                    Caption = 'NORMAL LOANS';
                    DrillDownPageId = "Loans List(Posted)";
                }
                field("Emergency Loans"; Rec."Emergency Loans")
                {
                    Caption = 'EMERGENCY LOANS';
                    DrillDownPageId = "Loans List(Posted)";
                }
                field("School Fees Loan"; Rec."School Fees Loan")
                {
                    Caption = 'SCHOOL FEES LOANS';
                    DrillDownPageId = "Loans List(Posted)";

                }
            }
            cuegroup("FRONT OFFICE LOANS")
            {
                field("Advance 1A"; Rec."Advance 1A")
                {
                    Caption = 'ADVANCE 1A';
                    DrillDownPageId = "Loans List(Posted)";
                }
                field("Advance 1B"; Rec."Advance 1B")
                {
                    Caption = 'ADVANCE 1B';
                    DrillDownPageId = "Loans List(Posted)";
                }
                field("Advance 1C"; Rec."Advance 1C")
                {
                    Caption = 'ADVANCE 1C';
                    DrillDownPageId = "Loans List(Posted)";
                }
                field("Salary in Advance"; Rec."Salary in Advance")
                {
                    Caption = 'SALARY IN ADVANCE';
                    DrillDownPageId = "Loans List(Posted)";
                }
                field("Fosa Loan"; Rec."Fosa Loan")
                {
                    Caption = 'FOSA LOAN';
                    DrillDownPageId = "Loans List(Posted)";
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Set up Cues")
            {
                ApplicationArea = All;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';
                trigger OnAction()
                var
                    CuesAndKpis: Codeunit "Cues And KPIs";
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.get then begin
            Rec.Init();
            Rec.Insert()
        end;
    end;


    var
        myInt: Integer;
}