page 50120 "Dispatch Role Center"
{
    Caption = 'Dispatch', Comment = '{Dependency=Match,"ProfileDescription_ORDERPROCESSOR"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control104; "Headline RC Order Processor")
            {
                ApplicationArea = Basic, Suite;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control14; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control4; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control21; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = R;
                ApplicationArea = Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            ToolTip = 'Invoice Tracking & Dispatch Processing.';
            action(SalesOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Invoice Tracking & Dispatch';
                Image = "Order";
                RunObject = Page "Invoice Tracking List";
                ToolTip = 'Invoice Tracking & Dispatch Processing.';
            }
        }
        area(sections)
        {
            group(Action76)
            {
                Caption = 'Invoice Tracking & Dispatch';
                Image = Sales;
                ToolTip = 'Invoice Tracking & Dispatch Processing.';
                action("Tracking & Dispatch")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice Tracking & Dispatch';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Invoice Tracking List";
                    ToolTip = 'Invoice Tracking & Dispatch Processing';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action("Posted Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Open the list of posted sales shipments.';
                }
                //action(Action68)
                //{
                //    ApplicationArea = Location;
                //    Caption = 'Transfer Orders';
                //    Image = FinChargeMemo;
                //    Promoted = true;
                //    PromotedCategory = Process;
                //   RunObject = Page "Transfer Orders";
                //    ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
                //}
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View the posting history for sales, shipments, and inventory.';
                action(Action32)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action(Action34)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action(Action40)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Open the list of posted sales shipments.';
                }
            }

        }
        area(creation)
        {
            //action("Sales &Order")
            // {
            //    ApplicationArea = Basic, Suite;
            //    Caption = 'Sales &Order';
            //    Image = Document;
            //    Promoted = false;
            //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //PromotedCategory = Process;
            //    RunObject = Page "Sales Order";
            //    RunPageMode = Create;
            //    ToolTip = 'Create a new sales order for items or services.';
            //}
        }
        area(processing)
        {
            group(Tasks)
            {
                Caption = 'Tasks';
            }
            group(History)
            {
                Caption = 'History';
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Find entries...';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                }
            }
        }
    }
}

