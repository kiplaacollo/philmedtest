page 50428 "Payroll General Setup"
{
    // version Payroll Management v1.0.0

    PageType = Card;
    SourceTable = "Payroll General setup";

    layout
    {
        area(content)
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
    }

    trigger OnInit()
    begin
        if UserSetup.Get(UserId) then begin
            // if not UserSetup."View Payroll" then
            Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
        end else
            Error('You do not have rights to view Payroll. Kindly Contact your System Administrator!!');
    end;

    var
        UserSetup: Record "User Setup";
}

