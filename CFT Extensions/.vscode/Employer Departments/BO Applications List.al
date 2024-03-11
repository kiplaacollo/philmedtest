page 50121 "BO Applications List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Applications";
    CardPageId = 50122;
    Editable = false;
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
            part(Passport; "BO Applications Passport")
            {

            }
            part(Signature; "BO Applications Signature")
            {
                Visible = false;
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
        rec.SetRange("Member Posting Group", 'bo');
        Rec.FilterGroup(0);
    end;

    var
        myInt: Integer;
}