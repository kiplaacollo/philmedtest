page 50157 "PROCUREMENT MGER Role Center"
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
                action(Stocks)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stocks';
                    Image = Item;
                    RunObject = Page "Item List";
                    ToolTip = 'View or edit detailed information for the Stocks that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action("Stock Ledger Entries")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Stock Ledger Entries';
                    Image = ItemLedger;
                    RunObject = page "Item Ledger Entries";
                }
                action("Inventory Setup")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Inventory setup';
                    Image = InventorySetup;
                    RunObject = page "Inventory Setup";
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
profile "Procurement Manager"
{
    Caption = 'Procurement Manager';
    RoleCenter = "PROCUREMENT MGER Role Center";
}