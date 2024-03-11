pageextension 50110 SalesPersonPurchaserExt extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter("Global Dimension 2 Code")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }

        }
        addafter("Job Title")
        {
            field("Daily Sales Target Amount"; Rec."Daily Sales Target Amount")
            {
                ApplicationArea = all;
            }
            field("Daily Customers Target"; Rec."Daily Customers Target")
            {
                ApplicationArea = all;
            }
        }

        addafter("Privacy Blocked")
        {
            // field(Blocked; Rec.Blocked)
            // {
            //      ApplicationArea = all;
            //  }
        }

    }
}

pageextension 50133 SalesPeopleListExt extends "Salespersons/Purchasers"
{
    layout
    {
        addafter(Name)
        {
            field("Daily Sales Target Amount"; Rec."Daily Sales Target Amount")
            {
                ApplicationArea = all;
            }
            field("Daily Customers Target"; Rec."Daily Customers Target")
            {
                ApplicationArea = all;
            }
        }
        addafter("Commission %")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
        }

        addafter("Privacy Blocked")
        {
            // field(Blocked; Rec.Blocked)
            // {
            //      ApplicationArea = all;
            // }
        }

    }
}