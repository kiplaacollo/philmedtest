page 50428 "Payroll General Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payroll General Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(nssf_bands; Rec.nssf_bands)
                {
                    Caption = 'Use NSSF Bands';
                }
                field(minimum_taxable; Rec.minimum_taxable)
                {
                    Caption = 'Minimum Taxable';
                }
                field("Paying Bank"; Rec."Paying Bank")
                {

                }
                field("Payroll Liabilities Account"; Rec."Payroll Liabilities Account")
                {

                }
                field("NSSF Employer Account"; Rec."NSSF Employer Account")
                {

                }
                field("Maximum Morgage Relief"; Rec."Maximum Morgage Relief")
                {

                }
                field("Maximum Pension Relief"; Rec."Maximum Pension Relief")
                {

                }
                field("Personal Relief"; Rec."Personal Relief")
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
    trigger OnInit()
    begin
        // IF UserSetup.GET(USERID) THEN BEGIN
        //     IF NOT UserSetup."View Payroll" THEN
        //         ERROR('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
        // END ELSE
        //     ERROR('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
    end;

    var
        myInt: Integer;
        UserSetup: Record "User Setup";
}