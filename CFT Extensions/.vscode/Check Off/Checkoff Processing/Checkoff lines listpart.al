page 50217 "Checkoff Lines Listpart"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Checkoff Lines Table";

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
                field("Phone No"; Rec."Phone No")
                {

                }
                field("Fosa Account"; Rec."Fosa Account")
                {

                }
                field("Payroll Number"; Rec."Payroll Number")
                {

                }
                field("ID Number"; Rec."ID Number")
                {

                }
                field("Member Found"; Rec."Member Found")
                {

                }
                field("Employer Code"; Rec."Employer Code")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field(Allocated; Rec.Allocated)
                {

                }
                field(Unallocated; Rec.Unallocated)
                {

                }
                field("Remitted Amount"; Rec."Remitted Amount")
                {

                }
                field(Variance; Rec.Variance)
                {

                }
                field(Reconciled; Rec.Reconciled)
                {

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

    var
        myInt: Integer;
}