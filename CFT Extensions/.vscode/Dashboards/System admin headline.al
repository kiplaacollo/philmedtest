page 50451 "System Admin Headline"
{
    PageType = HeadlinePart;
    ApplicationArea = All;
    UsageCategory = Administration;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(Greeting)
            {
                Visible = IsGreetingTextVisible;
                ShowCaption = false;
                field(GreetingText; RcpageHeadlineCommon.GetGreetingText())
                {
                    ApplicationArea = basic, suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        RcpageHeadlineCommon.HeadlineOnOpenPage(Page::"System Admin Headline");
        IsGreetingTextVisible := RcpageHeadlineCommon.IsUserGreetingVisible();
    end;

    var
        myInt: Integer;
        RcpageHeadlineCommon: Codeunit "RC Headlines Page Common";
        IsGreetingTextVisible: Boolean;
}