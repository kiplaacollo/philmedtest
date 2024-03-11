page 50105 "Notifications Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Notifications Setup";

    layout
    {
        area(Content)
        {
            repeater("Notifications Setup")
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Code';

                }
                field("Notification Type"; Rec."Notification Type")
                {
                    Caption = 'Notification Type';
                }
                field(Message; Rec.Message)
                {
                    Caption = 'Message';
                }
                field("Is Active"; Rec."Is Active")
                {
                    Caption = 'Is Active';
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