page 50148 "Credit Control Rolecenter"
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
                action(Customers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    Image = Customer;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action("Customer Ledger Entries")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Customer Ledger Entries';
                    Image = Customer;
                    RunObject = page "Customer Ledger Entries";
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
profile "Credit Control"
{
    Caption = 'Credit Control';
    RoleCenter = "Credit Control Rolecenter";
}