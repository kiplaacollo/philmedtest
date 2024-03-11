page 50080 "FO Applications List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Applications";
    CardPageId = 50081;
    SourceTableView = where(Processed = const(false));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {

                }
                field("Full Name"; Rec."Full Name")
                {

                }
                field("Mobile Number"; Rec."Mobile Number")
                {

                }
                field("Email Address"; Rec."Email Address")
                {

                }
                field("Approval Status"; Rec."Approval Status")
                {

                }
                field(Processed; Rec.Processed)
                {

                }
                field("Member Number"; Rec."Member Number")
                {

                }
            }
        }
        area(FactBoxes)
        {
            part(Passport; "BO Account Passport")
            {

            }
            part(Signature; "BO Applications Signature")
            {

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