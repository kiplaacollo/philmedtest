pageextension 50116 CustomerListExt extends "Customer List"
{
    layout
    {
        addafter("Phone No.")
        {
            field("Mobile Phone No."; Rec."Mobile Phone No.")
            {
                ApplicationArea = all;
            }
            field("Our Account No."; Rec."Our Account No.")
            {
                ApplicationArea = all;
            }

            field("Route Plan"; Rec."Route Plan")
            {
                ApplicationArea = all;
            }
            field("Customer Region"; Rec."Customer Region")
            {
                ApplicationArea = all;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Payments (LCY)")
        {
            field("Last Payment Date"; Rec."Last Payment Date")
            {
                ApplicationArea = all;
            }

            field(Dormant; Rec.Dormant)
            {
                ApplicationArea = all;
            }
            field("PD Cheques Total"; Rec."PD Cheques Total")
            {
                ApplicationArea = all;
            }
            field("Payroll No."; Rec."Payroll No.")
            {
                ApplicationArea = all;
            }
            field("Account Creation Date"; Rec."Account Creation Date")
            {
                ApplicationArea = all;
            }
        }
        modify("Payment Terms Code")
        {
            Visible = true;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = true;

        }
    }
}
