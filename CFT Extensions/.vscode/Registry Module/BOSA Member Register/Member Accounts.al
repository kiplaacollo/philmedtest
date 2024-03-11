page 50453 "Member Accounts"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    CardPageId = 50127;
    SourceTableView = where(Processed = const(true), "Approval Status" = const(approved));


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Member Number"; Rec."Member Number")
                {

                }
                field(No; Rec.No)
                {

                }
                field("Full Name"; Rec."Full Name")
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
                field("Employer Code"; Rec."Employer Code")
                {

                }

            }
        }
        area(FactBoxes)
        {
            part(CustomerStatisticsPage; "BO Statistics")
            {
                SubPageLink = "Member Number" = field("Member Number");
            }
            part(BOAccounts; "BO Account Passport")
            {
                SubPageLink = No = field(No);
            }
            part(BOSignature; "BO Account Signature")
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
    // trigger OnOpenPage()
    // begin
    //     Rec.FilterGroup(17);
    //     rec.SetRange("Member Posting Group", 'bo');
    //     Rec.FilterGroup(0);
    // end;

    var
        myInt: Integer;
}