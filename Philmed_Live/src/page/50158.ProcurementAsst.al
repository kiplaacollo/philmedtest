page 50158 "PROCUREMENT Asst Role Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(RoleCenter)
        {
            part(systemadminheadline; "Credit Admin Headline")
            {
                ApplicationArea = basic, suite;
            }

            part(MyUserTasks; "User Tasks Activities")
            {
                ApplicationArea = basic, suite;
            }

        }
    }

    actions
    {
        area(Sections)
        {


            group(Activities)
            {
                action(Processing_LPO)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Processing LPO';
                    Image = Purchase;
                    RunObject = Page "Purchase Order List";
                    ToolTip = 'View or edit detailed information for the Stocks that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }

            }

        }
        area(Processing)
        {


        }
        area(Embedding)
        {

        }

    }

    var
        myInt: Integer;
}
profile "Procurement Assistant"
{
    Caption = 'Procurement Manager';
    RoleCenter = "PROCUREMENT MGER Role Center";
}