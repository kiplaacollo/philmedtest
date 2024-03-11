page 52006 "Checkoff Advice Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Checkoff Adv Line";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Client Code"; Rec."Client Code")
                {

                }
                field("Client Name"; Rec."Client Name")
                {

                }
                field("Payroll Number"; Rec."Payroll Number")
                {

                }
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Deduction Code"; Rec."Deduction Code")
                {

                }
                field("Fosa Account No"; Rec."Fosa Account No")
                {

                }
                field("Loan Number"; Rec."Loan Number")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field(Amount; Rec.Amount)
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Allocation")
            {
                ApplicationArea = All;

                RunObject = page "Checkoff Allocation Lines";
                RunPageLink = "No." = field("No."), "Client Code" = field("Client Code");
            }
        }
    }

    var
        myInt: Integer;
}