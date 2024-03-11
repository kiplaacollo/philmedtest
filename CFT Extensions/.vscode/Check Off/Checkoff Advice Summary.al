
page 50212 "Checkoff Summary"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Checkoff Summary Table";
    Editable = false;
    ModifyAllowed = false;

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
                field("Payroll Number"; Rec."Payroll Number")
                {

                }
                field("Registration Fees"; Rec."Registration Fees")
                {

                }
                field("Deposit Contribution"; Rec."Deposit Contribution")
                {

                }
                field("Share Capital"; Rec."Share Capital")
                {

                }
                field("Dev Prin"; Rec."Dev Prin")
                {

                }
                field("Dev Int"; Rec."Dev Int")
                {

                }
                field("Flexi Prin"; Rec."Flexi Prin")
                {

                }
                field("Flexi Int"; Rec."Flexi Int")
                {

                }
                field("Bridge Prin"; Rec."Bridge Prin")
                {

                }
                field("Bridge Int"; Rec."Bridge Int")
                {

                }
                field("Platinum Prin"; Rec."Platinum Prin")
                {

                }
                field("Platinum Int"; Rec."Platinum Int")
                {

                }
                field("Processing Fee"; Rec."Processing Fee")
                {

                }
                field(Ordinary; Rec.Ordinary)
                {

                }
                field(Junior; Rec.Junior)
                {

                }
                field(Total; Rec.Total)
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