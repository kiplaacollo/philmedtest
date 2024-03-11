page 50127 "BO Account Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    Editable = false;
    SourceTableView = where(Processed = const(true));
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            group("Basic Information")
            {
                field(No; Rec.No)
                {
                    Importance = Promoted;
                }
                field("First Name"; Rec."First Name")
                {

                }
                field("Middle Name"; Rec."Middle Name")
                {

                }
                field("Last Name"; Rec."Last Name")
                {

                }
                field("Full Name"; Rec."Full Name")
                {
                    Importance = Promoted;
                }
                field("Account Name"; Rec."Account Name")
                {

                }
                field("ID Number"; Rec."ID Number")
                {
                    Importance = Promoted;
                }
                field("KRA Pin"; Rec."KRA Pin")
                {

                }
                field("Member Class"; Rec."Member Class")
                {

                }
                field("Registry Type"; Rec."Registry Type")
                {

                }
                field("Application Date"; Rec."Application Date")
                {
                    Importance = Promoted;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Importance = Additional;
                }
                field("Member Posting Group"; Rec."Member Posting Group")
                {

                }
                field("Approval Status"; Rec."Approval Status")
                {

                }
                field(Processed; Rec.Processed)
                {
                    Importance = Additional;
                }
                field("Member Number"; Rec."Member Number")
                {
                    Importance = Additional;
                }
                field("Monthly Deposit Contribution"; Rec."Monthly Deposit Contribution")
                {

                }
                field("Share Capital"; Rec."Share Capital")
                {

                }
                field("Activity Code"; Rec."Activity Code")
                {
                    Importance = Additional;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    Importance = Additional;
                }
                field("Membership Status"; Rec."Membership Status")
                {

                }
                field("Is Employed"; Rec."Is Employed")
                {

                }
            }
            group("Communication Information")
            {
                field(County; Rec.County)
                {

                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    Importance = Promoted;
                }
                field("Workplace Extension"; Rec."Workplace Extension")
                {
                    Importance = Additional;
                }
                field("Email Address"; Rec."Email Address")
                {
                    Importance = Promoted;
                    Style = Favorable;
                }
                field(District; Rec.District)
                {
                    Importance = Additional;
                }
                field(Location; Rec.Location)
                {
                    Importance = Additional;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    Importance = Additional;
                }

                field("Contact Person Phone"; Rec."Contact Person Phone")
                {
                    Importance = Additional;
                }
                field("Contact Person Designation"; Rec."Contact Person Designation")
                {
                    Importance = Additional;
                }
            }
            group("Personal Information")
            {
                field("Date of Birth"; Rec."Date of Birth")
                {
                    Importance = Promoted;
                }
                field(Age; Rec.Age)
                {
                    Importance = Promoted;
                }
                field(Gender; Rec.Gender)
                {

                }
                field("Marital Status"; Rec."Marital Status")
                {

                }
                field(Disabled; Rec.Disabled)
                {

                }

            }
            group("Employment Information")
            {
                Visible = false;
                field("Employer Code"; Rec."Employer Code")
                {

                }
                field("Employer Description"; Rec."Employer Description")
                {
                    Importance = Promoted;
                }
                field("Department Code"; Rec."Department Code")
                {

                }
                field("Department Description"; Rec."Department Description")
                {

                }
                field(Occupation; Rec.Occupation)
                {

                }
                field("Terms of Employment"; Rec."Terms of Employment")
                {

                }
            }
            group("Bank Details")
            {
                field("Bank Code"; Rec."Bank Code")
                {

                }
                field("Bank Name"; Rec."Bank Name")
                {

                }
                field("Bank Branch"; Rec."Bank Branch")
                {

                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {

                }
                // field("Bank Account No"; Rec."Bank Account No")
                // {

                // }
                field("Swift Code"; Rec."Swift Code")
                {

                }
            }
            group("Referee Details")
            {
                field("Referee Name"; Rec."Referee Name")
                {

                }
                field("Referee ID No"; Rec."Referee ID No")
                {

                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {

                }
            }
            group(Kins)
            {
                part(MyKins; "BO Kins")
                {
                    SubPageLink = "BO Application No" = field(No);
                }
            }
            group(Savings)
            {
                part(Savingspart; "Savings Application Listpart")
                {
                    SubPageLink = "BO Application No" = field(No);
                }
            }
            group("Audit Information")
            {
                field("Captured By"; Rec."Captured By")
                {

                }
                field("Capture Date Time"; Rec."Capture Date Time")
                {

                }
                field("Date Approved"; Rec."Date Approved")
                {

                }
                field("Processed By"; Rec."Processed By")
                {

                }
                field("Date Processed"; Rec."Date Processed")
                {

                }
                field("Processed Date Time"; Rec."Processed Date Time")
                {

                }
            }
        }
        area(FactBoxes)
        {
            part(CustomerStatistics; "BO Statistics")
            {
                SubPageLink = "Member Number" = field("Member Number");
            }
            part(BOAccountPassport; "BO Account Passport")
            {
                SubPageLink = No = field(No);
            }
            part(BOAccountSignature; "BO Account Signature")
            {
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Monthly Deductions")

            {
                ApplicationArea = All;
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Member Monthly Deductions";
                RunPageLink = "Client Code" = field("No.");
            }
            action("BO Statement")
            {
                ApplicationArea = All;
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    boaccounts.Reset();
                    boaccounts.SetRange(boaccounts."No.", Rec."No.");
                    if boaccounts.FindFirst() then begin
                        Report.RunModal(Report::"BO Statement", true, false, boaccounts);
                    end;
                end;
            }
            // action("Member Guarantors")
            // {
            //     ApplicationArea = All;
            //     Image = Agreement;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     begin
            //         guarantors.Reset();
            //         guarantors.SetRange(guarantors."Loanee Number", Rec."No.");
            //         if guarantors.FindFirst() then begin
            //             Report.RunModal(Report::Members_guarantors, true, false, guarantors);
            //         end;
            //     end;
            // }
        }

    }

    var
        myInt: Integer;
        boaccounts: Record Customer;
        guarantors: Record "Guarantors Table";
}