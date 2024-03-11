page 50147 "Credit Officer Rolecenter"
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
                action("Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
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
profile "Credit Officer"
{
    Caption = 'Credit Officer';
    RoleCenter = "Credit Officer Rolecenter";
}