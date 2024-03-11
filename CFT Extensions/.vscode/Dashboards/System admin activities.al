page 50450 "System Admin Activities"
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
            cuegroup(Group1)
            {
                CuegroupLayout = Wide;
                ShowCaption = false;
                field("Total Members"; Rec."Total Members")
                {
                    ToolTip = 'Specifies total Member Accounts';
                    ApplicationArea = suite;
                }
                field("Total BO Members"; Rec."Total BO Members")
                {
                    ToolTip = 'Specifies total BO Accounts';
                    ApplicationArea = suite;
                    DrillDownPageId = "BO Accounts";
                }
                field("Total FO Members"; Rec."Total FO Members")
                {
                    ToolTip = 'Specifies total FO Accounts';
                    ApplicationArea = suite;
                    DrillDownPageId = "FO Accounts";
                }
            }
            cuegroup("Member Statistics")
            {
                field("Total Member Deposits"; Rec."Total Member Deposits")
                {
                    ApplicationArea = basic, suite;
                    ToolTip = 'Speficies total deposit amount';
                    DrillDownPageId = "Detailed Cust. Ledg. Entries";

                }
                field("Total Share Capital"; Rec."Total Share Capital")
                {
                    ApplicationArea = basic, suite;
                    ToolTip = 'Specifies total share capital amount';
                    DrillDownPageId = "Detailed Cust. Ledg. Entries";
                }
                field("Total Registration Fees"; Rec."Total Registration Fees")
                {
                    ApplicationArea = basic, suite;
                    ToolTip = 'specifies total registration fees amount';
                    DrillDownPageId = "Detailed Cust. Ledg. Entries";
                }
            }
            cuegroup("Loan Statistics")
            {
                field("Total Loan Book"; Rec."Total Loan Book")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Detailed Cust. Ledg. Entries";
                }
                field("Active Loans"; Rec."Active Loans")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Loans List(Posted)";
                }
                field("Expired Loans"; Rec."Expired Loans")
                {
                    ApplicationArea = basic, suite;
                }
                field("Pending Loans"; Rec."Pending Loans")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Loans List(Pending)";
                }
                field("Approved Loans(Unposted)"; Rec."Approved Loans(Unposted)")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Loans List(Approved)";
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