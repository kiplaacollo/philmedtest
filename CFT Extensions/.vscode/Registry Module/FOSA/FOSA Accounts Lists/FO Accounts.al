page 50082 "FO Accounts"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    CardPageId = 50083;
    SourceTableView = where("Approval Status" = const(approved), Processed = const(true));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {

                }
                field("Member Number"; Rec."Member Number")
                {

                }
                field(No; Rec.No)
                {

                }
                field("Full Name"; Rec."Full Name")
                {

                }
                field("FO Account Type"; Rec."FO Account Type")
                {

                }
                field("Registration Date"; Rec."Registration Date")
                {

                }
                field("Mobile Number"; Rec."Mobile Number")
                {

                }
                field("Email Address"; Rec."Email Address")
                {

                }
            }
        }
        area(FactBoxes)
        {
            part(CustomerContent; "FO Statistics")
            {
                SubPageLink = "Member Number" = field("Member Number");
            }
            part(Passport; "BO Account Passport")
            {
                SubPageLink = No = field(No);
            }
            part(Signature; "BO Account Signature")
            {
                SubPageLink = No = field(No);
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
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(17);
        rec.SetRange("Member Posting Group", 'fo');
        Rec.FilterGroup(0);
    end;

    var
        myInt: Integer;
}