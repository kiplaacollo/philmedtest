page 50102 "BO Employers"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO Employer";
    Caption = 'Employers';


    layout
    {
        area(Content)
        {
            repeater(Employers)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Code';

                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Associated Customer No"; Rec."Associated Customer No")
                {
                    Caption = 'Associated Customer No';
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