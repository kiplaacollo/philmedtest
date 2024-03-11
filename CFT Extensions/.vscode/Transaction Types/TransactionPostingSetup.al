page 50999 "Transation Posting Setup"
{
    Caption = 'Transation Posting Setup';
    PageType = List;
    SourceTable = "Transation types table";
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(Content)
        {
            repeater(control1)
            {
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = All;

                }
                field("Posting Group Code"; rec."Posting Group Code")
                {
                    ApplicationArea = all;
                }
                field("Loan Product Code"; Rec."Loan Product Code")
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}


