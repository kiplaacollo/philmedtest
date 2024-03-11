page 50149 "Fin Receivables Rolecenter"
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
                action("Cash Receipt Journals")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Cash Receipt Journals';
                    RunObject = page "Cash Receipt Journal";

                }
                action("Payment Journals")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Payment Journals';
                    RunObject = page "Payment Journal";
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
profile "FIN Receivables"
{
    Caption = 'FIN Receivables';
    RoleCenter = "Fin Receivables Rolecenter";
}