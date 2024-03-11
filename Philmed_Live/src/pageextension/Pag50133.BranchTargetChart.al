page 50133 BranchTargetChart
{
    ApplicationArea = All;
    Caption = 'BranchTargetChart';
    PageType = CardPart;
    SourceTable = "Sales Invoice Header";

    layout
    {
        area(content)
        {
            usercontrol(BranchChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = basic, suite;

                trigger AddInReady()
                begin
                    updatechart();
                end;

                trigger Refresh()
                begin
                    updatechart();
                end;
            }


        }
    }
    actions
    {
        area(Processing)
        {
            action("Chart Setup")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Caption = 'Daily Branch Target';
                Image = Setup;
                trigger OnAction()
                begin
                    Page.RunModal(Page::"Sales Manager Role Center");
                    updatechart();
                end;

            }
        }
    }
    var
        rr: Query Branch_Target_Report;

    local procedure updatechart()
    begin
        rr.Read();
        //   Update(CurrPage.BranchChart);
    end;
}

